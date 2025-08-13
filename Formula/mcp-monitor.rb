class McpMonitor < Formula
  desc "Real-time monitoring dashboard for MCP (Model Context Protocol) servers"
  homepage "https://github.com/kunalnano/mcp-monitor"
  url "https://github.com/kunalnano/mcp-monitor/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "PLACEHOLDER_SHA256_WILL_BE_UPDATED"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", "--production"
    system "npm", "run", "build"
    
    libexec.install Dir["*"]
    
    # Create wrapper script
    (bin/"mcp-monitor").write <<~EOS
      #!/bin/bash
      export NODE_PATH="#{libexec}/node_modules"
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/dist/cli.js" "$@"
    EOS
  end

  test do
    assert_match "mcp-monitor", shell_output("#{bin}/mcp-monitor --version")
  end
end