$req = [System.Net.HttpWebRequest]::Create("https://downloads.sourceforge.net/project/lenovo-yoga-tab-3-builds/Lineage%2017/README-yoga-v3.md")
$req.AllowAutoRedirect = $true
$req.UserAgent = "curl/7.68.0"
$resp = $req.GetResponse()
$sr = New-Object System.IO.StreamReader($resp.GetResponseStream())
$txt = $sr.ReadToEnd()
$sr.Close()
$resp.Close()
$txt | Set-Content "firmware\README-yoga-v3.md"
Get-Content "firmware\README-yoga-v3.md"

