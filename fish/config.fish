function cleanLaTeX
  rm {*.aux,*.synctex.gz,*.log}
end

# ssh as SOCKS proxy, 443 had to be dropped
function tunnel
  sudo networksetup -setsocksfirewallproxystate Wi-Fi on;
  sudo networksetup -setsocksfirewallproxystate Ethernet on;
  ssh j12d@dorado.uberspace.de -D 8080
end
function closetunnel
  sudo networksetup -setsocksfirewallproxystate Ethernet off;
	sudo networksetup -setsocksfirewallproxystate Wi-Fi off
end

function ips
	ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'
end

function myip
	dig +short myip.opendns.com @resolver1.opendns.com
end

function sniff
    sudo ngrep -d 'en1' -t '^(GET|POST)' 'tcp and port 80'
end

function calc
    echo $argv | bc
end

function gs
	git status $argv
end

function gd
    git diff $argv
end

function push
    git push
end

function pull
    git pull
end

function gc
	git commit $argv
end

function git_cleanindex
  if git rev-parse
    find . -type f -name "* Konflikt*" -exec rm -f {} \;
    awk '!/Konflikt/' .git/packed-refs > temp & mv temp .git/packed-refs
    find . -type f -name "* conflicted copy*" -exec rm -f {} \;
    awk '!conflicted copy' .git/packed-refs > temp & mv temp .git/packed-refs
  end
end

function gl
    git log $argv
end

function ll
	ls -lgha
end

function forcepull
    git fetch --all
    git reset --hard origin/master
end

function push_path
  set PATH $argv $PATH
end

push_path /usr/local/sbin
push_path /usr/sbin
push_path /usr/local/bin
push_path /usr/local/lib

export GOPATH=$HOME/work

set VISUAL /usr/local/bin/vim
set EDITOR $VISUAL

set CLICOLOR = "YES" 
set LSCOLORS = cxfxcxdxbxegedabagacad

set PS1 "$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

set fish_greeting ""
if [ $TERM_PROGRAM = "iTerm.app" ] 
  and test (echo $TERM_PROGRAM_VERSION | sed 's/\..*//') -ge 3 
    source ~/.config/fish/iterm2_shell_integration.fish
end
