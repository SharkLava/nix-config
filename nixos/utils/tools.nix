{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    zathura
    poppler
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
    #audacity
    qbittorrent
    #putty
    #remmina
    #inetutils
    tor-browser
    #mangal
    #foliate
    #dynamic-wallpaper
    #appimage-run
    monophony
    ytermusic
  ];
}
