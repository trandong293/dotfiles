if status is-interactive
end

set -U fish_greeting

# gnupg
set -x GPG_TTY $(tty)
set -x GNUPGHOME "$HOME/.config/gnupg"

# pnpm
set -x PNPM_HOME "$HOME/.local/share/pnpm"
fish_add_path "$PNPM_HOME/bin"

# dotnet
set -x DOTNET_CLI_TELEMETRY_OPTOUT 1
set -x DOTNET_NOLOGO 1
set -x DOTNET_CLI_HOME "$HOME/.local/share/dotnet"
set -x DOTNET_ROOT "$DOTNET_CLI_HOME/dotnet-current"
set -x NUGET_PACKAGES "$DOTNET_CLI_HOME/nuget/packages"
set -l DOTNET_TOOL "$DOTNET_CLI_HOME/.dotnet/tools"
fish_add_path "$DOTNET_ROOT"
fish_add_path "$DOTNET_TOOL"

# uv 
set -l UV_HOME "$HOME/.local/share/uv"
set -x UV_TOOL_DIR "$UV_HOME/tools"
set -x UV_TOOL_BIN_DIR "$UV_HOME/bin"
fish_add_path "$UV_TOOL_BIN_DIR"

# go
set -x GOPATH "$HOME/.local/share/go"
fish_add_path "$GOPATH/bin"

# rust
set -x RUSTUP_HOME "$HOME/.local/share/rustup"
set -x CARGO_HOME "$HOME/.local/share/cargo"
