{ pkgs, flake }:
pkgs.writeShellApplication {
  name = "mprocs";

  runtimeInputs = with pkgs; [
    mprocs
    elixir
    flake.packages.${system}.appDependencies
    flake.packages.${system}.postgresDev
  ];

  text = ''
    exec mprocs \
      "mix phx.server" \
      "postgres-dev"
  '';
}
