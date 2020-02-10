REM Exempel f�r att byta lokalt kontonamn:
wmic UserAccount where Name="Kalle Anka" call rename name="Janne Långben"



REM Exempel för att lista samtliga anv�ndarkonton:
wmic UserAccount



REM Exempel för att disabla ett användarkonto:
wmic useraccount where name='john' set disabled=true



REM OBS: Funkar också att använda "net user" för lokala konton:
REM För centrala AD-konton måste dsquery användas (eller PowerShell...)
net user John /active:no

