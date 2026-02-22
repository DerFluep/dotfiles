if status is-interactive
    # Commands to run in interactive sessions can go here
end
set fish_greeting ""
set -g fish_key_bindings fish_vi_key_bindings
zoxide init fish | source
fzf --fish | source

# Created by `pipx` on 2026-02-07 21:54:21
set PATH $PATH /home/jp/.local/bin
