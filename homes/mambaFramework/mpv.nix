{
  inputs,
  pkgs,
  ...
}: {
  programs.mpv = {
    enable = true;

    package =
      (pkgs.mpv.override {
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
          mpv-cheatsheet-ng
          autoload
          autosub
          mpris
        ];
      }).overrideAttrs (old: {
        # Keep the default package attributes.
      });

    config = {
      profile = "high-quality";
      ytdl-format = "bestvideo+bestaudio";
      cache-default = 4000000;
    };
  };
}
