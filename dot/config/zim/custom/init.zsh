#
# Custom aliases/settings
#

# any custom stuff should go here.
# ensure that 'custom' exists in the zmodules array in your .zimrc

# zstyle rules for fzf-tab completion
source $(dirname $0)/zstyle.zsh

source ~/.myshrc

# Enable completions for wrapper functions
compdef gri=git      # git rebase completions for gri
compdef frg=rg       # ripgrep completions for frg
compdef frgv=rg      # ripgrep completions for frgv

# Custom completion for tm (tmux sessions)
_tmux-sessions() {
    local sessions
    sessions=(${(f)"$(tmux list-sessions -F '#S' 2>/dev/null)"})
    _describe 'tmux sessions' sessions
}
compdef _tmux-sessions tm
