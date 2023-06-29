#! /bin/bash

shopt -s dotglob

check_command() {
    if ! command -v "$1" &> /dev/null; then
        echo "$1 not found" >&2
        exit 1
    fi
}

check_formula() {
    if ! brew list --formula | grep -q "^$1\$"; then
        echo "$1 not installed"
        read -p "Would you like to install $1? (y): " choice
        if [[ $choice == "y" ]]; then
            brew install "$1"
        fi
    fi
}

check_command "brew"
check_command "zsh"

check_formula "zsh-autosuggestions"
check_formula "zsh-completions"
check_formula "zsh-history-substring-search"
check_formula "zsh-syntax-highlighting"

echo "The following files will be copied to $HOME:"
printf '%s\n' src/*

read -p "Proceed? (y): " choice

if [[ $choice == "y" ]]; then
    for file in src/*; do
        dest_file="$HOME/$(basename "$file")"

        if [[ -e "$dest_file" ]]; then
            read -p "~/$(basename "$file") already exists. Backup existing file? (y): " backup_choice

            if [[ $backup_choice == "y" ]]; then
                mv "$dest_file" "${dest_file}.backup"
            fi
        fi

        cp -f "$file" "$HOME/"
    done

    echo "dotfiles installed sucessfully"
fi
