Applies to: 
  Fedora 39

Description:
  This script is used to create user, configure system settings, install repositories, perform fresh install tasks such as updates and upgrades, and install desired applications via stand alone / flatpak / snap.
  
Tasks:
  - Create user (default is "dboone")
  - Add user to group "wheel"
  - Set hostname (default is "Obsidian-Mini")
  - Speed up DNF
  - Set firewall rules to allow ssh
  - Install RPM-Fusion (Free and Non-Free) and EPEL repositories
  - Execute a system update
  - Execute a system upgrade
  - Install Flatpak
  - Install Snapd
  - Install applications (" ^ " = Flatpak   " * " = Snap )
      - curl
      - timeshift
      - preload
      - net-tools
      - neofetch
      - vim
      - vlc
      - gimp
      - kdenlive
      - gparted
      - tmux
      - bind-utils
      - flameshot
      - piper
      - corectrl
      - thunderbird
      - libreoffice
      - stacer
      - htop
      - kate
      - bpytop
      - krita
      - fluentreader ^
      - vscode
      - brave
      - dnfdragora
      - kde-connect
      - steam
      - discord ^
      - moonlight ^
      - bat
      - ffmpeg
      - cpufetch
      - gdu
      - lsd
      - ascii-image-converter *
      - lolcat
      - mc
   
    - Display neofetch and cpufetch specifications when completed
