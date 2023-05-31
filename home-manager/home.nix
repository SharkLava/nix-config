# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{pkgs, ...}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    # You can also split up your configuration and import pieces of it here:
    ./zathura.nix
    ./helix.nix
    ./git.nix
    ./kitty.nix
    ./zsh.nix
    ./codium.nix
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "ghoul";
    homeDirectory = "/home/ghoul";
    stateVersion = "22.11";
  };

  gtk = {
    enable = true;
    theme = {
      name = "gruvbox-dark";
      package = pkgs.gruvbox-dark-gtk;
    };
    cursorTheme = {
      name = "phinger-cursors";
      package = pkgs.phinger-cursors;
    };
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs = {
    # HomeManager
    home-manager.enable = true;
    gh = {
      enable = true;
      enableGitCredentialHelper = true;
      settings = {
        git_protocol = "ssh";
        editor = "hx";
        prompt = "enabled";

        aliases = {
          co = "pr checkout";
          pv = "pr view";
        };
      };
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
}
