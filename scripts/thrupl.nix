{ pkgs, ... }:

{
  name = "thrupl";
  language = "bash";

  packages = [
    pkgs.rclone
  ];

  script = ''
    CONFIG_FILE=".thrupload"

    read_config() {
      source "$CONFIG_FILE"
      IFS="," read -ra FILE_LIST <<< "$files"
    }

    upload() {
      local remote_path="$remote:$folder"
      echo "Uploading To $remote_path"

      for file in ''${FILE_LIST[@]}; do
        file=$(echo "$file" | xargs)
        if [[ -e "$file" ]]; then
          echo "|> Uploading $file"
          if [[ "$shared" == "y" ]]; then
            rclone copy "$file" "$remote_path" --progress --drive-shared-with-me
          else
            rclone copy "$file" "$remote_path" --progress
          fi
        else
          echo "<| File $file Not Found"
        fi
      done

      echo "Upload Complete"
    }

    if [[ -f "$CONFIG_FILE" ]]; then
      echo "Loading $CONFIG_FILE"
      read_config
      upload
    else
      echo "Unexistant $CONFIG_FILE"
      read -r -p "Create $CONFIG_FILE ? [y/n]: " create

      if [[ "$create" == "y" ]]; then
        read -r -p "Remote: " remote
        read -r -p "Folder: " folder
        read -r -p "Files(,): " files
        read -r -p "Shared[y/n]: " shared
        echo "remote=$remote" > "$CONFIG_FILE"
        echo "folder=\"$folder\"" >> "$CONFIG_FILE"
        echo "files=\"$files\"" >> "$CONFIG_FILE"
        echo "shared=$shared" >> "$CONFIG_FILE"
        echo "Created $CONFIG_FILE"
        read_config
        upload
      else
        read -r -p "Remote: " remote
        read -r -p "Folder: " folder
        read -r -p "Files(,): " files
        read -r -p "Shared[y/n]: " shared
        IFS=',' read -ra FILE_LIST <<< "$files"
        upload
      fi
    fi
  '';
}
