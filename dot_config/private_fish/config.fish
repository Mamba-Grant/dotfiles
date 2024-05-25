##################################################################
### Autostart
##################################################################

##################################################################
### Variables
##################################################################

set -gx PATH /usr/local/bin /usr/sbin $PATH
set -gx EDITOR nvim
set -gx BROWSER google-chrome-stable
set -gx XDG_UTILS_DEBUG_LEVEL 2
# set -gx QT_WAYLAND_DISABLE_WINDOWDECORATION 1
# set -gx QT_QPA_PLATFORMTHEME qt5ct
set -gx SUDO_PROMPT "$(tput bold setaf 5)Enter a password$(tput sgr0): "
set -x QT_PLUGIN_PATH /usr/lib/qt/plugins
set -x QT_QPA_PLATFORM wayland
eval (env _CIRCUP_COMPLETE=fish_source circup) # Enable circup completions

### Colors
##################################################################

set PURPLE "$(set_color "#C891FF" --bold)"
set BLUE "$(set_color "#00B4FF" --bold)"
set GREEN "$(set_color "#00C44D" --bold)"
set WHITE "$(set_color "#EEEEEE" --bold)"
set RED "$(set_color "#FF449E" --bold)"
set BLACK "$(set_color "#181818" --bold)"
set YELLOW "$(set_color "#00C0BA" --bold)"
set END "$(set_color normal)"

##################################################################
### Completion colors
##################################################################

## Normal color
set fish_color_normal white --bold
## Color for commands
set fish_color_command green
## Color for wrong commands 
set fish_color_error RED --bold --underline
## Color for quoted text
set fish_color_quote YELLOW --italics
## Color for keywords, like `if, then`
set fish_color_keyword magenta --italics
## Color for IO REDirections (like >/dev/null)
set fish_color_REDirection --bold --italics
## Color fot process separators (like ';', '|' and '&')
set fish_color_end BLACK --italics
## Color for ordinary command parameters (like rm `-rf`)
set fish_color_param --bold --underline
## Color for parameters that are filenames
set fish_color_valid_path YELLOW --bold --italics --underline
## Color for options, which starting with '-' or '--' 
set fish_color_option brwhite --bold
## Color for comments
set fish_color_comment brwhite --italics
## Color for autosuggestion
set fish_color_autosuggestion 827364 --italics --bold

### Pager colors
##################################################################

# The progress bar at the bottom left corner
set fish_pager_color_progress YELLOW --dim --underline --bold --italics
# The prefix string, i.e. the string that is to be completed
set fish_pager_color_prefix brgreen --bold --underline --italics
# The completion itself, i.e. the proposed rest of the string
set fish_pager_color_completion white --dim --italics --bold
# Completion description
set fish_pager_color_description YELLOW --bold --dim --underline --italics
# Prefix of the selected completion
set fish_pager_color_selected_prefix YELLOW --dim --bold --italics --underline
# Suffix of the selected completion
set fish_pager_color_selected_completion brmagenta --bold --italics
# Description of the selected completion
set fish_pager_color_selected_description brgreen --bold --italics --underline
# Prefix of every second unselected completion
set fish_pager_color_secondary_prefix brmagenta --bold --italics --underline
# Background of the selected completion
set fish_pager_color_selected_background --background=3A3D4B
# Background of every second unselected completion
set fish_pager_color_secondary_background --background=181825
# Description of every second unselected completion
set fish_pager_color_secondary_description brRED --dim --bold --italics --underline


##################################################################
### Usefull functions
##################################################################


### Command not found
##################################################################

function fish_command_not_found
    set -l error (set_color RED --bold --italics)
    set -l target (set_color YELLOW --bold --italics)
    set -l underline (set_color --underline)
    set -l normal (set_color normal)
    echo $error\Command $target\'$argv[1]\'$normal$error not found
end

### Backup
##################################################################

function backup
    cp -r $argv $argv.bak
end

### Prompt
##################################################################

function fish_prompt
    echo
    echo " ┌"$PURPLE"["$END$GREEN$(whoami)$WHITE"@"$BLUE$(echo $hostname)$PURPLE"]"$END"\
 $WHITE"-" $PURPLE"["$END$WHITE$(prompt_pwd --full-length-dirs=20)$PURPLE"]"$WHITE" \
        $WHITE"-" $PURPLE"["$WHITE$(date +%H:%M:%S)$PURPLE"]"$END
    echo $WHITE" └"$PURPLE"["$WHITE\$$PURPLE"] "
end


### Aliases
##################################################################

# Main
alias 256-colors="sh $HOME/.local/bin/scripts/256-colors.sh"
alias mtool="sh $HOME/.local/bin/mtool.sh"
alias ram="sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'"
alias free="free -m --si"
alias v="nvim"
alias nf="neofetch"
alias muc="muc -f ~/.local/share/fish/fish_history --shell Fish"

# VIM?????
alias :q="exit"
alias :wq="exit"

# Exa
alias tree="exa --tree --icons"
alias la="exa -l -F -a -g -h -H --color=always  --color-scale --icons --sort type --git --octal-permissions --time modified"
alias ls="exa --color=always"
alias ll="exa -l -h --color=always --color-scale --sort type --git --octal-permissions --icons --time modified"

# Directories
alias md="mkdir -p"
alias rd="rmdir -p"
alias tmp="cd ~/.cache/"

# cd alias
alias ".."="cd .."
alias "..."="cd ../../"
alias "...."="cd ../../../"

# Other
alias imv="imv-wayland"

### Abbreviations
##################################################################

## Systemctl

# Root
abbr -a -g sc systemctl
abbr -a -g scs systemctl start
abbr -a -g scr systemctl restart
abbr -a -g scst systemctl status
abbr -a -g sce systemctl enable

# Non root
abbr -a -g scu systemctl --user
abbr -a -g scus systemctl --user start
abbr -a -g scur systemctl --user restart
abbr -a -g scust systemctl --user status

# Journalctl
abbr -a -g jr journalctl
abbr -a -g jru journalctl --user

# Processes operation
abbr -a -g pk pkill
abbr -a -g spk sudo pkill
abbr -a -g k kill
abbr -a -g sk sudo kill

# Other
abbr -a -g tch touch
abbr -a -g ch chmod
abbr -a -g pg pgrep
abbr -a -g sv sudoedit

# vim:ft=fish
