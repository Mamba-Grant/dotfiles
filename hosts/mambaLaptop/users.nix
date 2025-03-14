# Users - NOTE: Packages defined on this will be on current user only

{ pkgs, username, ... }:

let
    inherit (import ./variables.nix) gitUsername;
in
    {
    users = { 
        mutableUsers = true;
        users."${username}" = {
            homeMode = "755";
            isNormalUser = true;
            description = "${gitUsername}";
            extraGroups = [
                "networkmanager"
                "wheel"
                "libvirtd"
                "scanner"
                "lp"
                "video" 
                "input" 
                "audio"
                "docker"
            ];
        };

        defaultUserShell = pkgs.fish;
    }; 

    environment.systemPackages = with pkgs; [
        starship
        fish
        fishPlugins.done
        fishPlugins.fzf-fish
        fishPlugins.forgit
        fishPlugins.hydro
        fzf
        fishPlugins.grc
        grc
        krabby
    ];

    programs.starship = {
        enable = true;
        settings = {
            add_newline = false;

            right_format = "$cmd_duration\n";

            format = "$username$hostname$directory\n$character\n";

            character = {
                success_symbol = "[🭧🭒](bold fg:blue)[ ➜ ](bold bg:blue fg:#000000)[](bold fg:blue)";
                error_symbol = "[🭧🭒](bold fg:red)[ ✗ ](bold bg:red fg:#000000)[](bold fg:red)";
            };

            package = {
                disabled = true;
            };

            git_branch = {
                symbol = "🌱 ";
                truncation_length = 4;
                truncation_symbol = "";
            };

            git_commit = {
                commit_hash_length = 4;
                tag_symbol = "🔖 ";
            };

            git_state = {
                format = "[\\($state( $progress_current of $progress_total)\\)]($style) ";
                cherry_pick = "[🍒 PICKING](bold red)";
            };

            git_status = {
                conflicted = " 🏳 ";
                ahead = " 🏎💨 ";
                behind = " 😰 ";
                diverged = " 😵 ";
                untracked = " 🤷 ";
                stashed = " 📦 ";
                modified = " 📝 ";
                staged = "[++\\($count\\)](blue)";
                renamed = " ✍️ ";
                deleted = " 🗑 ";
            };

            hostname = {
                ssh_only = false;
                format = "[ ](bold bg:yellow fg:blue)[$hostname](bg:yellow bold fg:#000000)[ ](bold fg:yellow bg:green)";
                trim_at = ".companyname.com";
                disabled = false;
            };

            line_break = {
                disabled = false;
            };

            memory_usage = {
                disabled = true;
                threshold = -1;
                symbol = " ";
                style = "bold dimmed blue";
            };

            time = {
                disabled = true;
                format = "🕙[\\[ $time \\]]($style) ";
                time_format = "%T";
            };

            username = {
                style_user = "bold bg:blue fg:#000000";
                style_root = "red bold";
                format = "[🭃](bold fg:blue)[$user]($style)";
                disabled = false;
                show_always = true;
            };

            directory = {
                home_symbol = " ";
                read_only = "  ";
                style = "bold bg:green fg:#000000";
                truncation_length = 2;
                truncation_symbol = "./";
                format = "[$path]($style)[🭞](fg:green )";
                substitutions = {
                    "Documents" = " ";
                    "/" = "  ";
                    "Downloads" = " ";
                    "Music" = " ";
                    "Pictures" = " ";
                };
            };

            cmd_duration = {
                min_time = 0;
                format = "[🬈🬖🬥🬅 ](bold bg:cyan fg:#000000)[time:$duration](bold bg:cyan fg:#000000)[ 🬖🬥🬔🬗](bold bg:cyan fg:#000000)";
            };
        };
    };

    programs = {
        fish = {
            enable = true;
            interactiveShellInit = '' set fish_greeting krabby random --no-mega --no-gmax --no-regional --no-title -s; '';
        };
    };
}

# Zsh configuration
# zsh = {
#  	enable = true;
# 	enableCompletion = true;
#    ohMyZsh = {
#      enable = true;
#      plugins = ["git"];
#      theme = "funky"; 
#    	};
#
#    autosuggestions.enable = true;
#    syntaxHighlighting.enable = true;
#
#    promptInit = ''
#      fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc
#
#      #pokemon colorscripts like. Make sure to install krabby package
#      #krabby random --no-mega --no-gmax --no-regional --no-title -s; 
#
#      source <(fzf --zsh);
#      HISTFILE=~/.zsh_history;
#      HISTSIZE=10000;
#      SAVEHIST=10000;
#      setopt appendhistory;
#      '';
#    };

