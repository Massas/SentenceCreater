
function Get-Word {
	param ()
	Write-Host "[Get-Word] START"
	$count = $wordsarr.Count
	
	if($count -ge 2){
		$wordnum = Get-Random -Maximum $count -Minimum 0
	}elseif ($count -eq 1) {
		$wordnum = 0
	}else {
		Write-Host "There is no data!"
		return $null
	}
	$word = $wordsarr[$wordnum]
	Write-Host "word: $word"
	Write-Host "[Get-Word] END"
	return $word
}

function Get-Sentence {
	param (
		[array]$modelworkarr
	)
	Write-Host "[Create-Sentence] START"
	$wordcount = $modelworkarr[1]
	Write-Host "wordcount: $wordcount"

	$modelstr = $modelworkarr[0]
	$tmp = $modelstr

	for($cnt = 0; $cnt -lt $wordcount;){
		$word = Get-Word
		$str = $tmp -replace "w$cnt", $word
		$tmp = $str
		Write-Host "str: $str"
		$cnt++
	}

	$retstr = $str -replace " ", ""

	Write-Host "[Create-Sentence] END"
	return $retstr
}
function Get-Model {
	param ()
	Write-Host "[Get-Model] START"

	$count = $modelarr.Count
	
	if($count -ge 2){
		$modelnum = Get-Random -Maximum $count -Minimum 0
	}elseif ($count -eq 1) {
		$modelnum = 0
	}else {
		Write-Host "There is no data!"
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
$wordsfile = "./words.csv"
$partition = "==========================="

$modelarr = Get-Content -LiteralPath $modelfile -Encoding UTF8
Set-Variable -name $modelarr -Option Constant
$words = Get-Content -LiteralPath $wordsfile -Encoding UTF8
$wordsarr = $words -split ','
Set-Variable -name $wordsarr -Option Constant

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
		$modelworkarr = $modelarr[$modelnum] -split ','
		$modelstr = $modelworkarr[0]
		Write-Host "model: $modelstr"
		"model: $modelstr" | Add-Content $logfile -Encoding UTF8

		# choise words and create sentence
		$str = Get-Sentence($modelworkarr)
		Write-Host "str created: $str"
		"str created: $str" | Add-Content $logfile -Encoding UTF8
	}else {
		$date = Get-Date
		Write-Host "terminate this program ($date)"
		Start-Sleep 1
		exit
	}   
}