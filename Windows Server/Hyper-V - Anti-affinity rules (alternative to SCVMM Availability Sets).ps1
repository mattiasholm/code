$FailoverClusterName = "B3CARE-SE-HVCL"


Get-ClusterGroup -Cluster $FailoverClusterName | Select-Object Name, AntiAffinityClassNames


$AntiAffinity_AD = New-Object System.Collections.Specialized.StringCollection
$AntiAffinity_AD.Add("AD")

$AntiAffinity_DC = New-Object System.Collections.Specialized.StringCollection
$AntiAffinity_DC.Add("DC")

$AntiAffinity_MGM = New-Object System.Collections.Specialized.StringCollection
$AntiAffinity_MGM.Add("MGM")

$AntiAffinity_NIA = New-Object System.Collections.Specialized.StringCollection
$AntiAffinity_NIA.Add("NIA")

$AntiAffinity_PRZ = New-Object System.Collections.Specialized.StringCollection
$AntiAffinity_PRZ.Add("PRZ")

$AntiAffinity_PVS = New-Object System.Collections.Specialized.StringCollection
$AntiAffinity_PVS.Add("PVS")

$AntiAffinity_SF = New-Object System.Collections.Specialized.StringCollection
$AntiAffinity_SF.Add("SF")

$AntiAffinity_VPX = New-Object System.Collections.Specialized.StringCollection
$AntiAffinity_VPX.Add("VPX")


(Get-ClusterGroup -Cluster $FailoverClusterName -Name "B3CARE-SE-AD01").AntiAffinityClassNames = $AntiAffinity_AD
(Get-ClusterGroup -Cluster $FailoverClusterName -Name "B3CARE-SE-AD02").AntiAffinityClassNames = $AntiAffinity_AD

(Get-ClusterGroup -Cluster $FailoverClusterName -Name "B3CARE-SE-DC01").AntiAffinityClassNames = $AntiAffinity_DC
(Get-ClusterGroup -Cluster $FailoverClusterName -Name "B3CARE-SE-DC02").AntiAffinityClassNames = $AntiAffinity_DC

(Get-ClusterGroup -Cluster $FailoverClusterName -Name "B3CARE-SE-MGM01").AntiAffinityClassNames = $AntiAffinity_MGM
(Get-ClusterGroup -Cluster $FailoverClusterName -Name "B3CARE-SE-MGM02").AntiAffinityClassNames = $AntiAffinity_MGM

(Get-ClusterGroup -Cluster $FailoverClusterName -Name "B3CARE-SE-NIA01").AntiAffinityClassNames = $AntiAffinity_NIA
(Get-ClusterGroup -Cluster $FailoverClusterName -Name "B3CARE-SE-NIA02").AntiAffinityClassNames = $AntiAffinity_NIA

(Get-ClusterGroup -Cluster $FailoverClusterName  -Name "B3CARE-SE-PRZ01").AntiAffinityClassNames = $AntiAffinity_PRZ
(Get-ClusterGroup -Cluster $FailoverClusterName  -Name "B3CARE-SE-PRZ02").AntiAffinityClassNames = $AntiAffinity_PRZ

(Get-ClusterGroup -Cluster $FailoverClusterName  -Name "B3CARE-SE-PVS01").AntiAffinityClassNames = $AntiAffinity_PVS
(Get-ClusterGroup -Cluster $FailoverClusterName  -Name "B3CARE-SE-PVS02").AntiAffinityClassNames = $AntiAffinity_PVS

(Get-ClusterGroup -Cluster $FailoverClusterName  -Name "B3CARE-SE-SF01").AntiAffinityClassNames = $AntiAffinity_SF
(Get-ClusterGroup -Cluster $FailoverClusterName  -Name "B3CARE-SE-SF02").AntiAffinityClassNames = $AntiAffinity_SF

(Get-ClusterGroup -Cluster $FailoverClusterName  -Name "B3CARE-SE-VPX01").AntiAffinityClassNames = $AntiAffinity_VPX
(Get-ClusterGroup -Cluster $FailoverClusterName  -Name "B3CARE-SE-VPX02").AntiAffinityClassNames = $AntiAffinity_VPX


Get-ClusterGroup -Cluster $FailoverClusterName | Select-Object Name, AntiAffinityClassNames