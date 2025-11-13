## Examples adopted from https://github.com/Aloxaf/fzf-tab/wiki/Preview

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false

# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'

# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no

# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

# make ZSH fzf-tab plugin use tmux popup for auto completion workflows
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' popup-pad 240 160

# When not in tmux, show more lines (40 instead of default ~10)
zstyle ':fzf-tab:*' fzf-min-height 40

# Use eza to preview directory during cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# give a preview of commandline arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[[ $group == "[process ID]" ]] && ps -p $word -o command'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

# Show systemd unit status
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

# Show appropriate previews while viewing files. fzf-tab-previewer should be available in ~/.rc/bin
zstyle ':fzf-tab:complete:*:*' fzf-preview 'fzf-tab-previewer ${(Q)realpath}'

# Preview content of environment variables
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'

# Previews for some git commands
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview 'git log --oneline --pretty=format:"%h %>(12,trunc)%ad %<(12)%aN%d %s" $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview 'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
	'case "$group" in
	"commit tag") git show --color=always $word ;;
	*) git show --color=always $word | delta ;;
	esac'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
	'case "$group" in
	"modified file") git diff $word | delta ;;
	"recent commit object name") git show --color=always $word | delta ;;
	*) git log --color=always $word ;;
	esac'

# Preview man pages during completion
zstyle ':fzf-tab:complete:(\\|)run-help:*' fzf-preview 'run-help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview 'man $word | bat -plman --color=always'

# Preview pacman package info
zstyle ':fzf-tab:complete:(\\|*/|)pacman:*' fzf-preview 'pacman -Qi $word'
zstyle ':fzf-tab:complete:(\\|*/|)paru:*' fzf-preview 'paru -Qi $word'

# Preview Homebrew package info
zstyle ':fzf-tab:complete:brew-(install|uninstall|search|info):*-argument-rest' fzf-preview 'brew info $word'

# Preview SSH config for hosts
zstyle ':fzf-tab:complete:ssh:*' fzf-preview 'grep -A 10 "^Host $word" ~/.ssh/config 2>/dev/null'

# Preview cargo package info
zstyle ':fzf-tab:complete:cargo:*' fzf-preview 'cargo search --limit 1 $word 2>/dev/null'

# Preview tmux session info
zstyle ':fzf-tab:complete:tmux-(attach|switch-client):*' fzf-preview 'tmux list-windows -t $word'
