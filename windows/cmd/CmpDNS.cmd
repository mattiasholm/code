@ECHO OFF
REM Syntax: CmpDNS [domain] [type]
:loop
cls
nslookup -q=%2 %1 8.8.8.8
PAUSE
cls
nslookup -q=%2 %1 ns1.donator.se
PAUSE
goto loop