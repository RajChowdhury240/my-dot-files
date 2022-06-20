#!/bin/sh

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";
SEPARATOR="===================================================="

print_message() {
    echo $SEPARATOR
    echo "$1"
    echo $SEPARATOR
}

print_message "Installing git:"
sudo pacman -Syy --needed --noconfirm git
print_message "Git installed!"

print_message "Installing pacman packages list:"
sudo pacman -Syy --needed --noconfirm $(cat $SCRIPT_DIR/pacman-packages-list.txt | cut -d' ' -f1)
print_message "pacman packages installed!"

print_message "Installing yay:"
cd /tmp && git clone https://aur.archlinux.org/yay && cd /tmp/yay && makepkg -si
print_message "Yay installed!"

print_message "Installing yay packages list:"
yay --noprovides --answerdiff None --answerclean None --noconfirm --needed -S $(cat $SCRIPT_DIR/yay-packages-list.txt)
print_message "Yay packages list installed!"

print_message "Enabling services:"
sudo systemctl enable cups
sudo systemctl enable bluetooth
sudo systemctl enable docker
print_message "Finished enabling services!"

print_message "Reboot your machine to start a graphical session :)"
