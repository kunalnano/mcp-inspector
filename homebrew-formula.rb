class McpInspector < Formula
  desc "Real-time monitoring dashboard for MCP (Model Context Protocol) servers"
  homepage "https://github.com/yourusername/mcp-inspector"
  url "https://registry.npmjs.org/mcp-inspector/-/mcp-inspector-1.0.0.tgz"
  sha256 "PLACEHOLDER_SHA256"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "MCP Inspector", shell_output("#{bin}/mcp-inspector --version")
  end
end