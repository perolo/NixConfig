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

  # Packages to install
  home.packages = with pkgs; [
    tldr  # A simplified and community-driven man pages
    # Add more packages here as needed
    
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
    # EDITOR = "emacs";  # Uncomment if you use Emacs
    # LIBCLANG_PATH = "${pkgs.llvmPackages_11.libclang.lib}/lib";  # Uncomment if needed
  };

  # Enable Kitty terminal emulator
  programs.kitty.enable = true;

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
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
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