{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    zathura
    wl-clipboard
    libreoffice-fresh
    zsh
    zlib
    unzip
    unrar
    ffmpeg
    kitty
    feh
    mpv
    audacity
    qbittorrent
    putty
    remmina
    inetutils

    mangal
    foliate
  ];
}
