#!/bin/bash

echo "Welcome to my Arch setup script!"
echo "Pls answer the following questins with y to accept it"
echo

echo ""
read -p "Install base packages? " -r pkgs
if [[ $pkgs == y ]]; then
	readarray -t pkgarray < ~/.local/share/chezmoi/pkglist.txt
	pkgstring=$(printf '%s ' "${pkgarray[@]}")
	paru -S --needed $pkgstring
fi

echo ""
read -p "Install aditional packages for Desktop? " -r desktop
if [[ $desktop == y ]]; then
	readarray -t pkgdskarray < ~/.local/share/chezmoi/pkg_desktop.txt
	pkgdskstring=$(printf '%s ' "${pkgdskarray[@]}")
	paru -S --needed $pkgdskstring
fi

echo ""
read -p "Setup auto login using greetd-tuigreet? " -r greetd
if [[ $greetd == y ]]; then
	sudo rm -f /etc/greetd/config.toml
	sudo cp ~/.local/share/chezmoi/config.toml /etc/greetd/
	sudo systemctl enable greetd.service
fi

echo ""
read -p "add NAS to fstab? " -r nas
if [[ $nas == y ]]; then
	sudo mkdir /home/jp/NAS/
	echo "" | sudo tee -a /etc/fstab
	echo "# NAS" | sudo tee -a /etc/fstab
	echo "192.168.178.91:/volume1/homes/jp /home/jp/NAS/ nfs defaults,vers=4.1,timeo=900,retrans=5,_netdev 0 0" | sudo tee -a /etc/fstab
	echo "192.168.178.91:/volume1/photo /home/jp/NAS/photos_shared/ nfs defaults,vers=4.1,timeo=900,retrans=5,_netdev 0 0" | sudo tee -a /etc/fstab
	sudo mount -a
fi

echo
read -p "Enable TRIM? " -r trim
if [[ $trim == y ]]; then
	sudo systemctl enable fstrim.timer
	sudo systemctl start fstrim.timer
fi

echo
read -p "Undervolt your AMD GPU? " -r undervolt
if [[ $undervolt == y ]]; then
	sudo cp -f ~/.local/share/chezmoi/sdboot-manage.conf /etc/
	sudo sdboot-manage gen
	sudo cp ~/.local/share/chezmoi/amd_undervolt /usr/local/bin/
	sudo cp ~/.local/share/chezmoi/amd_undervolt.service /etc/systemd/system/
	sudo systemctl enable --now amd_undervolt.service
fi


echo
echo "Done!"
