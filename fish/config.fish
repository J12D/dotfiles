function hiderootfiles
    for i in *.root
        mv $i .$i
    end
end

function renamerootpdfs
  for i in *-Ac*.pdf
    mv $i (echo $i | sed 's/^.\{16\}//')
  end
end

function server
    mosh j12d@dorado.uberspace.de -p 50804
    #	ssh julian@new.j12d.de
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

#Netflix!
#Networknames: networksetup -listnetworkserviceorder
function usatunnel
    sudo networksetup -setdnsservers "Wi-Fi" 208.122.23.22 208.122.23.23;
end
function closeusatunnel
    sudo networksetup -setdnsservers "Wi-Fi" empty;
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

set PATH /usr/texbin $PATH
set PATH /usr/local/git/bin $PATH
set PATH /usr/local/sbin $PATH
set PATH /usr/sbin $PATH
set PATH /usr/local/bin $PATH

set CLICOLOR = "YES" 
set LSCOLORS = cxfxcxdxbxegedabagacad

set PS1 "$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

set fish_greeting ""
