# Waybar Configuration

This project provides a basic configuration for Waybar, a customizable status bar for Wayland.

## Project Structure

- **config/**: This folder contains configuration files for Waybar. You can define the modules and settings for Waybar in the files located here.
  
- **mocha.css**: This file contains color definitions used in the Waybar styling. It defines various colors that can be referenced in the `style.css` file.

- **style.css**: This file contains the CSS styles for Waybar. It imports `mocha.css` and applies styles to the Waybar window, including text color and background.

## Installation

1. Clone this repository to your local machine.
2. Navigate to the `waybar` directory.
3. Ensure you have Waybar installed on your system.

## Configuration

To customize Waybar, edit the configuration files located in the `config/` directory. You can define various modules such as system information, battery status, and more.

## Usage

Run Waybar using your preferred method, typically through a terminal or as part of your session startup. Ensure that the configuration files are correctly set up for your desired modules and settings.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.