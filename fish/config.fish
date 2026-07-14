if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
fish_add_path "$PNPM_HOME/bin"

# dotnet
set -gx DOTNET_CLI_TELEMETRY_OPTOUT 1 # stupid telemetry
# used only when running apps via generated executables (apphost.exe), so local only is enough
# https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-environment-variables#dotnet_root-dotnet_rootx86-dotnet_root_x86-dotnet_root_x64
set -l DOTNET_ROOT "$HOME/.local/share/dotnet/dotnet-current"
fish_add_path "$DOTNET_ROOT"
set -l DOTNET_TOOL "$HOME/.local/share/dotnet/tools"
fish_add_path "$DOTNET_TOOL"

# uv 
set -gx UV_INSTALL_DIR "$HOME/.local/share/uv"
fish_add_path "$UV_INSTALL_DIR"
set -gx UV_TOOL_BIN_DIR "$UV_INSTALL_DIR/tools"
fish_add_path "$UV_TOOL_BIN_DIR"
set -gx UV_PYTHON_BIN_DIR "$UV_INSTALL_DIR/python"

# go
set -gx GOROOT "$HOME/.local/share/golang/go-current"
fish_add_path "$GOROOT/bin"
set -gx GOPATH "$HOME/.local/share/golang/go-current/packages"
