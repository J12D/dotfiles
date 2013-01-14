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
set PATH /usr/local/share/python $PATH

set CLICOLOR = "YES" 
set LSCOLORS = cxfxcxdxbxegedabagacad

set PS1 "$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

set fish_greeting ""

function fish_prompt --description 'Write out the prompt'
    # Just calculate these once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    end

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    if not set -q __git_cb
        set __git_cb ":"(set_color brown)(git branch ^/dev/null | grep \* | sed 's/* //')(set_color normal)""
    end

    switch $USER

        case root

        if not set -q __fish_prompt_cwd
            if set -q fish_color_cwd_root
                set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
            else
                set -g __fish_prompt_cwd (set_color $fish_color_cwd)
            end
        end

        printf '%s@%s:%s%s%s%s# ' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb

        case '*'

        if not set -q __fish_prompt_cwd
            set -g __fish_prompt_cwd (set_color $fish_color_cwd)
        end

        printf '%s@%s:%s%s%s%s> ' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb

    end
end
