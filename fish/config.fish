if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting

# dotnet
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_ROOT="$HOME/.dotnet"
export PATH="$DOTNET_ROOT:$DOTNET_ROOT/tools:$PATH"

# volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# rust
export CARGO_HOME="$HOME/.cargo"
export PATH="$CARGO_HOME/bin:$PATH"

# uv 
export UV_INSTALL_DIR="$HOME/.uv"
export UV_TOOL_BIN_DIR="$HOME/.local/bin"
export PATH="$UV_INSTALL_DIR:$PATH"
export PATH="$UV_TOOL_BIN_DIR:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# go
export GOROOT="$HOME/.go"
export GOPATH="$HOME/.local/share/go"
export PATH="$GOROOT/bin:$PATH"

