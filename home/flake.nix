{
  description = "Dotfiles flake: reproducible Home Manager config for Linux and macOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    outputs = { self, nixpkgs, home-manager, ... }:
      let
        systems = [ "x86_64-linux" "aarch64-darwin" ];
        mkHomeConfig = system: home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          modules = [ ./home.nix ];
          # username and homeDirectory detected at runtime
        };
      in {
        homeConfigurations = builtins.listToAttrs (
          map (system: {
            name = "${system}-default";
            value = mkHomeConfig system;
          }) systems
        );
      };
  }
}