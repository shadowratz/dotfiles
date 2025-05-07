{ config, pkgs, ... }:

{
  # macOS-specific home-manager configuration goes here.

  home.packages = if pkgs.stdenv.isDarwin then (with pkgs; [
    # pkgs.iterm2
    # pkgs.rectangle
    mise
    zoxide
    lazygit
    lazydocker
    docker
  ]) else [];

  # You can also set macOS-specific options here.
}
