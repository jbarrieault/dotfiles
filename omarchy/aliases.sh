# Omarchy-only shell aliases/functions, sourced from ~/.bashrc.
# (Nothing here applies to the mac .zshrc setup.)

# This T2 Mac has a known Omarchy/Hyprland issue where lid-close doesn't
# trigger suspend, so HandleLidSwitch* is set to ignore in logind (see
# machines/2009-16in-mbp.md) to avoid the machine trying and failing to
# sleep. That means nothing suspends it automatically anymore — use this to
# do it by hand and avoid burning battery when you forget.
alias suspend='systemctl suspend'
