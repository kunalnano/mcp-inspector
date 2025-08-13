#!/bin/bash

# Quick install script for MCP Monitor
# Run with: curl -sSL https://raw.githubusercontent.com/kunalnano/mcp-monitor/main/install.sh | bash

set -e

echo "🔍 Installing MCP Monitor..."

# Check for Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is required but not installed."
    echo "Please install Node.js first: https://nodejs.org"
    exit 1
fi

# Check for git
if ! command -v git &> /dev/null; then
    echo "❌ Git is required but not installed."
    echo "Please install Git first: https://git-scm.com"
    exit 1
fi

# Clone repository
echo "📦 Downloading MCP Monitor..."
INSTALL_DIR="$HOME/.mcp-monitor"
rm -rf "$INSTALL_DIR"
git clone https://github.com/kunalnano/mcp-monitor.git "$INSTALL_DIR"

# Install dependencies and build
echo "🔨 Building..."
cd "$INSTALL_DIR"
npm install
npm run build

# Create symlink
echo "🔗 Creating command..."
mkdir -p "$HOME/.local/bin"
cat > "$HOME/.local/bin/mcp-monitor" << 'EOF'
#!/bin/bash
node "$HOME/.mcp-monitor/dist/cli.js" "$@"
EOF
chmod +x "$HOME/.local/bin/mcp-monitor"

# Add to PATH if needed
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo "" >> "$HOME/.bashrc"
    echo "# MCP Monitor" >> "$HOME/.bashrc"
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    echo "" >> "$HOME/.zshrc"
    echo "# MCP Monitor" >> "$HOME/.zshrc"
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
    export PATH="$HOME/.local/bin:$PATH"
fi

echo "✅ MCP Monitor installed successfully!"
echo ""
echo "Run 'mcp-monitor start' to launch the dashboard"
echo ""
echo "If the command is not found, restart your terminal or run:"
echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""