{ inputs, pkgs, config, ... }:

{
    home.stateVersion = "24.11";
    imports = [
        # gui
        # ./firefox
        ./foot
	    #    ./eww
	    #    ./dunst
	    #    ./hyprland
	    #    ./wofi
	    #
	    #    # cli
	    #    ./nvim
	    #    ./zsh
	    #    ./git
	    #    ./gpg
	    #    ./direnv
	    #
	    #    # system
	    #    ./xdg
	    # ./packages
    ];
}
