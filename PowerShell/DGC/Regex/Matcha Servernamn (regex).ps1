"don-ad01" -match "^don-ad\d"
"don-ad02" -match "^don-ad\d"



# Testa mer exakt filter!

"don-apa01" -match "^don-\w+\d\d$"

"don-apa111" -match "^don-\w+\d{2,2}$"

$Matches


"don-ad01" -match "^don-ad0[12]"
"don-ad02" -match "^don-ad0[12]"