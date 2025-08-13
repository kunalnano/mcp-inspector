# 🔍 MCP Inspector

[![npm version](https://img.shields.io/npm/v/mcp-inspector.svg)](https://www.npmjs.com/package/mcp-inspector)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![GitHub Stars](https://img.shields.io/github/stars/kunalnano/mcp-inspector)](https://github.com/kunalnano/mcp-inspector/stargazers)
[![GitHub Issues](https://img.shields.io/github/issues/kunalnano/mcp-inspector)](https://github.com/kunalnano/mcp-inspector/issues)

**Real-time monitoring dashboard for MCP (Model Context Protocol) servers.** Track all tool calls, response times, and usage patterns from Claude, Port.io, or any MCP-compatible client.

![MCP Inspector Dashboard](https://img.shields.io/badge/Dashboard-Live-green)

## 🎯 Why MCP Inspector?

If you're using MCP servers with Claude, Port.io, or building your own MCP tools, you need visibility into what's happening. MCP Inspector gives you:

- **Real-time Monitoring** - See every tool call as it happens
- **Performance Metrics** - Track response times and success rates
- **Usage Analytics** - Understand which tools are used most
- **Error Tracking** - Debug failed requests instantly
- **Beautiful Dashboard** - Professional UI with live charts

Perfect for:
- **Port.io Users** - Monitor all Port API calls from Claude
- **MCP Developers** - Debug and optimize your custom tools
- **DevOps Teams** - Track API usage and performance
- **Cost Management** - Monitor API call patterns

## 📊 Features

### Live Dashboard
- **Real-time Metrics Cards** - Total requests, avg response time, success rate, unique tools
- **Response Timeline Chart** - Visualize performance over time
- **Tool Usage Distribution** - Pie chart showing most-used tools
- **Request History Table** - Detailed view with arguments and responses
- **Auto-refresh** - Updates every second via WebSocket

### CLI Tools
- **Dashboard Server** - `mcp-inspector start`
- **Metrics Analysis** - `mcp-inspector analyze`
- **Config Generation** - `mcp-inspector generate-config`
- **Proxy Mode** - Monitor existing MCP servers

### Port.io Integration
Specifically designed to work with Port.io tools:
- `Port.io:list_blueprints`
- `Port.io:get_entities`
- `Port.io:create_entity`
- `Port.io:update_entity`
- `Port.io:invoke_ai_agent`
- And all other Port.io MCP tools

## 🚀 Quick Start

### Install via NPM

```bash
npm install -g mcp-inspector
```

### Start Monitoring

```bash
# Start the dashboard (opens at http://localhost:3456)
mcp-inspector start

# Custom port
mcp-inspector start --port 4000

# Don't auto-open browser
mcp-inspector start --no-open
```

## 🛠️ Installation Methods

### Method 1: NPM Global Install (Recommended)

```bash
npm install -g mcp-inspector
mcp-inspector start
```

### Method 2: NPX (No Install)

```bash
npx mcp-inspector start
```

### Method 3: From Source

```bash
git clone https://github.com/kunalnano/mcp-inspector.git
cd mcp-inspector
npm install
npm run build
npm start
```

### Method 4: Homebrew (macOS) - Coming Soon

```bash
brew tap kunalnano/mcp-inspector
brew install mcp-inspector
```

## 📖 Usage Guide

### Basic Monitoring

1. **Start MCP Inspector**
   ```bash
   mcp-inspector start
   ```

2. **Configure Your MCP Client**
   
   For Claude Desktop:
   ```bash
   mcp-inspector generate-config
   ```
   
   Copy the output to `~/Library/Application Support/Claude/claude_desktop_config.json`

3. **Start Using MCP Tools**
   
   Every tool call will now appear in the dashboard!

### Proxy Mode

Monitor existing MCP servers without modification:

```bash
# Start in proxy mode
mcp-inspector start --proxy

# Point your MCP client to localhost:3457
```

### Analyze Historical Data

```bash
# Show metrics summary
mcp-inspector analyze

# Analyze specific file
mcp-inspector analyze -f ./metrics-backup.json
```

### Port.io Specific Setup

For Port.io users, MCP Inspector automatically tracks:
- Blueprint operations (list, get, create, update)
- Entity CRUD operations
- AI Agent invocations
- Action executions
- Search operations

Just start MCP Inspector and use Port.io tools as normal!

## 📊 Dashboard Features

### Metrics Cards
- **Total Requests** - Count of all MCP tool calls
- **Avg Response Time** - Average execution time in ms
- **Success Rate** - Percentage of successful calls
- **Unique Tools** - Number of different tools used

### Charts
- **Timeline Chart** - Line graph of response times
- **Tool Distribution** - Doughnut chart of tool usage
- **Live Updates** - Real-time data streaming

### Request Table
- Timestamp of each request
- Tool name and arguments
- Response time
- Success/error status
- Scrollable history

## 🔧 Configuration

### Environment Variables

```bash
# Dashboard port
PORT=3456

# MCP server port
MCP_PORT=3457

# Data directory
DATA_DIR=.mcp-inspector
```

### Data Storage

Metrics are stored in `.mcp-inspector/metrics.json`:

```json
{
  "requests": [
    {
      "id": "1234567890",
      "tool": "Port.io:get_entities",
      "arguments": {...},
      "timestamp": "2025-01-16T10:00:00Z",
      "responseTime": 145,
      "success": true
    }
  ],
  "summary": {
    "totalRequests": 100,
    "averageResponseTime": 200,
    "successRate": 95
  }
}
```

## 🧑‍💻 Development

### Setup Development Environment

```bash
# Clone the repo
git clone https://github.com/kunalnano/mcp-inspector.git
cd mcp-inspector

# Install dependencies
npm install

# Run in development mode
npm run dev
```

### Project Structure

```
mcp-inspector/
├── src/
│   ├── cli.ts              # CLI entry point
│   ├── dashboard-server.ts  # Express server for dashboard
│   ├── mcp-server.ts       # MCP server implementation
│   └── proxy-server.ts     # Proxy for monitoring
├── public/
│   └── index.html          # Dashboard UI
├── package.json
├── tsconfig.json
└── README.md
```

### Building

```bash
# Build TypeScript
npm run build

# Run tests
npm test

# Lint code
npm run lint
```

## 🏷️ Versioning

We use [Semantic Versioning](https://semver.org/):

- **MAJOR.MINOR.PATCH**
- Current version: `1.0.0`

### Release Process

```bash
# Update version
npm version patch  # or minor, major

# Push with tags
git push && git push --tags

# Publish to NPM
npm publish
```

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing`)
5. Open a Pull Request

### Development Guidelines

- Use TypeScript for all source code
- Follow existing code style
- Add tests for new features
- Update documentation
- Keep commits atomic and descriptive

## 🐛 Troubleshooting

### Dashboard Not Loading

```bash
# Check if port is in use
lsof -i :3456

# Kill process using port
kill -9 <PID>

# Try different port
mcp-inspector start --port 4000
```

### No Metrics Showing

1. Ensure MCP server is configured correctly
2. Check `.mcp-inspector/metrics.json` exists
3. Verify tool calls are being made
4. Check browser console for errors

### Connection Issues

```bash
# Test MCP server directly
mcp-inspector server

# Check logs
tail -f .mcp-inspector/logs.txt
```

## 📝 API Reference

### CLI Commands

```bash
mcp-inspector start [options]
  -p, --port <port>       Dashboard port (default: 3456)
  -m, --mcp-port <port>   MCP server port (default: 3457)
  --no-open               Don't open browser
  --proxy                 Proxy mode

mcp-inspector analyze [options]
  -f, --file <path>       Metrics file path

mcp-inspector generate-config [options]
  -n, --name <name>       Server name (default: mcp-inspector)
```

### REST API

```
GET /api/metrics        # Get all metrics
GET /api/stream        # SSE stream for real-time updates
```

## 🔒 Security

- All data stored locally
- No external API calls
- No telemetry or tracking
- Open source and auditable

## 📄 License

MIT License - see [LICENSE](LICENSE) file

## 🙏 Acknowledgments

- Built for the MCP ecosystem by Anthropic
- Inspired by the need for better MCP observability
- Special thanks to Port.io integration users

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/kunalnano/mcp-inspector/issues)
- **Discussions**: [GitHub Discussions](https://github.com/kunalnano/mcp-inspector/discussions)
- **Email**: your-email@example.com

## 🚦 Status

![Build Status](https://img.shields.io/github/actions/workflow/status/kunalnano/mcp-inspector/ci.yml)
![npm downloads](https://img.shields.io/npm/dm/mcp-inspector)
![GitHub last commit](https://img.shields.io/github/last-commit/kunalnano/mcp-inspector)

---

<p align="center">
  Made with ❤️ for the MCP community
  <br>
  <a href="https://github.com/kunalnano/mcp-inspector">⭐ Star us on GitHub!</a>
</p>