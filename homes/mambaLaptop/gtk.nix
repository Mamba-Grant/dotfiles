{ inputs, pkgs, ... }: {
  gtk = {
    enable = true;

    theme = {
      name = "Flat-Remix-GTK-Blue-Light";
      package = pkgs.flat-remix-gtk;  # Ensure theme is installed
    };

    iconTheme = {
      name = "Flat-Remix-Blue-Light";
      package = pkgs.flat-remix-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    font = {
      name = "Cantarell";
      size = 11;
    };

    gtk3 = {
      extraConfig = {
        gtk-toolbar-style = "GTK_TOOLBAR_ICONS";
        gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
        gtk-button-images = true;
        gtk-menu-images = true;
        gtk-enable-event-sounds = true;
        gtk-enable-input-feedback-sounds = false;
        # gtk-xft-antialias = true;
        # gtk-xft-hinting = true;
        # gtk-xft-hintstyle = "hintslight";
        # gtk-xft-rgba = "rgb";
        gtk-application-prefer-dark-theme = false;
      };
    };
  };
}

