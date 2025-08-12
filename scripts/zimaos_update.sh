#!/bin/sh

# Take version as a parameter, default to 1.4.3 if not provided
version="${1:-1.4.3}"
filename="zimaos_zimacube-$version.raucb"

# Create offline and backup directories
mkdir -p /DATA/rauc/offline
mkdir -p /DATA/rauc/backup

backup_path="/DATA/rauc/backup/$filename"
offline_path="/DATA/rauc/offline/$filename"

# Check if the file already exists in backup
if [ -f "$backup_path" ]; then
    echo "Backup file already exists: $backup_path"
    read -p "Do you want to reuse it? (y/n): " choice
    case "$choice" in
        y|Y)
            echo "Reusing existing backup file..."
            cp "$backup_path" "$offline_path"
            ;;
        *)
            echo "Replacing with a new download..."
            rm -f "$offline_path"
            wget "https://casaos.oss-cn-shanghai.aliyuncs.com/IceWhaleTech/zimaos-rauc/releases/download/$version/$filename" -O "$offline_path" || exit 1
            ;;
    esac
else
    echo "Downloading RAUC update file..."
    wget "https://casaos.oss-cn-shanghai.aliyuncs.com/IceWhaleTech/zimaos-rauc/releases/download/$version/$filename" -O "$offline_path" || exit 1
fi

# Install the RAUC update
rauc install "$offline_path" || exit 1

# Move the file to backup (overwrite old copy if needed)
mv -f "$offline_path" "$backup_path" || exit 1

# Reboot system
reboot
