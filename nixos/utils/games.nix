{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vulkan-tools
    vulkan-headers
    vulkan-loader
    # bottles
    lutris
    wineWowPackages.wayland
    melonDS
  ];
}
