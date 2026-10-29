$ErrorActionPreference = 'Stop'

function Download-DirectFile($url, $outFile) {
    if (Test-Path $outFile) {
        $existingHash = (Get-FileHash -Algorithm SHA256 $outFile).Hash
        Write-Host "Ya existe: $outFile (SHA256: $existingHash)"
        return
    }
    Write-Host "Descargando: $outFile..."
    $req = [System.Net.HttpWebRequest]::Create($url)
    $req.AllowAutoRedirect = $true
    $req.UserAgent = "curl/7.68.0"
    $req.Timeout = 900000 # 15 min
    $resp = $req.GetResponse()
    $stream = $resp.GetResponseStream()
    $fileStream = [System.IO.File]::Create($outFile)
    $stream.CopyTo($fileStream)
    $fileStream.Close()
    $stream.Close()
    $resp.Close()
    $hash = (Get-FileHash -Algorithm SHA256 $outFile).Hash
    Write-Host "Completado: $outFile (SHA256: $hash)"
}

$recDir = "c:\xampp\htdocs\Actualiza Tablets Lenovo\firmware\recovery"
$romDir = "c:\xampp\htdocs\Actualiza Tablets Lenovo\firmware\rom"
$toolsDir = "c:\xampp\htdocs\Actualiza Tablets Lenovo\firmware"
$gappsDir = "c:\xampp\htdocs\Actualiza Tablets Lenovo\firmware\gapps"

# 1. Lineage Recovery mimbre
Download-DirectFile "https://downloads.sourceforge.net/project/lenovo-yoga-tab-3-builds/Lineage%2017/recovery-mimbre.img" (Join-Path $recDir "recovery-mimbre.img")

# 2. TWRP temporal para YT3-X50
Download-DirectFile "https://downloads.sourceforge.net/project/twrp-msm8909/twrp-3.7.0_9-0-x50.img" (Join-Path $recDir "twrp-3.7.0_9-0-x50.img")

# 3. Patcher v6
Download-DirectFile "https://downloads.sourceforge.net/project/lenovo-yoga-tab-3-builds/Lineage%2017/patcher-v6.zip" (Join-Path $toolsDir "patcher-v6.zip")

# 4. ROM LineageOS 17.1 mimbre
Download-DirectFile "https://downloads.sourceforge.net/project/lenovo-yoga-tab-3-builds/Lineage%2017/lineage-17.1-20260816-UNOFFICIAL-mimbre.zip" (Join-Path $romDir "lineage-17.1-20260816-UNOFFICIAL-mimbre.zip")

# 5. GApps MindTheGapps ARM 10.0
Download-DirectFile "https://github.com/MindTheGapps/10.0.0-arm/releases/download/MindTheGapps-10.0.0-arm-20230922_081033/MindTheGapps-10.0.0-arm-20230922_081033.zip" (Join-Path $gappsDir "MindTheGapps-10.0.0-arm-20230922_081033.zip")

Write-Host "=== Todos los artefactos de la Fase 1 descargados y listos ==="
