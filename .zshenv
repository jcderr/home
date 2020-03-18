########################################################################
# non-interactive shell environment
########################################################################

########################################################################
# uncommitted sensitive environment
########################################################################

[[ -e "$HOME/.zshenv.local" ]] && source "$HOME/.zshenv.local"


########################################################################
# general settings
########################################################################

export PAGER="less"
export LESS="CMifSR --tabs=4"
export LESSCHARSET="utf-8"
export EDITOR="vim"
export MLR_CSV_DEFAULT_RS="lf"

# color scheme
# BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-ocean.sh"
# [[ -s "$BASE16_SHELL" ]] && source "$BASE16_SHELL"

export HOMEBREW_INSTALL_BADGE=""
export HOMEBREW_NO_EMOJI=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ANALYTICS=1


# vim: set ft=zsh tw=100 :
