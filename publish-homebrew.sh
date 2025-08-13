#!/bin/bash

# Script to publish mcp-inspector to Homebrew
# Run this after publishing to npm

echo "📦 Setting up Homebrew tap for mcp-inspector..."

# Get the npm package info
NPM_VERSION=$(npm view mcp-inspector version)
NPM_TARBALL=$(npm view mcp-inspector dist.tarball)

# Download tarball to calculate SHA256
echo "⬇️  Downloading package to calculate SHA256..."
curl -sL "$NPM_TARBALL" -o mcp-inspector.tgz
SHA256=$(shasum -a 256 mcp-inspector.tgz | cut -d' ' -f1)
rm mcp-inspector.tgz

echo "📝 Package info:"
echo "  Version: $NPM_VERSION"
echo "  SHA256: $SHA256"

# Create homebrew tap repository structure
echo "🍺 Creating Homebrew tap..."
mkdir -p homebrew-mcp-inspector/Formula

# Generate the formula
cat > homebrew-mcp-inspector/Formula/mcp-inspector.rb << EOF
class McpInspector < Formula
  desc "Real-time monitoring dashboard for MCP (Model Context Protocol) servers"
  homepage "https://github.com/yourusername/mcp-inspector"
  url "$NPM_TARBALL"
  sha256 "$SHA256"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mcp-inspector --version")
  end
end
EOF

echo "✅ Formula created!"
echo ""
echo "Next steps:"
echo "1. Create a new GitHub repo: homebrew-mcp-inspector"
echo "2. Push the Formula directory to it"
echo "3. Users can then install with:"
echo "   brew tap yourusername/mcp-inspector"
echo "   brew install mcp-inspector"