# This script is used to sync specific folders to a remote location using rclone.
# It provides functions to sync individual folders and accepts command line arguments to control the sync process.

# sync_folder() - Function to sync a folder to a remote location.
# Parameters:
#   - source_folder: The local folder to sync.
#   - remote_folder: The remote folder to sync to.
#   - Additional parameters: Optional additional parameters to pass to the rclone command.
# Usage: sync_folder <source_folder> <remote_folder> [additional_parameters]
function sync_folder() {
    local source_folder="$1"
    local remote_folder="$2"
	local hostname=$(hostname)
	
	shift 2  # Shift to remove the first two arguments
	echo "Syncing $source_folder to $remote_folder"
	echo "";
    /usr/bin/rclone sync "$source_folder" "$hostname:$remote_folder" "$@" --fast-list --max-backlog 200000 --progress
}

if [ "$#" -lt 1 ]; then
	echo ""
    echo "Usage: $0 <do_sync_confetc>"
    exit 1
fi

# Access the input parameters
do_sync_confetc="$1"

echo ""
echo "Sync of Desktop folder"
sync_folder "/home/$USER/Desktop/" "$hostname/Desktop"


echo ""
echo "Sync of Documents folder"
parameters=(
	# "--skip-links"
    # "--exclude=/foo1/foo2/**"
    # "--exclude=/foo3/**"
	# "--exclude=/.**"
    # "--exclude=*cache/**"
    # "--exclude=*Cache/**"
    # "--exclude=*tmp/**"
    # "--exclude=*metadata/**"
    # "--exclude=*.tmp"
	# "--exclude=*log/**"
	# "--exclude=*LOG/**"
    # "--exclude=*.log"
    "--delete-excluded"
)
sync_folder "/home/$USER/Documents/" "$hostname/Documents" "${parameters[@]}"

echo ""
echo "Sync of Music folder"
parameters=(
	# "--skip-links"
	# "--exclude=/foo4/foo5/**"
	# "--exclude=/.**"
	# "--exclude=*cache/**"
    # "--exclude=*Cache/**"
    # "--exclude=*tmp/**"
    # "--exclude=*metadata/**"
    # "--exclude=*.tmp"
    # "--exclude=*log/**"
	# "--exclude=*LOG/**"
    # "--exclude=*.log"
    "--delete-excluded"
)
sync_folder "/home/$USER/Music/" "$hostname/Music" "${parameters[@]}"

echo ""
echo "Sync of Pictures folder"
parameters=(
	# "--skip-links"
	# "--exclude=/foo4/foo5/**"
	# "--exclude=/.**"
	# "--exclude=*cache/**"
    # "--exclude=*Cache/**"
    # "--exclude=*tmp/**"
    # "--exclude=*metadata/**"
    # "--exclude=*.tmp"
    # "--exclude=*log/**"
	# "--exclude=*LOG/**"
    # "--exclude=*.log"
    "--delete-excluded"
)
sync_folder "/home/$USER/Pictures/" "$hostname/Pictures" "${parameters[@]}"

echo ""
echo "Sync of Videos folder"
parameters=(
	# "--skip-links"
	# "--exclude=/foo5/**"
	# "--exclude=/.**"
	# "--exclude=*cache/**"
    # "--exclude=*Cache/**"
    # "--exclude=*tmp/**"
    # "--exclude=*metadata/**"
    # "--exclude=*.tmp"
    # "--exclude=*log/**"
	# "--exclude=*LOG/**"
    # "--exclude=*.log"
    "--delete-excluded"
)
sync_folder "/home/$USER/Videos/" "$hostname/Videos" "${parameters[@]}"
	

if [[ $do_sync_confetc =~ ^(y|Y|)$ ]]; then
	echo ""
	echo "Sync of Config folder"
	parameters=(
		# "--skip-links"
		# "--exclude=/foo/**"
	    # "--exclude=*cache/**"
   		# "--exclude=*Cache/**"
   		# "--exclude=CachedData/**"
    	# "--exclude=*tmp/**"
    	# "--exclude=*metadata/**"
    	# "--exclude=*.tmp"
    	# "--exclude=*log/**"
		# "--exclude=*LOG/**"
		# "--exclude=*log.*"
		# "--exclude=logs/**"
    	# "--exclude=*.log"
    	"--delete-excluded"
	)
	sync_folder "/home/$USER/.config/" "$hostname/.config" "${parameters[@]}"
	    
	echo ""
	echo "Sync of etc folder"
	parameters=(
		# "--skip-links"
	    # "--exclude=sane.d/**"
	    # "--exclude=*cache/**"
    	# "--exclude=*Cache/**"
    	# "--exclude=*tmp/**"
    	# "--exclude=*metadata/**"
    	# "--exclude=*.tmp"
    	# "--exclude=*log/**"
		# "--exclude=*LOG/**"
    	# "--exclude=*.log"
    	# "--exclude=*.key"
    	# "--exclude=key.*"
    	"--delete-excluded"
		"--ignore-errors"
	)
	sync_folder "/etc/" "$hostname/etc" "${parameters[@]}"
	    
fi
echo ""
echo "COMPLETED SYNC"
notify-send "Rclone - sync completed"


