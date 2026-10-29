$ErrorActionPreference = 'Stop'
$toolsDir = Join-Path $PSScriptRoot "tools"
if (-not (Test-Path $toolsDir)) {
    New-Item -ItemType Directory -Path $toolsDir | Out-Null
}

$dest = Join-Path $toolsDir "platform-tools"
$zipPath = Join-Path $toolsDir "platform-tools.zip"

if (-not (Test-Path (Join-Path $dest "adb.exe"))) {
    Write-Host "Descargando Android platform-tools oficial de Google..."
    Invoke-WebRequest -Uri "https://dl.google.com/android/repository/platform-tools-latest-windows.zip" -OutFile $zipPath
    Write-Host "Descomprimiendo en $toolsDir..."
    Expand-Archive -Path $zipPath -DestinationPath $toolsDir -Force
    Remove-Item $zipPath -Force
}

if (Test-Path (Join-Path $dest "adb.exe")) {
    Write-Host "Platform-tools instalado correctamente:"
    & (Join-Path $dest "adb.exe") version
} else {
    Write-Error "No se encontro adb.exe tras descomprimir."
}

