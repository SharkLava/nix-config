{pkgs, ...}: {
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
    qbittorrent
  ];
}
