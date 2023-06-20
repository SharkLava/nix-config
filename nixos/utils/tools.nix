{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    zathura
    wl-clipboard
    zsh
    libsForQt5.kdenlive
    smartmontools
    zlib
    unzip
    ffmpeg
    kitty
    moc
    tk
    brave
    feh
    mpv
  ];
}
