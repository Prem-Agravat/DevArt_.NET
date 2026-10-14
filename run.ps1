# DevArt .NET Runner Script (main branch)
$msbuild = "C:\Program Files\Microsoft Visual Studio\18\Community\MSBuild\Current\Bin\MSBuild.exe"
$iisexpress = "C:\Program Files\IIS Express\iisexpress.exe"
$port = 8080

Write-Host "==> Building DevArt (main branch)..." -ForegroundColor Cyan
& $msbuild "$PSScriptRoot\DevArt.csproj" /t:Build /p:Configuration=Debug /v:m

if ($LASTEXITCODE -eq 0) {
    Write-Host "==> Build succeeded!" -ForegroundColor Green
    Write-Host "==> Opening browser at: http://localhost:$port/Default.aspx" -ForegroundColor Green
    Start-Process "http://localhost:$port/Default.aspx"
    & $iisexpress /path:"$PSScriptRoot" /port:$port
} else {
    Write-Host "[ERROR] Build failed." -ForegroundColor Red
}
