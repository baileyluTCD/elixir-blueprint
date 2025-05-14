{
  description = "Elixir template project with nix build system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    blueprint.url = "github:numtide/blueprint";
    blueprint.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: inputs.blueprint { 
    inherit inputs;
    prefix = "nix/";
  };
}
