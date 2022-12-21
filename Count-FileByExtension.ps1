function Count-FileByExtension{
	<#
		.SYNOPSIS
			Counts files according to it's extension.
		
		.DESCRIPTION
			Function excepts a path to a directory and an extension,
			so it counts the occurence of files identified by this pattern.
			
		.PARAMETER Extension
			Extension of files you are searching for.
			
		.PARAMETER Path
			Path to the directory you want to check.
	#>

	# Parameter
	[CmdletBinding()]
	param(
		[Parameter(
			Mandatory=$True,
			ValueFromPipeline=$True,
			ValueFromPipelineByPropertyName=$True,
			HelpMessage="Please enter a valid extension."
			)]
		[string]$Extension,
		
		[Parameter(
			ValueFromPipeline=$True,
			ValueFromPipelineByPropertyName=$True,
			HelpMessage="Please enter a valid path."
			)]
		[string]$Path = "$PWD"
	)

	# Run Script
	(	# Searches for Files with given extension
		Get-Childitem -LiteralPath "$Path" |
		Where-Object -Property Name -Match "$Extension$"
	).count	# Count the number of found Files
}