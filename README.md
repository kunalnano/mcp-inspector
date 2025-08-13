# 🔍 MCP Inspector

Real-time monitoring dashboard for MCP (Model Context Protocol) servers. Track all tool calls, response times, and usage patterns from Claude or any MCP-compatible client.

![MCP Inspector Dashboard](https://img.shields.io/badge/MCP-Inspector-purple)
![License](https://img.shields.io/badge/license-MIT-blue)
![Node](https://img.shields.io/badge/node-%3E%3D18.0.0-green)

## 📊 Features

- **Real-time Monitoring**: Live dashboard with instant updates
- **Beautiful Visualizations**: Charts for request timeline and tool usage distribution
- **Detailed Metrics**: Track response times, success rates, and tool usage
- **Request History**: View recent requests with arguments and responses
- **CLI Tool**: Easy-to-use command-line interface
- **Multiple Modes**: Run as standalone server or proxy for existing MCP servers

## 🚀 Quick Start

### Install via NPM

```bash
npm install -g mcp-inspector
```

### Start the Dashboard

```bash
# Start MCP Inspector with dashboard
mcp-inspector start

# Dashboard will open at http://localhost:3456
```

## 🛠️ Usage Modes

### 1. Standalone MCP Server Mode

Monitor your own MCP tools:

```bash
mcp-inspector start
```

Then configure Claude Desktop to use MCP Inspector:

```bash
# Generate config for Claude Desktop
mcp-inspector generate-config

# Copy the output to:
# ~/Library/Application Support/Claude/claude_desktop_config.json
```

### 2. Proxy Mode

Monitor existing MCP servers by proxying requests:

```bash
mcp-inspector start --proxy

# Configure your MCP client to connect through localhost:3457
```

### 3. Direct Server Mode (for Claude)

Run as an MCP server that Claude can connect to directly:

```bash
mcp-inspector server
```

## 📈 Analyze Metrics

Generate reports from collected metrics:

```bash
mcp-inspector analyze

# Or specify a custom metrics file
mcp-inspector analyze -f ./path/to/metrics.json
```

## 🎨 Dashboard Features

- **Live Metrics**: Total requests, average response time, success rate
- **Timeline Chart**: Visualize response times over time
- **Tool Distribution**: See which tools are used most
- **Request Table**: Detailed view of recent requests
- **Real-time Updates**: Auto-refresh with WebSocket streaming

## 🔧 CLI Options

```bash
mcp-inspector start [options]
  -p, --port <port>       Dashboard port (default: 3456)
  -m, --mcp-port <port>   MCP server port (default: 3457)
  --no-open               Don't open browser automatically
  --proxy                 Start in proxy mode

mcp-inspector generate-config [options]
  -n, --name <name>       Server name (default: mcp-inspector)

mcp-inspector analyze [options]
  -f, --file <path>       Metrics file path (default: .mcp-inspector/metrics.json)
```

## 📦 Development

### Clone and Install

```bash
git clone https://github.com/yourusername/mcp-inspector.git
cd mcp-inspector
npm install
```

### Run in Development

```bash
npm run dev
```

### Build

```bash
npm run build
```

## 🤝 How It Works

MCP Inspector acts as a monitoring layer for MCP (Model Context Protocol) servers:

1. **Intercepts Requests**: Captures all tool calls from Claude or other MCP clients
2. **Logs Metrics**: Records timing, arguments, and responses
3. **Visualizes Data**: Displays real-time charts and tables
4. **Provides Analytics**: Generates reports on usage patterns

## 📝 Data Storage

Metrics are stored in `.mcp-inspector/metrics.json` in your current directory. The file is automatically created and updated as requests come in.

## 🔒 Privacy

All data is stored locally on your machine. No metrics are sent to external servers.

## 📄 License

MIT License - feel free to use in your own projects!

## 🐛 Issues & Contributions

Found a bug or have a feature request? Please open an issue on GitHub!

Contributions are welcome! Please feel free to submit a Pull Request.

## 🙏 Acknowledgments

Built for the MCP (Model Context Protocol) ecosystem by Anthropic.

---

Made with ❤️ for developers building with Claude and MCP