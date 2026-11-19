param(
    [string]$ToolchainBin = (Join-Path $env:LOCALAPPDATA 'MouseBatteryBuildTools\w64devkit\bin')
)

$ErrorActionPreference = 'Stop'
$make = Join-Path $ToolchainBin 'make.exe'
if (-not (Test-Path -LiteralPath $make)) { throw '找不到工具链。请使用 -ToolchainBin 指定目录。' }
$previousPath = $env:PATH
Push-Location $PSScriptRoot
try {
    $env:PATH = $ToolchainBin + [IO.Path]::PathSeparator + $previousPath
    & $make 'test' 'VERSION=1.1.0' 'CHANNEL=dev' 'CXX=g++' 'WINDRES=windres'
    if ($LASTEXITCODE -ne 0) { throw 'BatteryHub 测试失败。' }
} finally {
    $env:PATH = $previousPath
    Pop-Location
}
