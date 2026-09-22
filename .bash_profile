#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ "$(tty)" =~ ^/dev/tty[0-9]$ ]] && start-hyprland
