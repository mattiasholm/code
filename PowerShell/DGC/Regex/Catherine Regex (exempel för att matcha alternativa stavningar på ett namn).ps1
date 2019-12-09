# EGNA:

"Catherine" -match "[CK]ath*e*rine*"
"Cathrin" -match "[CK]ath*e*rine*"
"Katerine" -match "[CK]ath*e*rine*"
"Katrine" -match "[CK]ath*e*rine*"
"Katerin" -match "[CK]ath*e*rine*"
"Katherin" -match "[CK]ath*e*rine*"
"Catrin" -match "[CK]ath*e*rine*"
"Katrin" -match "[CK]ath*e*rine*"

# MATCHAR FELAKTIGT PÅ FLERA C ELLER K, BORDE GÅ ATT LÖSA MED {1,1}:
"CKCKCKatrin" -match "[CK]ath*e*rine*"
#


"Rikard" -match "Ric*[kh]ard"
"Richard" -match "Ric*[kh]ard"
"Rickard" -match "Ric*[kh]ard"



"Mattias" -match"Mat*[th][ie][au]s"
"Matias" -match "Mat*[th][ie][au]s"
"Mathias" -match "Mat*[th][ie][au]s"
"Matthias" -match "Mat*[th][ie][au]s"
"Matteus" -match "Mat*[th][ie][au]s"



"Olsson" -match "Oh*lss*on"
"Olson" -match "Oh*lss*on"
"Ohlsson" -match "Oh*lss*on"
"Ohlson" -match "Oh*lss*on"



# Från Catherines Facebook:
"[KC]at[he](0,2)rin[e](0,1)s"
# PowerShell gillar dock ej:
"Katerine" -match "[KC]at[he](0,2)rin[e](0,1)"
"Catherine" -match "[KC]at[he](0,2)rin[e](0,1)"
"Cathrin" -match "[KC]at[he](0,2)rin[e](0,1)"
"Catrin" -match "[KC]at[he](0,2)rin[e](0,1)"
"Katrin" -match "[KC]at[he](0,2)rin[e](0,1)"