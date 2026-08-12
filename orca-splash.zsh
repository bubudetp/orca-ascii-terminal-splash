#!/bin/zsh

frames_dir="${0:A:h}/frames"
frame_delay="${ORCA_SPLASH_DELAY:-0.1}"
skip_frames="${ORCA_SPLASH_SKIP_FRAMES:-14}"

[[ -t 1 && "${TERM:-dumb}" != dumb ]] || exit 0

frames=("$frames_dir"/ezgif-frame-*.txt(N))
(( ${#frames[@]} > skip_frames )) || exit 0
frames=("${frames[@]:$skip_frames}")

restore_terminal() {
  printf '\033[?25h\033[0m'
}

trap 'restore_terminal' EXIT
trap 'exit 130' INT TERM HUP

printf '\033[?25l'
for frame in "${frames[@]}"; do
  printf '\033[H\033[2J'
  command cat -- "$frame"
  sleep "$frame_delay"
done

printf '\033[H\033[2J'
