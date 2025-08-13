#!/bin/bash

# Script to update Homebrew formula after a new release

VERSION=$1

if [ -z "$VERSION" ]; then
  echo "Usage: ./update-homebrew.sh v1.0.0"
  exit 1
fi

echo "📦 Updating Homebrew formula for version $VERSION..."

# Download the release tarball to get SHA256
TARBALL_URL="https://github.com/kunalnano/mcp-inspector/archive/refs/tags/$VERSION.tar.gz"
echo "⬇️  Downloading tarball..."
curl -sL "$TARBALL_URL" -o mcp-inspector.tar.gz

# Calculate SHA256
SHA256=$(shasum -a 256 mcp-inspector.tar.gz | cut -d' ' -f1)
rm mcp-inspector.tar.gz

echo "✅ SHA256: $SHA256"

# Update the formula
cat > ../homebrew-mcp-inspector/mcp-inspector.rb << EOF
class McpInspector < Formula
  desc "Real-time monitoring dashboard for MCP (Model Context Protocol) servers"
  homepage "https://github.com/kunalnano/mcp-inspector"
  url "https://github.com/kunalnano/mcp-inspector/archive/refs/tags/$VERSION.tar.gz"
  sha256 "$SHA256"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", "--production"
    system "npm", "run", "build"
    
    libexec.install Dir["*"]
    
    # Create wrapper script
    (bin/"mcp-inspector").write <<~EOS
      #!/bin/bash
      export NODE_PATH="#{libexec}/node_modules"
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/dist/cli.js" "\$@"
    EOS
  end

  test do
    assert_match "mcp-inspector", shell_output("#{bin}/mcp-inspector --version")
  end
end
EOF

echo "📝 Formula updated!"
echo ""
echo "Next steps:"
echo "1. cd ../homebrew-mcp-inspector"
echo "2. git add ."
echo "3. git commit -m 'Update to $VERSION'"
echo "4. git push"
echo ""
echo "Users can now install with:"
echo "  brew tap kunalnano/mcp-inspector"
echo "  brew install mcp-inspector"