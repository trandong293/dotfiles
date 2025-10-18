if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# dotnet
# - there is no way to modify installation dir of global tools using envvar
# - fucking microsoft with stupid dotnet-install-scripts
export DOTNET_CLI_TELEMETRY_OPTOUT=1
set DOTNET_HOME "$HOME/.local/share/dotnet"
export DOTNET_ROOT="$DOTNET_HOME/dotnet_current"
set DOTNET_TOOL "$HOME/.dotnet/tools"
export PATH="$DOTNET_HOME:$DOTNET_TOOL:$PATH"

# uv 
export UV_INSTALL_DIR="$HOME/.local/share/uv"
export UV_TOOL_BIN_DIR="$UV_INSTALL_DIR/tools"
export PATH="$UV_INSTALL_DIR:$UV_TOOL_BIN_DIR:$PATH"

# go
set GO_HOME "$HOME/.local/share/go"
export GOROOT="$GO_HOME/go_current"
export GOPATH="$GO_HOME/packages"
export PATH="$GO_HOME:$GOPATH/bin:$PATH"

# rust
#export CARGO_HOME="$HOME/.cargo"
#export PATH="$CARGO_HOME/bin:$PATH"

# bun
#export BUN_INSTALL="$HOME/.bun"
#export PATH="$BUN_INSTALL/bin:$PATH"

