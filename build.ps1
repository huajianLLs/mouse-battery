param(
    [string]$ToolchainBin = (Join-Path $env:LOCALAPPDATA 'MouseBatteryBuildTools\w64devkit\bin'),
    [string]$OutputFile = 'bin\mouse-battery-next.exe',
    [int]$Jobs = 4
)

$ErrorActionPreference = 'Stop'
$compiler = Join-Path $ToolchainBin 'g++.exe'
$make = Join-Path $ToolchainBin 'make.exe'
if (-not (Test-Path -LiteralPath $compiler) -or -not (Test-Path -LiteralPath $make)) {
    throw '找不到 MinGW-w64。请使用 -ToolchainBin 指定 w64devkit 的 bin 目录。'
}
if ($Jobs -lt 1 -or $Jobs -gt 32) { throw 'Jobs 必须介于 1 和 32。' }
$previousPath = $env:PATH
Push-Location $PSScriptRoot
try {
    $env:PATH = $ToolchainBin + [IO.Path]::PathSeparator + $previousPath
    & $make -j $Jobs 'VERSION=1.1.0' 'CHANNEL=dev' 'CXX=g++' 'WINDRES=windres' 'BatteryHub.exe'
    if ($LASTEXITCODE -ne 0) { throw 'BatteryHub 编译失败。' }
    $output = if ([IO.Path]::IsPathRooted($OutputFile)) { $OutputFile } else { Join-Path $PSScriptRoot $OutputFile }
    New-Item -ItemType Directory -Path (Split-Path $output) -Force | Out-Null
    Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'BatteryHub.exe') -Destination $output -Force
    Write-Output "已生成：$output"
} finally {
    $env:PATH = $previousPath
    Pop-Location
}
