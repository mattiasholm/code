icacls D:\public /remove "Everyone"
icacls D:\public /grant "Authenticated Users":(rd,x)
OBS: /grant:r F�R REPLACE!

GUI-klickrutor f�r specific rights:	Motsvarande icacls:

Full Control				F
Traverse Folder / Execute File		X
List Folder / Read Data			RD
Read Attributes				RA
Read Extended Attributes		REA
Create Files / Write Data		WD
Create Folders / Append Data		AD
Write Attributes			WA
Write Extended Attributes		WEA
Delete Subfolders and Files		DC
Delete					D
Read Permissions			RC
Change Permissions			WDAC
Take Ownership				WO


Full access:
F
(X,RD,RA,REA,WD,AD,WA,WEA,DC,D,RC,WDAC,WO)


Modify access:
M
(X,RD,RA,REA,WD,AD,WA,WEA,D,RC)


Read and execute access:
RX
(X,RD,RA,REA,RC)


Read-only:
R
(RD,RA,REA,RC)


Write-only access
W
(WD,AD,WA,WEA)


L�R DIG OM INHERITANCE OCH HUR MAN ANV�NDER DESSA I ICACLS:

(OI) - object inherit
(CI) - container inherit
(IO) - inherit only
(NP) - don't propagate inherit
