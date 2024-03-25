#!/bin/bash

# This script allows for syncing files using RClone.
# It can be run in both batch mode and interactive mode.

# In batch mode, the script will display a UI prompt and then open a new terminal to show the progress.
# In terminal mode, the script will run in the same terminal without the need to open a new one.

# Change working directory to the location of the script
cd "$(dirname "${BASH_SOURCE[0]}")"

do_sync_main=n
do_sync_confetc=n

if [[ -t 1 ]]; then # TERMINAL MODE
	# Prompt the user to sync remote
	read -t 10 -n 1 -p $'\e[1;32mRClone V4 - Do you want to sync remote? (Y/n)\e[0m ' do_sync_main;

	if [[ $do_sync_main =~ ^(y|Y|)$ ]]; then
		# Prompt the user to sync .config and etc
		read -t 10 -n 1 -p $'\e[1;32mRClone V4 - Do you want to sync .config and etc? (Y/n)\e[0m ' do_sync_confetc;
	else
		exit
	fi
	# Run the folders.sh script with the provided input
	./folders.sh "$do_sync_confetc"

else # UI MODE
	# Check if Zenity is installed
	if ! command -v zenity > /dev/null 2>&1; then
		echo "Zenity is not installed. Please install Zenity to run this script."
		exit 1
	fi
	# This code requires Zenity to be installed.
	# Zenity is a utility that allows for the creation of simple graphical user interfaces (GUIs) in shell scripts.
	# To install Zenity, you can use the package manager for your operating system.
	# For example, on Ubuntu or Debian-based systems, you can run the following command in the terminal:
	#   sudo apt-get install zenity

	# Wait for 60 seconds
	sleep 60;
	
	# Prompt the user to sync remote using Zenity
	if zenity --question --text='RClone V4 - Do you want to sync remote?'; then
		# Open a new terminal and run the folders.sh script with the provided input

		for terminal in "$TERMINAL" x-terminal-emulator mate-terminal gnome-terminal terminator xfce4-terminal urxvt rxvt termit Eterm aterm uxterm xterm roxterm termite lxterminal terminology st qterminal lilyterm tilix terminix konsole kitty guake tilda alacritty hyper wezterm rio; do
			if command -v "$terminal" > /dev/null 2>&1; then
				$terminal -e bash -c 'read -t 10 -n 1 -p $'\''\e[1;32mRClone V4 - Do you want to sync .config and etc? (Y/n)\e[0m '\''; ./folders.sh "$REPLY"'
			fi
			echo "terminal emulator not found, please install one, or change the TERMINAL variable in the script"
			echo "only tested with tilix"
		done		
	fi
	echo "Completed successfully"
fi

echo ""
exit
