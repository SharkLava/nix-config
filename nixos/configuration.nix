# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    inputs.hardware.nixosModules.omen-en00015p
    # inputs.hardware.nixosModules.common-ssd
    inputs.home-manager.nixosModules.home-manager
    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    ./utils
    ./lang
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
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };

    # Garbage Collector
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # FIXME: Add the rest of your current configuration

  # Networking
  networking = {
    # Setting hostname
    hostName = "Omen";
    networkmanager.enable = true;
  };

  # Boot loader
  boot = {
    # Use latest kernel
    kernelPackages = pkgs.linuxPackages_latest;
    # kernelParams = ["quiet" "splash"];
    # plymouth.enable = true;
    # consoleLogLevel = 0;
    initrd.verbose = false;
    loader = {
      # Configure efivars
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };

      # Enable SystemD boot
      systemd-boot.enable = true;
    };
  };
  # Time
  time.timeZone = "Asia/Kolkata";

  # Locale
  i18n = {
    defaultLocale = "en_IN";
    extraLocaleSettings = {
      LC_ADDRESS = "en_IN";
      LC_IDENTIFICATION = "en_IN";
      LC_MEASUREMENT = "en_IN";
      LC_MONETARY = "en_IN";
      LC_NAME = "en_IN";
      LC_NUMERIC = "en_IN";
      LC_PAPER = "en_IN";
      LC_TELEPHONE = "en_IN";
      LC_TIME = "en_IN";
    };
  };

  # Services
  services = {
    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };

    # Pipewire
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # DE Settings
    xserver = {
      # Enable X
      enable = true;

      # Enable GNOME
      displayManager = {
        gdm.enable = true;
        #autoLogin = {
        #  enable = true;
        #  user = "ghoul";
        #};
      };
      desktopManager.gnome.enable = true;

      # Uninstall Xterm
      excludePackages = with pkgs; [xterm];

      # Configure Keymap
      layout = "us";
      xkbVariant = "";
    };

    # CUPS
    # printing.enable = true;
  };
  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;

  # Wacom
  hardware.opentabletdriver.enable = true;
  security.rtkit.enable = true;

  # System environment setup
  environment = {
    # Install system packages
    systemPackages = [
      # Games
      # pkgs.lutris
      pkgs.vulkan-tools
      pkgs.vulkan-headers
      pkgs.vulkan-loader
      pkgs.bottles
      pkgs.melonDS
      nvidia-offload

      # Development
      pkgs.alejandra
      pkgs.nerdfonts
      pkgs.bottom
      pkgs.openssl
      pkgs.pkg-config
      pkgs.gcc
      pkgs.lldb
      pkgs.black
      pkgs.clang-tools
      pkgs.cmake
      pkgs.nil
      pkgs.helix
      pkgs.wget
      pkgs.tesseract
      pkgs.gitFull
      pkgs.mysql-workbench
      pkgs.gtk3

      # Utilities
      pkgs.zathura
      pkgs.wl-clipboard
      pkgs.zsh
      pkgs.unzip
      pkgs.ffmpeg
      pkgs.kitty
      pkgs.moc
      pkgs.tk
      pkgs.gradience
    ];

    # Remove default GNOME apps
    gnome.excludePackages = with pkgs.gnome; [
      baobab # disk usage analyzer
      cheese # photo booth
      eog # image viewer
      epiphany # web browser
      gedit # text editor
      simple-scan # document scanner
      totem # video player
      yelp # help viewer
      evince # document viewer
      file-roller # archive manager
      geary # email client
      seahorse # password manager

      # these should be self explanatory
      gnome-calculator
      gnome-calendar
      gnome-characters
      gnome-clocks
      gnome-contacts
      gnome-maps
      gnome-music
      pkgs.gnome-tour
      pkgs.gnome-text-editor
      gnome-weather
      gnome-disk-utility
      pkgs.gnome-console
      pkgs.gnome-photos
    ];
  };

  # User setup
  users.users = {
    ghoul = {
      isNormalUser = true;
      description = "Vishal Kalathil";
      extraGroups = ["networkmanager" "wheel"];
      packages = with pkgs; [
        gnome.gnome-tweaks
        gnomeExtensions.pop-shell
        gnomeExtensions.unite
        firefox
        mangal
        betterbird-unwrapped
        picard
        nicotine-plus
        transmission-gtk
        signal-desktop
        mpv
        feh
      ];
      shell = pkgs.zsh;
    };
  };

  programs.zsh.enable = true;

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # Home Manager
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      # Import your home-manager configuration
      ghoul = import ../home-manager/home.nix;
    };
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  #services.openssh = {
  #  enable = true;
  #  # Forbid root login through SSH.
  #  permitRootLogin = "no";
  # Use keys only. Remove if you want to SSH using password (not recommended)
  #passwordAuthentication = false;
  #};

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
