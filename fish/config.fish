if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting

# pnpm
set -x PNPM_HOME "$HOME/.local/share/pnpm"
fish_add_path "$PNPM_HOME/bin"

# dotnet
set -x DOTNET_CLI_TELEMETRY_OPTOUT 1 # stupid telemetry
set DOTNET_ROOT "$HOME/.local/share/dotnet/dotnet-current"
set DOTNET_TOOL "$HOME/.local/share/dotnet/tools"
fish_add_path "$DOTNET_ROOT"
fish_add_path "$DOTNET_TOOL"

# uv 
set -x UV_INSTALL_DIR "$HOME/.local/share/uv" # installation only
set -x UV_TOOL_BIN_DIR "$UV_INSTALL_DIR/tools"
set -x UV_PYTHON_BIN_DIR "$UV_INSTALL_DIR/python"
fish_add_path "$UV_INSTALL_DIR"
fish_add_path "$UV_TOOL_BIN_DIR"

# go
set -x GOROOT "$HOME/.local/share/golang/go-current"
set -x GOPATH "$GOROOT/packages"
fish_add_path "$GOROOT/bin"
fish_add_path "$GOPATH/bin"
