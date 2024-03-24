# RClone Sync Helper

RClone Sync Helper is a simple project that helps you automate your rclone syncs. It consists of two scripts: `sync.sh` and `folders.sh`. The scripts can be run from the terminal, and can be set up to start automatically. If set up for automatic start, a small pop-up will be displayed to ask for confirmation before syncing.

## Table of Contents

- [Usage](#usage)
- [Auto Start](#auto-start)
- [Customization](#customization)
- [License](#license)

## Usage

To use RClone Sync Helper, run the sync.sh script. By default, this script will prompt you to sync your remote home folders (Desktop, Documents, etc.), as well as the .config and etc folders. Please note that for RClone Sync Helper to work, you must have RClone properly configured. You can refer to the [RClone documentation](https://rclone.org/docs/) for instructions on how to configure RClone.

## Auto Start
To set up autostart using systemd, you can follow these steps:

1) Create a systemd service file: Create a new file with a .service extension, such as rclone-sync.service. \
You can place it in the /etc/systemd/system/ directory or in the user-specific directory ~/.config/systemd/user/.
in the next commands user-spcific directory is assumed, "--user" flag has to be used only if placed in user-specific directory.  

2) Open the service file in a text editor and add the following content:

``` ini
[Unit]
Description=RClone Sync Service
After=network.target

[Service]
ExecStart=/path/to/sync.sh

[Install]
WantedBy=default.target
```

Replace /path/to/sync.sh with the actual path to your sync.sh script.

3) Reload systemd: Run the following command to reload the systemd configuration:
``` bash
systemctl daemon-reload
```

4) Enable the service: Run the following command to enable the service to start automatically on boot:
``` bash
systemctl --user enable rclone-sync.service
```

5) Start the service: Run the following command to start the service immediately:

```bash
systemctl --user start rclone-sync.service
```

The sync.sh script will now be executed automatically on system startup

For more detailed information and customization options, you can refer to the systemd documentation: [Autostarting - ArchWiki](https://wiki.archlinux.org/title/Autostarting)

6) By default when the script is executed outside of a terminal (as it happens with autostart) a zenity prompt will be displayed.
Zenity is required for this to work. 
To install Zenity, you can use the package manager for your operating system.
For example, on Ubuntu or Debian-based systems, you can run the following command in the terminal:
```bash
sudo apt install zenity
```

## Customization

The `folders.sh` script is where you specify which folders to sync. You need to modify this script to fit your needs.

## License

RClone Sync Helper is distributed under the [GPL-3.0 License](https://www.gnu.org/licenses/gpl-3.0.en.html).