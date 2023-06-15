{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    zathura
    wl-clipboard
    zsh
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
