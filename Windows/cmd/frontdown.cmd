@ECHO OFF
REM frontdown.cmd, backup-kommando som använder sig av xcopy.
IF /I "%1"=="/n" GOTO Normal
GOTO Skip
:Normal
xcopy /H /E /Y /O /K /F /R /I /G %2 %3
attrib -A "%2"\* /S
GOTO End
:Skip

IF /I "%1"=="/k" GOTO Kopiering
GOTO Skip
:Kopiering
xcopy /H /E /Y /O /K /F /R /I /G %2 %3
GOTO End
:Skip

IF /I "%1"=="/d" GOTO Differentiell
GOTO Skip
:Differentiell
xcopy /A /H /E /Y /O /K /F /R /I /G %2 %3
GOTO End
:Skip

IF /I "%1"=="/i" GOTO Inkrementell
GOTO Skip
:Inkrementell
xcopy /M /H /E /Y /O /K /F /R /I /G %2 %3
GOTO End
:Skip


IF /I "%1"=="/t" GOTO Daglig
GOTO Skip
:Daglig
xcopy /D:%date% /H /E /Y /O /K /F /R /I /G %2 %3
GOTO End
:Skip

IF /I "%1"=="/H" GOTO Help
GOTO Skip
:Help

echo. && echo FRONTDOWN [/N /K /D /I /T /H] source destination && echo.
echo /N		Normal. Arkivflaggan spelar ingen roll f�r vilka filer som kopieras, men arkivflaggan sl�cks.

echo /K		Kopiering. Arkivflaggan spelar ingen roll f�r vilka filer som kopieras och arkivflaggan �ndras ej.

echo /D		Differentiell. Tar endast filer med arkivflaggan satt, men arkivflaggan �ndras ej.

echo /I		Inkrementell. Tar endast filer med arkivflaggan satt och arkivflaggan sl�cks.

echo /T		Daglig. P�verkas inte av och p�verkar inte arkivflaggan. Tar filer som har dagens datum som �ndringsdatum.

echo /H		Help.

echo source		Backup source folder.

echo destination	Backup destination folder.

GOTO End
:Skip
echo. && echo Syntax:
echo FRONTDOWN [/N /K /D /I /T /H] source destination && echo.
echo Enter FRONTDOWN /h for additional help.&& echo.

:End