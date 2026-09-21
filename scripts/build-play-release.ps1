# Сборка релизного Android App Bundle для Google Play (обновление).
# Запуск из корня: .\scripts\build-play-release.ps1

$ErrorActionPreference = "Stop"
$root = Split-Path $PSScriptRoot -Parent
$keyProps = Join-Path $root "android\key.properties"
$keystore = Join-Path $root "android\bit-app-test-js8wpx-keystore.jks"

if (-not (Test-Path $keyProps) -or -not (Test-Path $keystore)) {
    Write-Host ""
    Write-Host "ERROR: Release keystore not configured."
    Write-Host "  For an EXISTING Play app use your original upload keystore."
    Write-Host "  1. Download keystore from FlutterFlow (App Details → Android)"
    Write-Host "  2. Save as android/bit-app-test-js8wpx-keystore.jks"
    Write-Host "  3. key.properties is already configured (alias bit-app-test-js8wpx)"
    Write-Host ""
    Write-Host "  New app only: .\scripts\generate-android-keystore.ps1"
    exit 1
}

Push-Location $root
try {
    flutter pub get
    flutter build appbundle --release
    $aab = Join-Path $root "build\app\outputs\bundle\release\app-release.aab"
    if (Test-Path $aab) {
        $item = Get-Item $aab
        Write-Host ""
        Write-Host "Ready for Google Play (update):"
        Write-Host "  $($item.FullName)"
        Write-Host "  $([math]::Round($item.Length / 1MB, 2)) MB"
        Write-Host ""
        Write-Host "Check version in pubspec.yaml (must be > current Play versionCode)."
        Write-Host "See docs/GOOGLE_PLAY_RELEASE.md"
    }
} finally {
    Pop-Location
}
