{ pkgs }:
pkgs.writeShellApplication {
  name = "mix-fmt";

  runtimeInputs = with pkgs; [
    elixir
  ];

  runtimeEnv = {
    MIX_NO_DEPS = 1;
  };

  text = ''
    exec mix "do" \
      app.config --no-deps-check --no-compile, \
      format
  '';
}
