# pyenv config
if command -v pyenv &>/dev/null; then
    eval "$(pyenv init --path)"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"
