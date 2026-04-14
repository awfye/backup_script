RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'


simple_backup() {
    echo "What is the path to the backup directory? (Example: /home/user/backup_14_04_2026)"
    read backup_dir

    mkdir -p "$backup_dir"

    for d in bu_*; do
        if [ -d "$d" ]; then
            echo "Backing up $d"
            cp -R "$d" "$backup_dir/$d"
        fi
    done

    echo "${GREEN}Backup completed. The backup directories are located in $backup_dir.${NC}"
}

full_backup() {
    echo "What is the path to the backup directory? (Example: /home/user/backup_14_04_2026)"
    read backup_dir

    mkdir -p "$backup_dir"

    for d in bu_*; do
        if [ -d "$d" ]; then
            echo "Backing up $d"
            tar -czf "$backup_dir/$d.tar.gz" "$d"
        fi
    done

    cp "$0" "$backup_dir/backup.sh"
    echo "${GREEN}Compressed backup completed. The backup archives are located in $backup_dir.${NC}"
}

extract_backup() {
    for d in *.tar.gz; do
        if [ -f "$d" ]; then
            echo "Extracting $d"
            tar -xzf "$d" -C .
        fi
    done

    echo "${GREEN}Extraction completed.${NC}"
}



PS3='Please select an option: '

select choice in "Backup (simple copy)" "Backup, archive, compress" "Extract archive" "Exit"; do
    case $REPLY in
        1)
            simple_backup
            break
            ;;
        2)
            full_backup
            break
            ;;
        3)
            extract_backup
            break
            ;;
        4)
            echo "Bye!"
            break
            ;;
        *)
            echo "${RED}Invalid option. Please select a valid choice.${NC}"
            ;;
    esac
done