{
  description = "Blog Playwright NixOS webdev";

  outputs = inputs @ {
    self,
    nixpkgs,
    utils,
    devToolkit,
    haumea,
    ...
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };

        # not used yet
        src = haumea.lib.load {
          src = ./.nix;
          inputs = {inherit pkgs;};
        };
      in {
        devShell = devToolkit.lib.${system}.buildDevShell {
          name = "blog.playwright-nixos-webdev";
          profiles = [
            "node"
          ];
      }
    );

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";

    devToolkit = {
      url = "github:primamateria/dev-toolkit-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
