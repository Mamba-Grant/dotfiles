{
  stdenv,
  fontconfig,
  lib,
  gdk-pixbuf,
  jdk8,
  gtk2,
  gtk3,
  iconv,
  libGLU,
  libGL,
  libglvnd,
  pango,
  xorg,
  glib,
  glibc,
  gcc-unwrapped,
  cairo,
  makeWrapper,
  fetchurl,
  autoPatchelfHook,
  wrapGAppsHook,
}:
stdenv.mkDerivation rec {
  name = "VESTA-gtk3";
  version = "3.5.8";

  src = fetchurl {
    url = "https://jp-minerals.org/vesta/archives/${version}/VESTA-gtk3.tar.bz2";
    sha256 = "sha256-eL7wJcKzHx1kycfgatKxOdJSs6aGiT7nmsdLMCGGjfg=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  #  nativeBuildInputs = [
  buildInputs = [
    autoPatchelfHook
    fontconfig.lib
    gcc-unwrapped.lib
    gcc-unwrapped.libgcc
    gdk-pixbuf
    glib
    gtk2
    gtk3
    iconv
    libGLU
    libglvnd
    pango
    xorg.libX11
    xorg.libXxf86vm
    xorg.libXtst
    jdk8
  ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir $out
    cp -ar * $out
    rm -rf $out/PowderPlot
  '';

  # preBuild = ''
  #   addAutoPatchelfSearchPath $out/PowderPlot
  # '';

  preFixup = let
    libPath = lib.makeLibraryPath [
      cairo
      fontconfig.lib
      gcc-unwrapped.lib
      gcc-unwrapped.libgcc
      gdk-pixbuf
      glib
      gtk2
      gtk3
      iconv
      libGLU
      libglvnd
      pango
      xorg.libX11
      xorg.libXxf86vm
      xorg.libXtst
      jdk8
    ];
  in ''
    patchelf \
      --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      --set-rpath "${libPath}" \
      $out/VESTA
    patchelf \
      --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      --set-rpath "${libPath}" \
      $out/VESTA-core
    patchelf \
      --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      --set-rpath "${libPath}" \
      $out/VESTA-gui
    # patchelf \
    #   --set-rpath "${libPath}" \
    #   $out/PowderPlot/libswt-awt-gtk-3346.so
  '';

  meta = with lib; {
    homepage = "https://jp-minerals.org/vesta/en/";
    description = "Visualization for Electronic and STructural Analysis";
    license = licenses.free;
    mainProgram = "VESTA";
    platforms = platforms.linux;
    architectures = ["amd64"];
  };
}
