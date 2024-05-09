# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ inputs
, lib
, config
, pkgs
, ...
}:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    inputs.hardware.nixosModules.omen-15-en1007sa
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
      (final: prev: {
        steam = prev.steam.override ({ extraPkgs ? pkgs': [ ], ... }: {
          extraPkgs = pkgs': (extraPkgs pkgs') ++ (with pkgs'; [
            libgdiplus
            openssl
          ]);
        });
      })
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
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

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
        # efiSysMountPoint = "/boot/efi";
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
    # MariaDB
    # mysql = {
    #   enable = true;
    #   package = pkgs.mariadb;
    # };

    # Lorri
    lorri = {
      enable = true;
    };

    #Ollama
    ollama = {
      enable = true;
      acceleration = "cuda";
    };

    # Pipewire
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # DE Settings
    xserver = {
      # Enable X
      enable = true;

      # Enable GNOME
      displayManager = {
        gdm.enable = true;
      };
      desktopManager.gnome.enable = true;

      # Uninstall Xterm
      excludePackages = with pkgs; [ xterm ];

      # Configure Keymap
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    # CUPS
    # printing.enable = true;
  };
  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.enableAllFirmware = true;

  # Wacom
  # hardware.opentabletdriver.enable = true;
  security.rtkit.enable = true;

  # System environment setup
  environment = {
    # Install system packages
    systemPackages = [
      nvidia-offload
    ];

    # Remove default GNOME apps
    gnome.excludePackages = with pkgs.gnome; [
      baobab # disk usage analyzer
      cheese # photo booth
      # eog # image viewer
      epiphany # web browser
      # gedit # text editor
      simple-scan # document scanner
      totem # video player
      yelp # help viewer
      # evince # document viewer
      file-roller # archive manager
      # geary # email client
      seahorse # password manager

      # these should be self explanatory
      # gnome-calculator
      gnome-calendar
      gnome-characters
      gnome-clocks
      gnome-contacts
      gnome-maps
      gnome-music
      pkgs.gnome-tour
      pkgs.gnome-text-editor
      gnome-weather
      # gnome-disk-utility
      pkgs.gnome-console
      pkgs.gnome-photos
    ];
  };

  # User setup
  users.users = {
    shark = {
      isNormalUser = true;
      description = "Vishal Kalathil";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        gnome.gnome-tweaks
        gnomeExtensions.pop-shell
        gnomeExtensions.unite
        gnomeExtensions.blur-my-shell
        firefox
        direnv
        fira-code-nerdfont
        signal-desktop
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
    extraSpecialArgs = { inherit inputs; };
    users = {
      # Import your home-manager configuration
      shark = import ../home-manager/home.nix;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
