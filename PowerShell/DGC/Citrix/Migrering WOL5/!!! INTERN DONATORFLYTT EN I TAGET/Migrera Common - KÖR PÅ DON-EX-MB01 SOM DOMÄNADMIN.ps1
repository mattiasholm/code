$OUname = "Donator"
$OldCommonPath = "\\emcat.com\public\hosting\donator\Common"



$OUPath = "\\emcat.com\wo\customers\"
$SourcePath = $OldCommonPath
$DestinationPath = "$OUPath$OUname\Common\"

robocopy $SourcePath $DestinationPath /e /z /B /copy:DATSOU /R:0