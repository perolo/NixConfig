# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: let
  unstable = import <nixos-unstable> {config = {allowUnfree = true;};};
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
    git
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
    neofetch
    menulibre #            Menueditor
    fzf
    kdePackages.filelight #        visual directory/file size scan

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

    # Applications
    obsidian
    pandoc #               pdf in obsidian
    discord
    #libreoffice
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

    # Media
    gimp-with-plugins #
    digikam # picture management
    exiftool #                     Read picture data
    xfce.xfce4-pulseaudio-plugin # sound source edit
    #kdenlive #
    #kdePackages.kdenlive                    video edit
    #poppler-utils #               pdf utils
    pavucontrol #                  volume control
    pamixer #                      pamixer --allow-boost --set-volume 100
    #file
    #elfutils
    #elf2uf2-rs

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

  services.udev.packages = [
    pkgs.android-udev-rules
  ];

  services.udev.extraRules = ''
    #
    ATTR{idProduct}=="1015", ATTR{idVendor}=="1366", MODE="666"
    ATTR{idProduct}=="1015", ATTR{idVendor}=="1366", ENV{ID_MM_DEVICE_IGNORE}="1"
  '';

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
