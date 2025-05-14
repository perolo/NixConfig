{
  config,
  pkgs,
  ...
}: {
  # Basic user information
  home.username = "pero";
  home.homeDirectory = "/home/pero";

  # Home Manager state version
  home.stateVersion = "24.05"; # Keep this as is unless you know what you're doing

  nixpkgs.config.android_sdk.accept_license = true;

  # Packages to install
  home.packages = with pkgs; [
    tldr # A simplified and community-driven man pages
    # Add more packages here as needed
    (pkgs.uutils-coreutils.override {prefix = "";})
    # Android Studio
    #android-studio-full
    #android-studio
    #android-tools
    #jdk # Install a JDK (required for Android development)
  ];

  # Dotfile management
  home.file = {
    # Example: Symlink a file from the Nix store to ~/.screenrc
    # ".screenrc".source = ./dotfiles/screenrc;

    # Example: Set file content directly
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Environment variables
  home.sessionVariables = {
    #ANDROID_HOME = "${config.home.homeDirectory}/Android/Sdk";
    #NDROID_SDK_ROOT = "${config.home.homeDirectory}/Android/Sdk";
    #JAVA_HOME = "${pkgs.jdk}";
    # LIBCLANG_PATH = "${pkgs.llvmPackages_11.libclang.lib}/lib";  # Uncomment if needed
  };

  # Enable Kitty terminal emulator
  programs.kitty.enable = true;

  #programs.adb.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Git configuration
  programs.git = {
    enable = true;
    userName = "Per Olofsson";
    userEmail = "per.e.olofsson@gmail.com";
    aliases = {
      c = "commit";
      s = "status";
    };
  };

  # Visual Studio Code configuration
  #programs.vscode.profiles.default.extensions
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      yzhang.markdown-all-in-one
      rust-lang.rust-analyzer
      vadimcn.vscode-lldb
      ms-vscode.cpptools
      ms-azuretools.vscode-docker
      tamasfe.even-better-toml
      fill-labs.dependi
      usernamehw.errorlens
      gruntfuggly.todo-tree
      #wokwi.wokwi-vscode
      #webfreak.debug
      #raraspberry-pi.raspberry-pi-pico
      # swellaby.vscode-rust-test-adapter
      jnoortheen.nix-ide
      ms-vscode-remote.remote-ssh
      visualjj.visualjj
    ];
  };

  # Bash configuration
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -al";
      gs = "git status";
      hf = "history | fzf";
    };
  };

  # Enable Home Manager itself
  programs.home-manager.enable = true;
}
