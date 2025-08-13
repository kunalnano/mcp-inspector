class McpInspector < Formula
  desc "Real-time monitoring dashboard for MCP (Model Context Protocol) servers"
  homepage "https://github.com/kunalnano/mcp-inspector"
  url "https://github.com/kunalnano/mcp-inspector/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "017782df2b28f423a8a7df92d8d335939af75922f187946ac642e27693df39ba"
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
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/dist/cli.js" "$@"
    EOS
  end

  test do
    assert_match "mcp-inspector", shell_output("#{bin}/mcp-inspector --version")
  end
end
