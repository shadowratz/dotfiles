{ config, pkgs, ... }:

{
  # macOS-specific home-manager configuration goes here.

  home.packages = if pkgs.stdenv.isDarwin then (with pkgs; [
    # pkgs.iterm2
    # pkgs.rectangle
    docker
    lazydocker
    lazygit
    mise
    nixd
    nil
    zellij
    zoxide
  ]) else [];

  # You can also set macOS-specific options here.
}
