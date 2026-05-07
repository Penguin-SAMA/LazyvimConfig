param(
    [Parameter(Mandatory = $true)]
    [string]$Project,

    [Parameter(Mandatory = $true)]
    [string]$File,

    [int]$Line = 1,

    [int]$Column = 1
)

$ErrorActionPreference = "Stop"
$serverPipe = "\\.\pipe\godot.nvim"

function Test-NvimServer {
    param([string]$ServerPipe)

    & nvim --headless --server $ServerPipe --remote-expr "1" *> $null
    return $LASTEXITCODE -eq 0
}

function Start-NvimTerminal {
    param(
        [string]$Project,
        [string]$File,
        [int]$Line,
        [int]$Column,
        [string]$ServerPipe
    )

    $arguments = @(
        "new-tab",
        "-d",
        $Project,
        "nvim",
        "--listen",
        $ServerPipe,
        "+call cursor($Line, $Column)",
        $File
    )

    $windowsTerminal = Get-Command wt.exe -ErrorAction SilentlyContinue
    if ($windowsTerminal) {
        $startInfo = [System.Diagnostics.ProcessStartInfo]::new()
        $startInfo.FileName = $windowsTerminal.Source
        $startInfo.UseShellExecute = $false
        foreach ($argument in $arguments) {
            [void]$startInfo.ArgumentList.Add($argument)
        }

        [void][System.Diagnostics.Process]::Start($startInfo)
        return
    }

    $fallbackArguments = @(
        "--listen",
        $ServerPipe,
        "+call cursor($Line, $Column)",
        $File
    )
    Start-Process -FilePath "nvim" -WorkingDirectory $Project -ArgumentList $fallbackArguments
}

if (Test-NvimServer -ServerPipe $serverPipe) {
    & nvim --headless --server $serverPipe --remote-tab-silent $File
    if ($LASTEXITCODE -eq 0) {
        $keys = "<C-\><C-N>:checktime<CR>:call cursor($Line, $Column)<CR>zz"
        & nvim --headless --server $serverPipe --remote-send $keys *> $null
        exit $LASTEXITCODE
    }
}

Start-NvimTerminal -Project $Project -File $File -Line $Line -Column $Column -ServerPipe $serverPipe
