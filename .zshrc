########################################################################
# interactive shell configuration
########################################################################

setopt ALIASES
setopt ALWAYS_TO_END
setopt AUTO_CD
setopt AUTO_MENU
setopt AUTO_PUSHD
setopt BEEP
setopt COMPLETE_IN_WORD
setopt CORRECT
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt MULTIOS
unsetopt NOMATCH  # allow [, ], ?, etc.
setopt NOTIFY
setopt PROMPT_SUBST
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_TO_HOME
setopt RM_STAR_SILENT
setopt SUNKEYBOARDHACK
# setopt TRANSIENT_RPROMPT
# see also history section below


########################################################################
# history
########################################################################

setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

export HISTFILE="$HOME/.history"
export HISTFILESIZE=50000000
export HISTSIZE=5000000
export SAVEHIST=$HISTSIZE


########################################################################
# prompt
########################################################################

[[ -s "$HOME/.prompt.zsh" ]] && source "$HOME/.prompt.zsh"


########################################################################
# colors
########################################################################

if [[ -s "$HOME/.local/libexec/base16-shell/scripts/base16-ocean.sh" ]]; then
  source "$HOME/.local/libexec/base16-shell/scripts/base16-ocean.sh"
fi

export GNU_LSCOLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'

if [[ "$OSTYPE" == *'gnu'* ]]; then
  export LSCOLORS=$GNU_LSCOLORS
elif [[ "$OSTYPE" == *'darwin'* ]]; then
  export CLICOLOR=1
  export LSCOLORS='Gxfxcxdxbxegedabagacad'
fi


########################################################################
# completion
########################################################################

zmodload -i zsh/complist
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*::::' _expand completer _complete _match _approximate

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

zstyle ':completion:*' extra-verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name '' # completion in distinct groups

# allow one error for every four characters typed in approximate completer
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/4 )) numeric )'

# case- and hyphen-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'

# complete .. and .
zstyle ':completion:*' special-dirs true

# colors
zstyle ':completion:*' list-colors ${(s.:.)GNU_LSCOLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# offer indices before parameters in array subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# offer completions for directories from all these groups
zstyle ':completion:*::*:(cd|pushd):*' tag-order path-directories directory-stack

# never offer the parent directory (e.g.: cd ../<TAB>)
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# don't complete things which aren't available
zstyle ':completion:*:*:-command-:*:*' tag-order 'functions:-non-comp *' functions
zstyle ':completion:*:functions-non-comp' ignored-patterns '_*'

# why doesn't this do anything?
# zstyle ':completion:*:*:-command-:*:*' tag-order - path-directories directory-stack

# split options into groups
zstyle ':completion:*' tag-order \
    'options:-long:long\ options
     options:-short:short\ options
     options:-single-letter:single\ letter\ options'
zstyle ':completion:*:options-long' ignored-patterns '[-+](|-|[^-]*)'
zstyle ':completion:*:options-short' ignored-patterns '--*' '[-+]?'
zstyle ':completion:*:options-single-letter' ignored-patterns '???*'


########################################################################
# widgets and other extended functionality
########################################################################

typeset -U cdpath

cdpath=(
  $HOME
  $HOME/scratch
  $HOME/Developer
  $HOME/Development
  $cdpath
)

typeset -U fpath

fpath=(
  /usr/local/share/zsh-completions
  /usr/local/share/zsh/site-functions
  $fpath
)

typeset -U libraries

libraries=(
  colored-man-pages
  extract
  gpg-agent
  safe-paste
  ssh-agent
)

# add libraries to fpath but don't source yet
for library ($libraries); do
  if [[ -d "$HOME/.local/lib/zsh/$library" ]]; then
    fpath=($HOME/.local/lib/zsh/$library $fpath)
  fi
done

autoload -Uz +X compaudit compinit
autoload -Uz +X bashcompinit

# Only bother with rebuilding, auditing, and compiling the compinit
# file once a whole day has passed. The -C flag bypasses both the
# check for rebuilding the dump file and the usual call to compaudit.
setopt EXTENDEDGLOB
for dump in $HOME/.zcompdump(N.mh+24); do
  echo 'Re-initializing ZSH completions'
  touch $dump
  compinit
  bashcompinit
  if [[ -s "$dump" && (! -s "$dump.zwc" || "$dump" -nt "$dump.zwc") ]]; then
    zcompile "$dump"
  fi
done
unsetopt EXTENDEDGLOB
compinit -C

# source all plugins so they're available
for library ($libraries); do
  if [[ -s "$HOME/.local/lib/zsh/$library/$library.zsh" ]]; then
    source "$HOME/.local/lib/zsh/$library/$library.zsh"
  fi
done

# +X means don't execute, only load
autoload -Uz +X zmv

# quote pasted URLs
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# bracketed paste mode
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

# for detecting existence of commands, functions, builtins, etc.
zmodload -i zsh/parameter


########################################################################
# zsh-syntax-highlighting
########################################################################

if [[ -s "$HOME/.local/libexec/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$HOME/.local/libexec/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

ZSH_HIGHLIGHT_MAXLENGTH=300

ZSH_HIGHLIGHT_HIGHLIGHTERS=(
  main
  brackets
  pattern
  cursor
)


########################################################################
# zsh-autosuggestions
########################################################################

if [[ -s "$HOME/.local/libexec/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$HOME/.local/libexec/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
ZSH_AUTOSUGGEST_STRATEGY=match_prev_cmd
# ZSH_AUTOSUGGEST_USE_ASYNC=1

# https://github.com/zsh-users/zsh-autosuggestions/issues/238#issuecomment-389324292
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}

zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish


########################################################################
# zsh-history-substring-search
########################################################################

if [[ -s "$HOME/.local/libexec/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh" ]]; then
  source "$HOME/.local/libexec/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh"
fi


########################################################################
# iTerm2 shell integration
########################################################################

[[ -e "$HOME/.iterm2_shell_integration.zsh" ]] && source "$HOME/.iterm2_shell_integration.zsh"


########################################################################
# home setup
#########################################################################

alias home="git --work-tree=$HOME --git-dir=$HOME/.home.git"

# function detect_home_git
# {
#     if [[ $HOME == $PWD ]]; then
#         export GIT_DIR=$HOME/.home.git
#         export GIT_WORK_TREE=$HOME
#     else
#         unset GIT_DIR
#         unset GIT_WORK_TREE
#     fi
# }

# detect_home_git
# chpwd_functions=(detect_home_git $chpwd_functions)


########################################################################
# extra sources
########################################################################

# aliases
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# misc
source "git-helpers.sh"



########################################################################
# key bindings
########################################################################

# load terminfo for portable keybindings
zmodload zsh/terminfo

# allows using terminfo properly
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init()   { echoti smkx }
  function zle-line-finish() { echoti rmkx }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# default to emacs-style keybindings
bindkey -e

# Page-Up and Page-Down cycle through history
[[ "${terminfo[kpp]}" != "" ]] && bindkey "${terminfo[kpp]}" up-line-or-history
[[ "${terminfo[knp]}" != "" ]] && bindkey "${terminfo[knp]}" down-line-or-history

# search history for commands which begin with the current string by
# pressing Up or Down (depends on zsh-history-substring-search)
[[ "${terminfo[kcuu1]}" != "" ]] && bindkey "${terminfo[kcuu1]}" history-substring-search-up
[[ "${terminfo[kcud1]}" != "" ]] && bindkey "${terminfo[kcud1]}" history-substring-search-down

# Home and End go to beginning and end of line
[[ "${terminfo[khome]}" != "" ]] && bindkey "${terminfo[khome]}" beginning-of-line
[[ "${terminfo[kend]}" != "" ]] && bindkey "${terminfo[kend]}"  end-of-line

# Space does history expansion (e.g., !1<space> becomes the last command
# input in the history)
bindkey ' ' magic-space

bindkey '^[[1;5C' forward-word   # move forward wordwise with ctrl-arrow
bindkey '^[[1;5D' backward-word  # move backward wordwise with ctrl-arrow

# Shift-Tab moves through the completion menu backwards
[[ "${terminfo[kcbt]}" != "" ]] && bindkey "${terminfo[kcbt]}" reverse-menu-complete

# Backspace
[[ "${terminfo[kbs]}" != "" ]] && bindkey "${terminfo[kbs]}" backward-delete-char

# Delete
if [[ "${terminfo[kdch1]}" != "" ]]; then
  bindkey "${terminfo[kdch1]}" delete-char
else
  bindkey "^[[3~" delete-char
  bindkey "^[3;5~" delete-char
  bindkey "\e[3~" delete-char
fi

# complete on Tab, leave expansion to _expand
[[ "${terminfo[ht]}" != "" ]] && bindkey "${terminfo[ht]}" complete-word

# initiate history search with Ctrl-R
bindkey '^R' history-incremental-search-backward

# edit command line in $EDITOR with 'm-e' (or 'esc+e' or 'v' in vi mode)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M emacs '^[e' edit-command-line
bindkey -M vicmd v edit-command-line


# vim: set ft=zsh tw=72 :
