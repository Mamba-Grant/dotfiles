{
  mkShell,
  julia,
  juliaPackages ? [Plots],
}:
mkShell {
  packages = [(julia.withPackages juliaPackages)];
  shellHook = ''
    export JULIA_NUM_THREADS=auto
  '';
}
