# ~/.zshrc

eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

export EDITOR="code --wait"
export PAGER="bat --paging=always"

. /Users/jbarrieault/.asdf/asdf.sh

# bun completions
[ -s "/Users/jbarrieault/.bun/_bun" ] && source "/Users/jbarrieault/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
eval "$(rbenv init -)"

# Rails
alias tlogs='tail -f log/development.log'
alias be="bundle exec"
function glogs() {
  echo "Tailing dev logs filtered to lines containing \"$1\""
  tail -f log/development.log | grep --line-buffered $1
}

# Java
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=$JAVA_HOME/bin:$PATH
# For compilers to find openjdk you may need to set:
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
# per `brew install openjdk`'s suggestion:
# "If you need to have openjdk first in your PATH, run:""
# export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

alias ga="git add"
alias co="git checkout"
alias gs="git status"
alias gl="git log --oneline"
alias gc="git commit"
alias gb="git branch"
alias cob="git checkout -b"

# Show commit that deleted a file at a given path:
# who_deleted db/account_center_replica_structure.sql
function who_deleted() {
  git log --full-history -1 -- "$1"
}

# print recently checked out branches
function grbs() {
  git reflog | egrep -io "moving from ([^[:space:]]+)" | awk '{ print $3 }' | awk ' !x[$0]++' | egrep -v '^[a-f0-9]{40}$' | egrep -v -x '^(main)$' | head -5
}

# Opens github origin remote repo page.
function gh() {
  giturl=$(git config --get remote.origin.url)
  if [ "$giturl" == "" ]
    then
     echo "Not a git repository or no remote.origin.url set"
     exit 1;
  fi

  giturl=${giturl/git\@github\.com\:/https://github.com/}
  giturl=${giturl/\.git/}
  branch="$(git symbolic-ref HEAD 2>/dev/null)" ||
  branch="(unnamed branch)"     # detached HEAD
  branch=${branch##refs/heads/}
  giturl=$giturl/tree/$branch
  open $giturl
}

# the directory go packages are installed to
export PATH=$PATH:$(go env GOPATH)/bin
