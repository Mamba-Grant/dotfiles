{ inputs, pkgs, ... }:
{
    # imports = [
    #   inputs.anyrun.homeManagerModules.default
    # ];

    programs.mpv = {
        enable = true;

        package = (
            pkgs.mpv-unwrapped.wrapper {
                scripts = with pkgs.mpvScripts; [
                    # uosc
                    # mpv-osc-modern
                    # modernx
                    modernz
                    inhibit-gnome
                    eisa01.simplehistory
                    # eisa01.smartskip
                    # eisa01.smart-copy-paste-2
                    occivink.crop
                    # crop
                    sponsorblock
                    thumbfast
                    mpv-slicing
                    mpv-cheatsheet
                    autoload
                    autosub
                    mpris
                ];

                mpv = pkgs.mpv-unwrapped.override {
                    waylandSupport = true;
                };
            }
        );

        config = {
            profile = "high-quality";
            ytdl-format = "bestvideo+bestaudio";
            cache-default = 4000000;
        };
    };
}
