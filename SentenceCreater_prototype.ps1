
function Get-Model {
	param ()
	Write-Host "[Get-Model] START"

	$count = $modelarr.Count
	
	if($count -ge 2){
		$modelnum = Get-Random -Maximum $count -Minimum 0
	}elseif ($count -eq 1) {
		$modelnum = 0
	}else {
		Write-Host "There is no data store file!"
		return $null
	}
	Write-Host "modelnum: $modelnum"
	Write-Host "[Get-Model] END"
	return $modelnum
}
	
# main function

# global variables
$logfile = "./logfile.log"
$modelfile = "./CentenceModel.csv"
$partition = "==========================="

$modelarr = Get-Content -LiteralPath $modelfile -Encoding UTF8
Set-Variable -name $modelarr -Option Constant

while ($true) {
	Write-Host ""
	Write-Host "[[MAIN FUNCTION]]"
	Write-Host "mode is below."
	Write-Host "quit : q"
	Write-Host "create sentence : other"

	$partition | Add-Content $logfile -Encoding UTF8

	$select = Read-Host "<<MODE SELECT>>"
	if(($select -ne 'q') -or ($select -ne 'Q')){
		# create sentence
		$modelnum = Get-Model
		$modelwork = $modelarr[$modelnum] -split ','
		$modelstr = $modelwork[0]
		Write-Host "model: $modelstr"
		"model: $modelstr" | Add-Content $logfile -Encoding UTF8
	}else {
		$date = Get-Date
		Write-Host "terminate this program ($date)"
		Start-Sleep 1
		exit
	}   
}