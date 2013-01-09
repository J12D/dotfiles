function server
    mosh j12d@dorado.uberspace.de -p 50804
    #	ssh julian@new.j12d.de
end

# ssh as SOCKS proxy through 443
function tunnel
	sudo networksetup -setsocksfirewallproxystate Wi-Fi on;ssh julian@j12d.de -D 8080 -p 443
end
function closetunnel
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
set PATH /usr/local/share/python $PATH

set CLICOLOR = "YES" 
set LSCOLORS = cxfxcxdxbxegedabagacad

set PS1 "$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
