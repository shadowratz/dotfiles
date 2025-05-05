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