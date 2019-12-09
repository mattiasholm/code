$OUname = "Leroy"
$OldCommonPath = "\\emcat.com\public\wol3_slow\Leroy\Gemensam"



$OUPath = "\\emcat.com\wo\customers\"
$SourcePath = $OldCommonPath
$DestinationPath = "$OUPath$OUname\Common\"

robocopy $SourcePath $DestinationPath /e /z /B /copy:DATSOU /R:0