# Scripts

This directory contains utility scripts that can be installed using GNU Stow.

## Installation

From the dotfiles directory, run:

```bash
stow scripts
```

This will create symbolic links in `~/.local/bin/` for all scripts.

## ONVIF Logging Script

### onvif_log.sh

Logs incoming ONVIF connections to the system log file.

**Features:**
- Checks if logging is enabled via `/root/Data/log_en.txt` (must contain '1')
- Logs to `/root/log/system.log` in the format:
  ```
  ONVIF: Incoming connection from (IP_ADDRESS) at TIMESTAMP
  ```
- Automatically creates log directory if it doesn't exist
- Only logs when explicitly enabled

**Usage:**

```bash
onvif_log.sh <ip_address>
```

**Example:**

```bash
onvif_log.sh 192.168.99.182
```

This will log:
```
ONVIF: Incoming connection from (192.168.99.182) at Wed Nov 05 21:35:44 UTC 2025
```

**Enabling Logging:**

Create the file `/root/Data/log_en.txt` with content '1':

```bash
sudo mkdir -p /root/Data
echo "1" | sudo tee /root/Data/log_en.txt
```

**Disabling Logging:**

Either remove the file or change its content to something other than '1':

```bash
echo "0" | sudo tee /root/Data/log_en.txt
```
