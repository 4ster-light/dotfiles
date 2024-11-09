{ config, pkgs, ... }:

let
  helixConfig = ''
    theme = "gruvbox"

    [editor]
    line-number = "relative"
    bufferline = "always"

    [editor.cursor-shape]
    insert = "bar"
    normal = "block"
    select = "underline"

    [editor.file-picker]
    hidden = false

    [editor.statusline]
    left = ["mode", "spinner", "diagnostics"]
    center = ["file-name"]
    right = ["selections", "position", "file-encoding", "file-type"]
    separator = "│"
    mode.normal = "NORMAL"
    mode.insert = "INSERT"
    mode.select = "VISUAL"

    [editor.indent-guides]
    render = true
    character = "┆"
    skip-levels = 1

    [keys.normal]
    C-s = ":w" # Maps Ctrl-s to write
    C-q = ":x" # Maps Ctrl-q to write-quit
  '';

  kittyConfig = ''
    font_family JetBrainsMono Nerd Font
    font_size 12
    cursor_shape block
  '';
in
{
  home.username = "aster";
  home.homeDirectory = "/home/aster";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    nixpkgs-fmt
    fastfetch
    vscode
    kitty
    brave
    discord
    helix
    odin
    gnumake
    go
    gopls
    lua
    luaPackages.luarocks
    rustup
    gcc
    python3
    python3Packages.pip
    virtualenv
    bun

    ghc
    cabal-install
    stack
    hlint
    ghcid

    # LSPs for Helix-supported languages
    lua-language-server # Lua LSP
    python3Packages.python-lsp-server # Python LSP
    nodePackages.typescript-language-server # TypeScript/JavaScript LSP
    vscode-langservers-extracted # HTML, CSS, JSON LSPs
    haskell-language-server # Haskell LSP
    templ # Templ LSP
    svelte-language-server # Svelte LSP
    lldb # Debugger for use with DAP
    golangci-lint # Linter for Go
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -U fish_greeting ""
      if not test -d ~/.local/share/omf
        curl -L https://get.oh-my.fish | fish
      end
      if not omf theme | grep -q 'lambda'
        omf install lambda
        omf theme lambda
      end
    '';
  };

  programs.git = {
    enable = true;
    userName = "4ster-light";
    userEmail = "davidvivarbogonez@gmail.com";
  };

  xdg.configFile."kitty/kitty.conf" = {
    text = kittyConfig;
    force = true;
  };

  xdg.configFile."helix/config.toml" = {
    text = helixConfig;
    force = true;
  };
}
