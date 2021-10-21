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

export PATH="/usr/local/opt/curl/bin:$PATH"
