function Get-FileByDate{
	<#
		.SYNOPSIS
			Searches for Files, regarding to the last date of writing.
			
		.DESCRIPTION
			Displays the Files according to the date of LastWriteTime,
			either before, after or exact on an given date.
			
		.PARAMETER Date
			Date in Format YYYY-MM-DD according to ISO 8601.
			
		.PARAMETER Range
			Decide to search for Files with an Date of LastWriteTime before,
			after or exact on Date defined by Parameter-Value.
			
		.PARAMETER Path
			Path to the directory you want to check.
	#>

	# Parameter
	[CmdletBinding()]
	param(
		[Parameter(
			ValueFromPipeline=$True,
			ValueFromPipelineByPropertyName=$True,
			HelpMessage="Please enter a valid date."
			)]
		[ValidateScript({Get-Date $_ -UFormat "%Y-%m-%d"})]	# ISO 8601
		[datetime]$Date,
		
		[ValidateSet("previous", "equal", "following")]
		[string]$Range = "following",
		
		[Parameter(
			ValueFromPipelineByPropertyName=$True,
			HelpMessage="Please enter a valid path."
			)]
		[string]$Path = "$PWD"
	)

	# Run Script
	switch($Range){
		"following"	{
			Get-Childitem 	-Recurse -LiteralPath $Path |
			Where-Object 	{$_.LastWriteTime.Date -gt $Date} |
			Select-Object 	-Property Name, LastWriteTime |
			Sort-Object 	-Property LastWriteTime
		}
		
		"equal"	{
			Get-Childitem 	-Recurse -LiteralPath $Path |
			Where-Object	{$_.LastWriteTime.Date -eq $Date} |
			Select-Object 	-Property Name, LastWriteTime |
			Sort-Object 	-Property LastWriteTime
		}
		
		"previous"	{
			Get-Childitem 	-Recurse -LiteralPath $Path |
			Where-Object 	{$_.LastWriteTime.Date -lt $Date} |
			Select-Object 	-Property Name, LastWriteTime |
			Sort-Object 	-Property LastWriteTime
		}
	}
}