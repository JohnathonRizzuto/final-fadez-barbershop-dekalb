# Fetch AI-generated assets for Final Fadez Barbershop from Canva CDN
# Run this on Windows before Stage 2 git-commits the build folder.
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $false

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$heroUrl = @"
https://export-download.canva.com/RgoIU/DAHKjuRgoIU/-1/0/0001-3058448336088612045.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAQYCGKMUH5AO7UJ26%2F20260523%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20260523T223847Z&X-Amz-Expires=34137&X-Amz-Signature=4b4909d6203cc671cf0e1a9fd9856d36168b0f0b36cf33dc866e2b4ee9194869&X-Amz-SignedHeaders=host%3Bx-amz-expected-bucket-owner&response-expires=Sun%2C%2024%20May%202026%2008%3A07%3A44%20GMT
"@
Write-Host "Downloading hero.jpg..."
try {
    Invoke-WebRequest -Uri $heroUrl -OutFile "$here\hero.jpg" -UseBasicParsing
    if (Test-Path "$here\hero.jpg") {
        $sz = (Get-Item "$here\hero.jpg").Length
        Write-Host "OK - hero.jpg downloaded ($sz bytes)"
    } else {
        Write-Host "WARN - hero.jpg missing after download"
    }
} catch {
    Write-Host "ERROR - hero fetch failed: $_"
    Write-Host "NOTE - the Canva presigned URL may have expired (~24h lifetime). Site will fall back to gradient background until logo swap at \$250 close."
}
