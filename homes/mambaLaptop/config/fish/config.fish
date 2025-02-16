function fish_prompt
  set_color cyan; echo (pwd)
  set_color green; echo '> '
end

if status is-interactive
    set fish_greeting
end

alias nrb='sudo nixos-rebuild switch --flake ~/dotfiles/.'

starship init fish | source
if test -f ~/.cache/ags/user/colorschemes/sequences
    cat ~/.cache/ags/user/colorschemes/sequences
end

