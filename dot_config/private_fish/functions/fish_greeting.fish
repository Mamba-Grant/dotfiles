function fish_greeting
    cutefetch && eval "$(ssh-agent -c)" && ssh-add ~/.ssh/git_key
end
