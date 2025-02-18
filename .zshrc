#eval $(/opt/homebrew/bin/brew shellenv)
#eval $(thefuck --alias)

export UPDATE_ZSH_DAYS=13
export ZSH_CUSTOM_AUTOUPDATE_QUIET=true
export DISABLE_UPDATE_PROMPT=true

source /Users/apahuja/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle lazygit
antigen bundle lazydocker
antigen bundle dive
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle npm
antigen bundle node
antigen bundle macos
antigen bundle thefuck
antigen bundle agkozak/zsh-z
antigen bundle git
antigen bundle isodate
antigen bundle history

# # Syntax highlighting bundle.
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle unixorn/git-extra-commands@main

# Load the theme.
antigen bundle sindresorhus/pure@main

# Tell Antigen that you're done.
antigen apply

# after installing tools add to profile or rc
alias ls='eza -l --group-directories-first --color=auto --git --icons --no-permissions --no-user'
alias ll='eza -lahF --group-directories-first --color=auto --git --icons'
alias cat="bat --paging=never"
#update everything
alias brewall="homeshick pull && brew update && brew upgrade && brew cleanup && brew doctor && antigen update && zshreload"
# a handy mac alias, understand what it does before using though
alias emptytrash=" \
    sudo rm -rfv /Volumes/*/.Trashes; \
    rm -rfv ~/.Trash/*; \
    sudo rm -v /private/var/vm/sleepimage \
"
alias clean='git branch | grep -v "\* $(git branch --show-current)" | xargs git branch -D'

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

refresh() {
  # Check for local changes
  if [[ -n $(git status --porcelain) ]]; then
    echo "You have uncommitted changes. Do you want to revert all changes? (y/n)"
    read -r response
    if [[ "$response" =~ ^[Yy]([Ee][Ss])?$ ]]; then
      git reset --hard
      git clean -fd
      echo "Changes reverted."
    else
      echo "Aborting refresh. No changes were reverted."
      return 1
    fi
  fi

  # Switch to master and pull latest changes
  git checkout master
  git pull origin master
  echo "Switched to master and updated with latest changes."
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# If you are using ssh for github, this will bypass asking passphrase
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)"
fi
ssh-add ~/.ssh/id_rsa &> /dev/null

