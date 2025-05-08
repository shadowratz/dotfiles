{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    # Plugins: replicate Oh My Zsh plugins with home-manager equivalents where possible
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
      }
      # Add more Nixpkgs zsh plugins here if desired, e.g.:
      # {
      #   name = "zsh-history-substring-search";
      #   src = pkgs.zsh-history-substring-search;
      # }
    ];

    shellAliases = {
      lg = "lazygit";
      lzd = "lazydocker";
      zed = "zed-preview";
      zel = "zellij";
    };

    # Use starship prompt
    initExtra = ''
      # 1Password SSH agent integration for macOS and Linux
      if [[ "$OSTYPE" == "darwin"* ]]; then
        export PATH="/opt/homebrew/bin:$PATH"
        export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
      elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        export SSH_AUTH_SOCK="/run/user/$(id -u)/1password/agent.sock"
      fi

      eval "$(starship init zsh)"

      # Set Zed as the default editor
      export EDITOR="zed"
      export VISUAL="zed"

      # mise and zoxide initialization
      eval "$(mise activate zsh)"
      eval "$(zoxide init zsh)"

      # Dart CLI completion (make path dynamic if possible)
      [[ -f "$HOME/.dart-cli-completion/zsh-config.zsh" ]] && . "$HOME/.dart-cli-completion/zsh-config.zsh" || true

      # 1Password CLI plugin (make path dynamic if possible)
      if [ -f "$HOME/.config/op/plugins.sh" ]; then
        source "$HOME/.config/op/plugins.sh"
      fi
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      format = "$directory$git_branch$git_status$python$nodejs$rust$golang\n$character ";

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol   = "[❯](bold red)";
        vimcmd_symbol  = "[❮](bold yellow)";
      };

      git_branch = {
        format = "[$branch]($style) ";
        style  = "bold purple";
      };

      git_status = {
        format = "([$all_status$ahead_behind]($style) )";
        style  = "bold yellow";
      };

      directory = {
        truncation_length = 2;
        truncate_to_repo  = false;
        style             = "bold blue";
        format            = "[$path]($style) ";
      };

      cmd_duration = {
        min_time = 2000;
        format   = "[$duration]($style) ";
        style    = "yellow";
      };

      status = {
        style   = "bold red";
        symbol  = "✗ ";
        format  = "[$symbol$common_meaning]($style) ";
        disabled = false;
      };
    };
  };
}
