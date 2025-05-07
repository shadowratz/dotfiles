# My Dotfiles

This repository contains my personal configuration files (dotfiles) for various applications like Zsh, Hyprland, Waybar, Alacritty, and Zellij. It's managed using [GNU Stow](https://www.gnu.org/software/stow/) to easily create symbolic links from this repository to the correct locations in the home directory.

## Prerequisites

-   **Git:** To clone the repository.
-   **GNU Stow:** To manage the symlinks. Install it on Arch Linux using:
    ```bash
    sudo pacman -S stow
    ```

## Installation

1.  **Clone the repository:**
    Clone this repository into a dedicated directory, for example, `~/.dotfiles`.

    ```bash
    git clone <your-repository-url> ~/.dotfiles
    ```
    *(Replace `<your-repository-url>` with the actual URL of your Git repository)*

2.  **Navigate to the dotfiles directory:**
    Change into the cloned directory. Stow commands must be run from the parent directory containing the subdirectories you want to link (in this case, `~/.dotfiles`).

    ```bash
    cd ~/.dotfiles
    ```

3.  **Stow the configurations:**
    Use the `stow` command followed by the name of the directory (package) you want to link. Stow will create symlinks for the files and directories inside the specified package directory into the parent directory (`~`, your home directory in this case).

    *   **To stow a specific configuration (e.g., zsh):**
        ```bash
        stow zsh
        ```
        This will link `~/.dotfiles/zsh/.zshrc` to `~/.zshrc`.

    *   **To stow multiple configurations:**
        ```bash

## Nix Flake & Home Manager (Multi-System Usage)

This repository also supports reproducible configuration using [Nix flakes](https://nixos.wiki/wiki/Flakes) and [Home Manager](https://nix-community.github.io/home-manager/), for both Linux and macOS (including Apple Silicon).

### Quick Start

1. **Run the bootstrap script** to install and activate your Home Manager configuration:

    ```sh
    ./bootstrap.sh
    ```
    The script will install Nix automatically if it is not already present.

    The script will:
    - Detect your OS and architecture (Linux, Intel Mac, or Apple Silicon Mac)
    - Select the correct flake output for your system
    - Apply your Home Manager configuration
    - **Automatically detect and set your username and home directory for Home Manager.**  
      If you are cloning this repository for the first time, you do not need to manually edit any configuration files to set your username or home directory. The bootstrap script will handle this for you.
    - **Automatically back up any existing dotfiles (like `.zshrc`, `.zshenv`, etc.) with a `.backup` extension before replacing them.** This is done by always using the `-b backup` flag with `home-manager switch`.

    > **Note:** If you use Home Manager manually (without the bootstrap script), you must ensure that `home.username` and `home.homeDirectory` are set in your configuration. See the comments in `home/home.nix` for details.  
    > Also, always use the `-b backup` flag with `home-manager switch` to safely back up any existing files before they are replaced by Home Manager.

3. **Manual usage** (if you want to run Home Manager directly):

    ```sh
    nix run github:nix-community/home-manager -- switch -b backup --flake ./home#x86_64-linux-default
    # or for Apple Silicon Mac:
    nix run github:nix-community/home-manager -- switch -b backup --flake ./home#aarch64-darwin-default
    ```

    Replace the system string as appropriate for your platform.

    The `-b backup` flag ensures that any existing dotfiles (like `.zshrc`, `.zshenv`, etc.) are automatically backed up with a `.backup` extension before being replaced by Home Manager.

### Notes

- All configuration is modular and OS-aware.
- The flake supports both `x86_64-linux` (most Linux systems) and `aarch64-darwin` (Apple Silicon Macs).
- See `home/flake.nix` and `bootstrap.sh` for details.

        stow zsh alacritty hyprland waybar zellij
        ```

    *   **To stow all configurations:**
        ```bash
        stow */ # Or list all directories explicitly
        ```
        *(Be cautious with `stow */` if you have non-stowable items like READMEs directly in the root)*

## Usage

-   Any changes made to the files within the `~/.dotfiles` repository will automatically reflect in your system because they are symlinked.
-   Commit and push changes from your `~/.dotfiles` directory to keep your repository updated.

## Removing (Unstowing)

To remove the symlinks created by Stow for a specific package (without deleting the files in your repository), use the `-D` flag:

```bash
# Navigate to the dotfiles directory first
cd ~/.dotfiles

# Unstow zsh
stow -D zsh

# Unstow all packages
stow -D */ # Or list all directories explicitly
```

## Directory Structure Notes

Stow works by mirroring the directory structure. For example:

-   The file `zsh/.zshrc` will be linked to `~/.zshrc`.
-   The directory `~/.dotfiles/hyprland/.config/hypr` will be linked to `~/.config/hypr`.
-   The directory `~/.dotfiles/alacritty/.config/alacritty` will be linked to `~/.config/alacritty`.

Ensure the structure inside each package directory (`alacritty`, `hyprland`, etc.) matches the desired target structure within your home directory.
