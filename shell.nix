{
  mkShell,
  julia,
  juliaPackages ? [],
}:
mkShell {
  devShells.${system} = {
    default = pkgs.callPackage ./shell.nix {};

    julia = pkgs.callPackage ./shell.nix {
      juliaPackages = ["Plots" "Unitful" "DataFrames" "AdvancedHMC" "LogDensityProblems" "ForwardDiff"];
    };
  };
  packages = [(julia.withPackages juliaPackages)];
  shellHook = ''
    export JULIA_NUM_THREADS=auto
  '';
}
