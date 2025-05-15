{ pkgs, flake, system, ... }: 
  let
    mixNixDeps = pkgs.callPackages ../../deps.nix { };
  in
  pkgs.beamPackages.mixRelease {
      inherit mixNixDeps;

      pname = "nix_phoenix_template_test";
      version = "0.1.0";

      src = ../../.;

      DATABASE_URL = "";
      SECRET_KEY_BASE = "";

      mixEnv = "test";

      nativeBuildInputs = [
        flake.packages.${system}.appDependencies
        flake.packages.${system}.postgresDev
      ];

      doCheck = true;
      checkPhase = ''
        postgres-dev &

        until pg_isready -h /tmp ; do sleep 1 ; done

        mix do \
          app.config --no-deps-check --no-compile, \
          test --no-deps-check
        '';
      }
