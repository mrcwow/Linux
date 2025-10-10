# Cross-platform script using PowerShell 6+ (tested on 7+)
# Runs PowerShell code on Windows
# and Bash code on Linux.

if ($IsWindows) {
	
	# PowerShell code here for Windows

} elseif ($IsLinux) {

	$s = @'
# Bash code here for Linux
'@
	
	# Remove carriage returns for Unix compatibility
	$s1 = $s -replace "`r",""
	
	# Execute Bash code
	bash -c "$s1"

} else {
	
	# Using elseif ($IsMacOS) one can create a branch for MacOS
	Write-Output "Other OS`n"

}
