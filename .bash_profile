# apple의 zsh 경고가 나타나지 않도록 한다
export BASH_SILENCE_DEPRECATION_WARNING=1

# .bashrc 파일이 있다면 읽는다
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# git branch 자동 완성을 위해 
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# bash-completion@2 적용
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/opt/node@16/bin:$PATH"

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
