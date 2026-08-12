# Orca ASCII Terminal Splash

An animated, true-color orca that plays whenever a terminal opens. The artwork uses individually colored ASCII characters to reproduce the orca's off-white markings, silver transitions, and blue-black body.

The default animation plays 23 frames at 10 fps and lasts about 2.3 seconds.

## Requirements

### macOS

- macOS Terminal, iTerm2, Warp, or another ANSI-compatible terminal
- Zsh

### Windows

- Windows Terminal
- PowerShell 7 (`pwsh`)

Legacy Command Prompt and Windows PowerShell 5 are not supported.

## Repository contents

- `frames/` — 37 pre-rendered, true-color ANSI ASCII frames
- `orca-splash.zsh` — macOS/Zsh animation player
- `orca-splash.ps1` — Windows Terminal/PowerShell 7 animation player

The frame files are required at runtime and must remain beside the player scripts in the repository structure.

## Install on macOS

Clone the repository into your home directory and make the player executable:

```zsh
git clone https://github.com/bubudetp/orca-ascii-terminal-splash.git "$HOME/orca-ascii-terminal-splash"
chmod +x "$HOME/orca-ascii-terminal-splash/orca-splash.zsh"
```

Add this block to both `~/.zprofile` and `~/.zshrc`:

```zsh
# Orca ASCII terminal splash
if [[ -o interactive && -t 1 && -z "${ORCA_SPLASH_DISABLE:-}" && -z "${ORCA_SPLASH_PLAYED:-}" ]]; then
  export ORCA_SPLASH_PLAYED=1
  "$HOME/orca-ascii-terminal-splash/orca-splash.zsh"
fi
```

Adding the guarded block to both files supports login and non-login interactive shells without playing the animation twice.

Open a new terminal window to test it. You can also run it directly:

```zsh
"$HOME/orca-ascii-terminal-splash/orca-splash.zsh"
```

## Install on Windows Terminal with PowerShell 7

Open PowerShell 7 in Windows Terminal and clone the repository:

```powershell
git clone https://github.com/bubudetp/orca-ascii-terminal-splash.git "$HOME\orca-ascii-terminal-splash"
```

Create your PowerShell profile if it does not exist, then open it:

```powershell
New-Item -ItemType File -Path $PROFILE -Force | Out-Null
notepad $PROFILE
```

Add this block to the profile:

```powershell
# Orca ASCII terminal splash
if ($env:ORCA_SPLASH_DISABLE -ne "1" -and -not $env:ORCA_SPLASH_PLAYED) {
    $env:ORCA_SPLASH_PLAYED = "1"
    & "$HOME\orca-ascii-terminal-splash\orca-splash.ps1"
}
```

If PowerShell blocks local scripts, allow scripts created on your computer for your user account:

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

Restart Windows Terminal to test the animation. You can also run it directly:

```powershell
& "$HOME\orca-ascii-terminal-splash\orca-splash.ps1"
```

## Customize the animation

### Change the speed

The default delay is 100 milliseconds per frame, or 10 fps.

On macOS, set the delay in seconds before the startup block:

```zsh
export ORCA_SPLASH_DELAY=0.05  # 20 fps
```

On Windows, set the delay in milliseconds before the startup block:

```powershell
$env:ORCA_SPLASH_DELAY_MS = "50" # 20 fps
```

### Play more frames

By default, the players skip the first 14 frames and begin at frame 023. Set the skipped-frame count to `0` to play all 37 frames.

On macOS:

```zsh
export ORCA_SPLASH_SKIP_FRAMES=0
```

On Windows:

```powershell
$env:ORCA_SPLASH_SKIP_FRAMES = "0"
```

## Temporarily disable the splash

On macOS:

```zsh
ORCA_SPLASH_DISABLE=1 zsh
```

On Windows:

```powershell
$env:ORCA_SPLASH_DISABLE = "1"
pwsh
```

Remove the environment variable afterward with:

```powershell
Remove-Item Env:ORCA_SPLASH_DISABLE
```

## Uninstall

Remove the Orca splash block from your Zsh startup files or PowerShell profile, then delete the cloned repository directory.

## Troubleshooting

### The animation does not start

- Run the appropriate player directly to confirm the repository is in the expected location.
- Confirm the startup block uses the same directory where you cloned the repository.
- On Windows, confirm the terminal profile launches `pwsh`, not legacy `powershell.exe`.
- On macOS, confirm your terminal launches Zsh with `echo $SHELL`.

### The colors look wrong

Use a terminal with true-color ANSI support and a dark background. Very light terminal themes provide less contrast for the orca's white markings.

### The prompt has the wrong color afterward

Both players reset terminal styling when they finish or are interrupted. If the problem persists, update your terminal and verify that your prompt theme does not override ANSI reset behavior.

## Credit

https://www.youtube.com/watch?v=fSSBLqV2S0c
