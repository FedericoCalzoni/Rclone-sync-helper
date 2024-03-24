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
    
    shift 2  # Shift to remove the first two arguments
    echo "";
    echo "Syncing $source_folder to $remote_folder"
    /usr/bin/rclone sync "$source_folder" "$hostname:$remote_folder" "$@" --fast-list --max-backlog 200000 --progress
}

hostname=$(uname -n)

if [ "$#" -lt 1 ]; then
    echo ""
    echo "Usage: $0 <do_sync_confetc>"
    exit 1
fi

# Access the input parameters
do_sync_confetc="$1"

# Sync Desktop folder
parameters=(
    # "--skip-links"
    # "--exclude=/foo1/foo2/**"
    # "--exclude=/foo3/**"
    # "--exclude=*cache/**"
    # "--exclude=*Cache/**"
    # "--exclude=*tmp/**"
    # "--exclude=*metadata/**"
    # "--exclude=*.tmp"
    # "--exclude=*log/**"
    # "--exclude=*LOG/**"
    # "--exclude=*.log"
    # "--delete-excluded"
)
sync_folder "/home/$USER/Desktop/" "$hostname/Desktop" "${parameters[@]}"


# Sync Documents folder
parameters=(
    # "--skip-links"
    # "--exclude=/foo1/**"
    # "--delete-excluded"
)
sync_folder "/home/$USER/Documents/" "$hostname/Documents" "${parameters[@]}"

# Sync Music folder
parameters=(
    # "--skip-links"
    # "--exclude=/foo1/**"
    # "--delete-excluded"
)
sync_folder "/home/$USER/Music/" "$hostname/Music" "${parameters[@]}"

# Sync Pictures folder
parameters=(
    # "--skip-links"
    # "--exclude=/foo1/**"
    # "--delete-excluded"
)
sync_folder "/home/$USER/Pictures/" "$hostname/Pictures" "${parameters[@]}"

# Sync Videos folder
parameters=(
    # "--skip-links"
    # "--exclude=/foo1/**"
    # "--delete-excluded"
)
sync_folder "/home/$USER/Videos/" "$hostname/Videos" "${parameters[@]}"

# Sync .config and /etc folders if the user chooses to do so
if [[ $do_sync_confetc =~ ^(y|Y|)$ ]]; then
    
    # Sync /.config folder
    parameters=(
        # "--skip-links"
        # "--exclude=/foo1/**"
        # "--delete-excluded"
    )
    sync_folder "/home/$USER/.config/" "$hostname/.config" "${parameters[@]}"
    
    # Sync /etc folder
    parameters=(
        # "--skip-links"
        # "--exclude=/foo1/**"
        # "--delete-excluded"
        # "--ignore-errors"
    )
    sync_folder "/etc/" "$hostname/etc" "${parameters[@]}"
    
fi
echo ""
echo "COMPLETED SYNC"
notify-send "Rclone - sync completed"


