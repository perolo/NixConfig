# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
# sudo nixos-rebuild switch --flake .#nixos --impure
# nix flake update
{
  config,
  pkgs,
  lib,
  ...
}: let
  unstable = import <nixos-unstable> {config = {allowUnfree = true;};};
  #unstable = import (fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz) {
  #  config = config.nixpkgs.config; # Inherit the global config
  #};
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.memtest86.enable = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "se";
    variant = "";
  };

  #nix.settings.sandbox = false;
  #nix.settings.sandbox-build-dir = true; # or false

  # add the following line somewhere in `configuration.nix`
  # for example, in between locales and audio sections
  # programs.sway.enable = true;

  # audio
  #sound.enable = true;
  #nixpkgs.config.pulseaudio = true;
  #hardware.pulseaudio.enable = true;

  # Configure console keymap
  console.keyMap = "sv-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # hardware.pulseaudio.enable = false;
  # services.pulseaudio = false; #Renamed - Todo Try to enable again, failed the last time to get the headphones working
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Pulse Audio controls
  #bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume 0 +5% #increase sound volume
  #bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume 0 -5% #decrease sound volume
  #bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute 0 toggle # mute sound

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pero = {
    isNormalUser = true;
    description = "pero";
    extraGroups = ["networkmanager" "wheel" "docker" "adbusers"];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  # Install firefox.
  #programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nix.settings.experimental-features = ["nix-command" "flakes"];
  environment.systemPackages = with pkgs; [
    # Nix stuff
    home-manager
    alejandra # Nix formatter

    # Utils
    mg
    btop
    serie #                Git log/tree
    dunst #                notification daemon
    libnotify #            notification desktop
    kitty #                terminal emulator
    # alacritty          # terminal emulator
    #ark #peazip          # file-roller         # zip
    #kdePackages.ark
    # gnome-multi-writer # write usb iso
    pkg-config
    #neofetch
    menulibre #            Menueditor
    fzf
    kdePackages.filelight #        visual directory/file size scan
    dysk
    gnome-keyring
    bat #                  Instead of cat
    fish #                 friendly shell
    #ripgrep #              Better than grep
    #fd #                   Better than find
    #eza #                  Better than ls
    #zoxide                 Better than cd ?  zoxide init fish | source
    dust #                 Better than du
    #dua #                  Better than du ? dua interactive
    #delta #                Alternative to diff
    ripgrep-all #           Better than greo ! rga docker *.pdf

    # Networking
    netscanner #           Network traffic monitoring
    #xh                  # friendly curl
    #posting             # Need to build self - postman alternative in teminal
    #echoapi             # Need to build self - postman alternative in teminal, API testing
    wget
    google-chrome
    brave
    openssl
    inetutils
    #rclone #              synchonize with google drive anf photos

    # Applications
    obsidian
    pandoc #               pdf in obsidian
    discord
    libreoffice
    #gscan2pdf      # simple pdf scanner
    #slack
    #unstable.ollama
    keepass
    steam-run
    #rpi-imager

    # Programming
    #unstable.rustup
    #rpi-imager
    #probe-rs-tools
    #espup
    #clang
    #rustlings
    #jetbrains.rust-rover
    unstable.vscode-with-extensions
    #dioxus-cli # rust dioxus
    #graalvmCEPackages.graalnodejs # npx, npm, ...
    #tailwindcss #         rust dioxus
    docker
    #go
    #  gopls
    #  gotools
    #  go-tools
    jq
    #surrealdb
    #surrealist
    unstable.influxdb2-server
    unstable.influxdb2-cli
    #rustdesk
    #rustdesk-server         # hbbs -r 192.168.50.60, hbbr
    git
    jujutsu # DVCS
    gg-jj # jujustsu GUI
    openjdk17-bootstrap
    bacon #                  # cargo in the background
    mask #                    define builds with a md file
    gitea
    gitea-actions-runner

    # Media
    gimp3-with-plugins #
    digikam # picture management
    exiftool #                     Read picture data
    #kdenlive #
    #kdePackages.kdenlive                    video edit
    #poppler-utils #               pdf utils
    pavucontrol #                  volume control
    pamixer #                      pamixer --allow-boost --set-volume 100
    #file
    #elfutils
    #elf2uf2-rs
    #inkscape-with-extensions
    plantuml
    spotify #                      Not working OK?
    ncspot #                       terminal spotify client
    mermaid-cli

    # Xfce
    xfce.xfce4-pulseaudio-plugin # sound source edit
    xfce.catfish
    xfce.gigolo
    xfce.orage
    xfce.xfburn
    xfce.xfce4-appfinder
    xfce.xfce4-clipman-plugin
    xfce.xfce4-cpugraph-plugin
    xfce.xfce4-dict
    xfce.xfce4-fsguard-plugin
    xfce.xfce4-genmon-plugin
    xfce.xfce4-netload-plugin
    xfce.xfce4-panel
    xfce.xfce4-systemload-plugin
    xfce.xfce4-weather-plugin
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-xkb-plugin
    xfce.xfdashboard
    xorg.xev
    elementary-xfce-icon-theme
    xcolor
    xdo
    xdotool
    zuki-themes

    gtk2
    xorg.libX11

    # Wayland / Hyprland
    #waybar
    #(
    #  pkgs.waybar.overrideAttrs (oldAttrs: {
    #    mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    #  })
    #)
    # swww # for wayland
    # rofi-wayland # for wayland
  ];

  #programs.hyprland = {
  #  enable = true;
  #  #nvidiaPatches = true;
  #  xwayland.enable = true;
  #};

  environment.sessionVariables = {
    # If your cursor becomes invisible
    #WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
    #NIXOS_OZONE_WL = "1";
  };

  hardware = {
    # Opengl
    #opengl.enable = true;

    # Most wayland compositors need this
    #nvidia.modesetting.enable = true;
  };

  # XDG portal
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    #/home/pero/.vscode/extensions/vadimcn.vscode-lldb-1.11.0-linux-x64/adapter/codelldb
    #codelldb
  ];

  #services.udev.packages = [
  #  pkgs.android-udev-rules
  #];

  #services.udev.extraRules = ''
  #  #
  #  ATTR{idProduct}=="1015", ATTR{idVendor}=="1366", MODE="666"
  #  ATTR{idProduct}=="1015", ATTR{idVendor}=="1366", ENV{ID_MM_DEVICE_IGNORE}="1"
  #'';

  services.gnome.gnome-keyring.enable = true;
  system.tools.nixos-version.enable = true;
  programs.java.enable = true;

  programs.steam.enable = true;

  # programs.adb.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  virtualisation.docker.enable = true;
  #services.ollama.enable = true;
  #programs.go.enable = true;
  services.influxdb2.enable = true;

  services.rustdesk-server = {
    enable = true;
    openFirewall = true;
    relay.enable = true;
    signal.enable = true;
    signal.extraArgs = [
      "192.168.50.60"
    ];
  };

  services.gitea = {
    enable = true;
    appName = "Gitea";
    user = "gitea";
    group = "gitea";

    database = {
      type = "sqlite3";
    };

    #dataDir = "/home/pero/Gitea";

    settings = {
      server = {
        ROOT_URL = "http://192.168.68.113:3000/";
        DOMAIN = "192.168.68.113";
        HTTP_ADDR = "192.168.68.113";
        #ROOT_URL = "http://localhost:3000/";
        #DOMAIN = "localhost";
        #HTTP_ADDR = "0.0.0.0";
        HTTP_PORT = 3000;
      };

      database = {
        DB_TYPE = "sqlite3";
        #PATH = "/home/pero/Gitea/gitea.db";
      };

      security = {
        INSTALL_LOCK = true;
        #SECRET_KEY = "81238e8bbdab7d4952dd325e8a5cfbd15cbf5d0b7692ce9aea9353cb822ae54d";
      };

      # This enables the mailer service globally in Gitea
      mailer = {
        ENABLED = true;
        PROTOCOL = "smtps";            # Use "smtp+starttls" for port 587
        SMTP_ADDR = "smtp.gmail.com";  # Replace with your provider
        SMTP_PORT = 465;
        USER = "per.e.olofsson@gmail.com";
        FROM = "gitea@yocreo.com";
      };

      # Essential: This enables the "Forgot Password" link on the login page
      service.ENABLE_REVERSE_PROXY_AUTHENTICATION = false; # Ensure this isn't blocking local auth
      session.ALLOW_FORGOT_PASSWORD = true;

    };
  };

  users.users.gitea = {
    isSystemUser = true;
    #home = "/home/pero/Gitea";
    group = "gitea";
  };
  users.groups.gitea = {};

  #services.gitea-actions-runner = {
    ##enable = true;

  #  instances = {
  #    runner1 = {
  #      enable = true;

  #      name = "runner1";

  #      # URL of the Gitea instance, e.g., http://localhost:3000
  #      url = "http://localhost:3000";
        ##url = "http://192.168.68.113:3000";

        # The token for registering this runner (get from Gitea)
  #      token = "YdHZ8eZTFB3r9WhBAYD8ZN8402QI3NAJn7GoJh5I";

        # Optional labels for this runner
  #      labels = ["ubuntu-latest:docker://gitea/runner-images:ubuntu-latest"];

        #workDir = "/var/lib/gitea-runner/work";  # Add this line

        # Optionally specify architecture/platform
        #platform = "linux/amd64";

        #extraEnvironment = {
        #  GITEA_INSTANCE_TOKEN = builtins.readFile /home/pero/Gitea/gitea-runner-pat;
        #};
        # This makes git available to the runner binary
        #extraPackages = with import <nixos-unstable> {}; [ git ];        

        #path = with import <nixpkgs> {}; [ git ];

  #      hostPackages = with pkgs; [
  #        bash
  #        coreutils
  #        curl
  #        gawk
  #        gitMinimal
  #        gnused
  #        nodejs
  #        wget
  #        git
  #      ];
        
  #    };
  #  };
  #};
  # Enable networking, recommended
  networking.firewall.allowedTCPPorts = [ 3000 ];  

  # To allow building on the host, must override the the service's config so it doesn't use a dynamic user
  systemd.services.gitea-runner-inst = {
    serviceConfig = {
      DynamicUser = lib.mkForce false;
      # Add these lines:
      ExecStartPre = [
        "+${pkgs.coreutils}/bin/mkdir -p /var/lib/gitea-runner/work"
        "+${pkgs.coreutils}/bin/chown gitea-runner:gitea-runner /var/lib/gitea-runner/work"
      ];
    };
  };

  users.users.gitea-runner = {
    home = "/var/lib/gitea-runner";
    group = "gitea-runner";
    isSystemUser = true;
    createHome = true;
  };
  users.groups.gitea-runner = {};
  users.users.gitea-runner.extraGroups = [ "gitea" ];  
  #age.secrets.gitea-actions-runner-token.file = /home/pero/Gitea/gitea-runner-pat;


  ## Ensure the system rebuilds with the correct tools
  #environment.systemPackages = with import <nixpkgs> {}; [ git ];

  ## Enable networking, recommended
  #networking.firewall.allowedTCPPorts = [ 3000 ];

  services.openssh = {
    enable = true;
    ports = [22];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;
  #networking.firewall = {
  #  enable = false;
  #  allowedTCPPorts = [ 80 443 ];
  #  allowedUDPPortRanges = [
  #    { from = 2344; to = 9300; }
  #  ];
  #};

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
