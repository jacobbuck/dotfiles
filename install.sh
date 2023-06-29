#! /bin/bash

shopt -s dotglob

check_command() {
  if ! command -v "$1" &>/dev/null; then
    echo "$1 not found" >&2
    exit 1
  fi
}

check_formula() {
  if ! brew list --formula | grep -q "^$1\$"; then
    echo "$1 not installed"
    read -rp "Would you like to install $1? (y): " choice
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
for file in src/*; do
  echo "* $(basename "$file")"
done

read -rp "Proceed? (y): " choice

if [[ $choice == "y" ]]; then
  for file in src/*; do
    file_name="$(basename "$file")"
    target_file="$HOME/$file_name"
    if [[ -e "$target_file" ]]; then
      read -rp "$file_name already exists in $HOME. Backup existing file? (y): " backup_choice
      if [[ $backup_choice == "y" ]]; then
        mv "$target_file" "${target_file}.backup"
        echo "Backed up $file_name to ${file_name}.backup"
      fi
    fi
    cp -f "$file" "$HOME/"
    echo "Copied $file_name to $HOME"
  done
  echo "Dotfiles installed successfully"
fi
