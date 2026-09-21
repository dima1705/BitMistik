# Generates an upload keystore for Google Play signing.
# Run from repo root: .\scripts\generate-android-keystore.ps1

$ErrorActionPreference = "Stop"
$androidDir = Join-Path $PSScriptRoot "..\android"
$keystorePath = Join-Path $androidDir "upload-keystore.jks"
$keyPropsPath = Join-Path $androidDir "key.properties"

if (Test-Path $keystorePath) {
    Write-Host "Keystore already exists: $keystorePath"
    exit 0
}

$keytool = Get-Command keytool -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Source -ErrorAction SilentlyContinue
if (-not $keytool) {
    $candidates = @(
        (Join-Path $env:JAVA_HOME "bin\keytool.exe"),
        "$env:LOCALAPPDATA\Android\Sdk\jbr\bin\keytool.exe",
        "$env:ProgramFiles\Android\Android Studio\jbr\bin\keytool.exe",
        "$env:ProgramFiles\Java\jdk-21\bin\keytool.exe"
    )
    foreach ($candidate in $candidates) {
        if ($candidate -and (Test-Path $candidate)) {
            $keytool = $candidate
            break
        }
    }
}
if (-not $keytool -or -not (Test-Path $keytool)) {
    throw "keytool not found. Install JDK or set JAVA_HOME."
}

$storePass = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 24 | ForEach-Object { [char]$_ })
$keyPass = $storePass

Write-Host "Creating upload keystore at $keystorePath"
& $keytool -genkeypair -v `
    -keystore $keystorePath `
    -alias upload `
    -keyalg RSA `
    -keysize 2048 `
    -validity 10000 `
    -storepass $storePass `
    -keypass $keyPass `
    -dname "CN=bitMystic, OU=Mobile, O=bitMystic, L=Minsk, ST=Minsk, C=BY"

$content = @"
storePassword=$storePass
keyPassword=$keyPass
keyAlias=upload
storeFile=upload-keystore.jks
"@
[System.IO.File]::WriteAllText($keyPropsPath, $content, (New-Object System.Text.UTF8Encoding $false))

Write-Host ""
Write-Host "Done."
Write-Host "  Keystore : $keystorePath"
Write-Host "  key.properties created (gitignored)."
Write-Host ""
Write-Host "IMPORTANT: back up upload-keystore.jks and key.properties."
Write-Host "Google Play cannot update the app if you lose the upload key."
