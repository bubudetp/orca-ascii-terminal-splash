$framesDirectory = Join-Path $PSScriptRoot "frames"
$frameDelayMs = if ($env:ORCA_SPLASH_DELAY_MS) { [int]$env:ORCA_SPLASH_DELAY_MS } else { 100 }
$skipFrames = if ($env:ORCA_SPLASH_SKIP_FRAMES) { [int]$env:ORCA_SPLASH_SKIP_FRAMES } else { 14 }
$escape = [char]27

if ([Console]::IsOutputRedirected) {
    exit 0
}

$frames = @(Get-ChildItem -LiteralPath $framesDirectory -Filter "ezgif-frame-*.txt" | Sort-Object Name)
if ($frames.Count -le $skipFrames) {
    exit 0
}
$frames = @($frames | Select-Object -Skip $skipFrames)

try {
    [Console]::Write("$escape[?25l")
    foreach ($frame in $frames) {
        [Console]::Write("$escape[H$escape[2J")
        [Console]::Write([IO.File]::ReadAllText($frame.FullName))
        Start-Sleep -Milliseconds $frameDelayMs
    }
    [Console]::Write("$escape[H$escape[2J")
}
finally {
    [Console]::Write("$escape[?25h$escape[0m")
}
