#!/usr/bin/env bash
#-------------------------------------------------------------------------
#      _          _    __  __      _   _
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__|
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

read -p "Hostname:" hostname
read -p "Username:" username
read -sp "Password:" password
read -sp "Repeat pwd:" password2

# Chech passrord match
if [ "$password"  != "$password2" ]; then
  echo "Password do not match"
  exit 1
fi

pacman -S linux linux-headers linux-lts-headers linux-firmware --noconfirm --needed

echo -e "\nInstalling Base System\n"

pacman -S nano vim openssh sudo efibootmgr --noconfirm --needed


#echo "--------------------------------------"
#echo "-- Bootloader Systemd Installation  --"
#echo "--------------------------------------"
#bootctl install
#cat <<EOF > /boot/loader/entries/arch.conf
#title Arch Linux  
#linux /vmlinuz-linux  
#initrd  /initramfs-linux.img  
#options root=${DISK}1 rw
#EOF

echo "--------------------------------------"
echo "--          Network Setup           --"
echo "--------------------------------------"
pacman -S networkmanager dhclient --noconfirm --needed
systemctl enable --now NetworkManager

echo "--------------------------------------"
echo "--      Set Password for Root       --"
echo "--------------------------------------"
echo "Enter password for root user: "
passwd root

echo "--------------------------------------"
echo "--   SYSTEM READY FOR FIRST BOOT    --"
echo "--------------------------------------"
