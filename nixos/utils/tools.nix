{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    zathura
    wl-clipboard
    zsh
    zlib
    unzip
    unrar
    ffmpeg
    kitty
    moc
    feh
    mpv
  ];
}
