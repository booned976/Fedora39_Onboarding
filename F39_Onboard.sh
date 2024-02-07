#!/bin/bash
CYAN="36"
GREEN="32"
BLUE="34"
RED="31"
BOLDGREEN="\e[1;${GREEN}m"
BOLDCYAN="\e[1;${CYAN}m"
BOLDBLUE="\e[1;${BLUE}m"
BOLDRED="\e[1;${RED}m"
ENDCOLOR="\e[0m"
RELEASE=$(cat /etc/redhat-release)
KERNEL=$(uname -sr)

printf "\n  *************************************************************************"
printf "\n  *                                                                       *"
printf "\n  *                 \e[1;${RED}m         Onboarding Fedora 39                         \e[0m *"
printf "\n  *                   ${RELEASE}                    *"
printf "\n  *                     ${KERNEL}                      *"
printf "\n  *                                                                       *"
printf "\n  *************************************************************************\n"

printf "\n"
printf "\n"
printf "\n"

printf "\n  *****************************************************"
printf "\n  *                                                   *"
printf "\n  *      \e[1;${RED}m       Users, Groups, and Hostname          \e[0m *"
printf "\n  *                                                   *"
printf "\n  *****************************************************\n"

printf "\n  -->\e[1;${CYAN}m Add user to group wheel and passwordless sudo \e[0m<-- \n"
sudo usermod -aG wheel dboone
sudo sed --in-place 's/^#\s*\(%wheel\s\+ALL=(ALL)\s\+NOPASSWD:\s\+ALL\)/\1/' /etc/sudoers
groups dboone

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Set hostname \e[0m<-- \n"
sudo hostnamectl set-hostname Obsidian-Mini
hostname --fqdn

printf "\n"
printf "\n"
printf "\n"

printf "\n  *****************************************************"
printf "\n  *                                                   *"
printf "\n  *      \e[1;${RED}m           DNF Adjustments                  \e[0m *"
printf "\n  *                                                   *"
printf "\n  *****************************************************\n"

printf "\n  -->\e[1;${CYAN}m Speed up DNF \e[0m<-- \n"
echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf
echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf

printf "\n"
printf "\n"
printf "\n"

printf "\n  *****************************************************"
printf "\n  *                                                   *"
printf "\n  *      \e[1;${RED}m           Firewall Rules                   \e[0m *"
printf "\n  *                                                   *"
printf "\n  *****************************************************\n"

printf "\n  -->\e[1;${CYAN}m Open port 22 tcp/udp \e[0m<-- \n"
sudo firewall-cmd --add-port=22/tcp --permanent
sudo firewall-cmd --add-port=22/udp --permanent
sudo firewall-cmd --reload

printf "\n"
printf "\n"
printf "\n"

printf "\n  *****************************************************"
printf "\n  *                                                   *"
printf "\n  *      \e[1;${RED}m            Install Repos                   \e[0m *"
printf "\n  *                                                   *"
printf "\n  *****************************************************\n"

printf "\n  -->\e[1;${CYAN}m Free repo \e[0m<-- \n"
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Non-free repo \e[0m<-- \n"
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m EPEL repo \e[0m<-- \n"
sudo dnf config-manager --set-enabled crb -y
sudo dnf install epel-release epel-next-release -y

printf "\n"
printf "\n"
printf "\n"

printf "\n  *****************************************************"
printf "\n  *                                                   *"
printf "\n  *      \e[1;${RED}m           Update and Upgrade               \e[0m *"
printf "\n  *                                                   *"
printf "\n  *****************************************************\n"

printf "\n  -->\e[1;${CYAN}m Update and upgrade to Fedora 39 \e[0m<-- \n"
sudo dnf update -y
sudo dnf upgrade --refresh
sudo dnf install dnf-plugin-system-upgrade -y
sudo dnf system-upgrade download --releasever=39 -y

printf "\n"
printf "\n"
printf "\n"

printf "\n  *****************************************************"
printf "\n  *                                                   *"
printf "\n  *      \e[1;${RED}m           Install Flatpak                  \e[0m *"
printf "\n  *                                                   *"
printf "\n  *****************************************************\n"

printf "\n  -->\e[1;${CYAN}m Install flatpak \e[0m<-- \n"
sudo dnf install flatpak

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Add flatpak repo if not present \e[0m<-- \n"
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
echo "Complete!"

printf "\n"
printf "\n"
printf "\n"

printf "\n  *****************************************************"
printf "\n  *                                                   *"
printf "\n  *      \e[1;${RED}m           Install Snap                     \e[0m *"
printf "\n  *                                                   *"
printf "\n  *****************************************************\n"

printf "\n  -->\e[1;${CYAN}m Install Snap \e[0m<-- \n"
sudo dnf install snapd -y

printf "\n"
printf "\n"
printf "\n"

printf "\n  *****************************************************"
printf "\n  *                                                   *"
printf "\n  *      \e[1;${RED}m           Install Applications             \e[0m *"
printf "\n  *                                                   *"
printf "\n  *****************************************************\n"


printf "\n  -->\e[1;${CYAN}m Install curl \e[0m<-- \n"
sudo dnf install curl -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install backup app timeshift \e[0m<-- \n"
sudo dnf install timeshift -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install Preload to run apps in memory \e[0m<-- \n"
sudo dnf copr enable elxreno/preload -y && sudo dnf install preload -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install net-tools \e[0m<-- \n"
sudo dnf install net-tools -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install neofetch \e[0m<-- \n"
sudo dnf install neofetch -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install vim \e[0m<-- \n"
sudo dnf install vim -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install vlc \e[0m<-- \n"
sudo dnf install vlc -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install gimp \e[0m<-- \n"
sudo dnf install gimp -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install kdenlive \e[0m<-- \n"
sudo dnf install kdenlive -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install gparted \e[0m<-- \n"
sudo dnf install gparted -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install tmux \e[0m<-- \n"
sudo dnf install tmux -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install bind-utils \e[0m<-- \n"
sudo dnf install bind-utils -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install flameshot \e[0m<-- \n"
sudo dnf install flameshot -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install piper \e[0m<-- \n"
sudo dnf install piper -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install corectrl \e[0m<-- \n"
sudo dnf install corectrl -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install thunderbird \e[0m<-- \n"
sudo dnf install thunderbird -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install libreoffice \e[0m<-- \n"
sudo dnf install libreoffice -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install stacer \e[0m<-- \n"
sudo dnf install stacer -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install htop \e[0m<-- \n"
sudo dnf install htop -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install kate \e[0m<-- \n"
sudo dnf install kate -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install bpytop \e[0m<-- \n"
sudo dnf install bpytop -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install krita \e[0m<-- \n"
sudo dnf install krita -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install Fluent Reader flatpak \e[0m<-- \n"
sudo flatpak install fluentreader -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install VS Codium \e[0m<-- \n"
sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
echo "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo
sudo dnf install codium -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install Brave browser \e[0m<-- \n"
sudo dnf install dnf-plugins-core
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install brave-browser -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install DNF Dragora \e[0m<-- \n"
sudo dnf install dnfdragora -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install KDE Connect \e[0m<-- \n"
sudo dnf install kde-connect -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install Steam \e[0m<-- \n"
sudo dnf install steam -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install Discord \e[0m<-- \n"
sudo dnf install discord-0.0.40-1.fc39.x86_64 -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install Moonlight \e[0m<-- \n"
sudo flatpak install flathub com.moonlight_stream.Moonlight -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install bat \e[0m<-- \n"
sudo dnf install bat -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install ffmpeg \e[0m<-- \n"
sudo dnf install ffmpeg-free -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install cpufetch \e[0m<-- \n"
sudo dnf install cpufetch -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install gdu \e[0m<-- \n"
curl -L https://github.com/dundee/gdu/releases/latest/download/gdu_linux_amd64.tgz | tar xz
chmod +x gdu_linux_amd64
sudo mv gdu_linux_amd64 /usr/bin/gdu

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install lsd \e[0m<-- \n"
sudo dnf install lsd -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install ascii image converter \e[0m<-- \n"
sudo snap install ascii-image-converter

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install lolcat \e[0m<-- \n"
sudo dnf install lolcat -y

printf "\n"
printf "\n"

printf "\n  -->\e[1;${CYAN}m Install midnight commander \e[0m<-- \n"
sudo dnf install mc -y

printf "\n"
printf "\n"
printf "\n"

printf "\n  *****************************************************"
printf "\n  *                                                   *"
printf "\n  *                    \e[1;${GREEN}m  Complete  \e[0m                   *"
printf "\n  *                                                   *"
printf "\n  *****************************************************\n"

printf "\n"
printf "\n"
printf "\n"

neofetch
cpufetch

printf "\n"
printf "\n"
printf "\n"


# Windows 11 Pro install
    # Setup
        # Time and currency format: English (World)
        # Initial startup error, skip it
        # Personal use account
        # Name: Obsidian-Win11
        # Password: blank (skips security questions)
    
    # Titus install
        # irm christitus.com/win | iex
        # Install Brave browser
        # After Brave install completes add the following tweaks
            # Essential Tweaks
                # Create restore point
                # Run OO shutup
                # Disable telemetry
                # Disable Wifi-sense
                # Disable activity history
                # .. location tracking
                # .. homegroup
                # .. storage sense
                # .. hibernation
                # .. gameDVR
                # Set services to manual
                # Dark theme on
                # Bing search in start menu on

            # Misc. Tweaks
                # Disable power throttling
                # Enable NumLock on Startup
                # Remove Cortana
                # Remove Microsoft Edge

        # Reboot
        # Should have about 84 processes in task manager

# Also try bloatynosy to remove more bloat after









