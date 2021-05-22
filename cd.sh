dir=$(fdfind -t d . $HOME | fzf)
cd -- "$dir"
