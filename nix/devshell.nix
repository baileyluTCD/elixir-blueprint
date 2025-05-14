{ pkgs, flake }:
pkgs.mkShell {
  packages = with pkgs; [
    elixir
    flake.packages.${system}.appDependencies
  ];

  shellHook = ''
    mix deps.get
  '';
}
