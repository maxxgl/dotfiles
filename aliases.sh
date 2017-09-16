export PS1="\u@\h\w\$ "

alias m='make'

alias c='clear'

alias cn='make clean'

alias g='git status'

alias am='git commit -am'

alias p='git push'

alias l="git log --graph -5 --decorate --all --abbrev-commit --pretty=format:'%C(dim normal)%<(12)%an -%Creset %C(yellow)%h%Creset: %C(dim cyan)%<(14)<%cr> %Creset%s %Cred%d%Creset'"

alias log="git log --all --stat --oneline -3 --graph --abbrev-commit --pretty=format:'%C(dim normal)%<(12)%an -%Creset %C(yellow)%h%Creset: %C(dim cyan)%<(14)<%cr> %Creset%s %Cred%d%Creset%n'"

alias d='git diff'
