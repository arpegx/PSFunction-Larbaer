function Sort-FileBySize{
	<#
		.SYNOPSIS
			Sort files by size.
		
		.PARAMETER Unit
			Unit in which the size of files is displayed.
			
		.PARAMETER Path
			Path to the directory you want to check.
	#>

	#Parameter
	[CmdletBinding()]
	param(
		[ValidateSet("kb", "mb", "gb")]
		[string]$Unit = "mb",
		
		[Parameter(
		ValueFromPipeline=$True,
		ValueFromPipelineByPropertyName=$True,
		HelpMessage="Please enter a valid path."
		)]
		[string]$Path = "$PWD"
	)

	# Run Script : Pipeline
	Get-ChildItem 	-LiteralPath "$Path" |
	Sort-Object 	-Property Length -Descending |
	Select-Object 	-Property Name, @{Name="$Unit"; Expression={$_.Length /"1$Unit"}}
}