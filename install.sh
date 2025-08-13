#!/bin/bash

# Quick install script for MCP Inspector
# Run with: curl -sSL https://raw.githubusercontent.com/kunalnano/mcp-inspector/main/install.sh | bash

set -e

echo "🔍 Installing MCP Inspector..."

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
echo "📦 Downloading MCP Inspector..."
INSTALL_DIR="$HOME/.mcp-inspector"
rm -rf "$INSTALL_DIR"
git clone https://github.com/kunalnano/mcp-inspector.git "$INSTALL_DIR"

# Install dependencies and build
echo "🔨 Building..."
cd "$INSTALL_DIR"
npm install
npm run build

# Create symlink
echo "🔗 Creating command..."
mkdir -p "$HOME/.local/bin"
cat > "$HOME/.local/bin/mcp-inspector" << 'EOF'
#!/bin/bash
node "$HOME/.mcp-inspector/dist/cli.js" "$@"
EOF
chmod +x "$HOME/.local/bin/mcp-inspector"

# Add to PATH if needed
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo "" >> "$HOME/.bashrc"
    echo "# MCP Inspector" >> "$HOME/.bashrc"
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    echo "" >> "$HOME/.zshrc"
    echo "# MCP Inspector" >> "$HOME/.zshrc"
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
    export PATH="$HOME/.local/bin:$PATH"
fi

echo "✅ MCP Inspector installed successfully!"
echo ""
echo "Run 'mcp-inspector start' to launch the dashboard"
echo ""
echo "If the command is not found, restart your terminal or run:"
echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""