# 🔍 MCP Inspector

[![GitHub Stars](https://img.shields.io/github/stars/kunalnano/mcp-inspector)](https://github.com/kunalnano/mcp-inspector/stargazers)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![GitHub Release](https://img.shields.io/github/v/release/kunalnano/mcp-inspector)](https://github.com/kunalnano/mcp-inspector/releases)

**Real-time monitoring dashboard for MCP (Model Context Protocol) servers.** Track all tool calls, response times, and usage patterns from Claude, Port.io, or any MCP-compatible client.

## 🎯 Why MCP Inspector?

Monitor everything happening between AI assistants and their tools:
- **Port.io API calls** from Claude
- **Custom MCP tools** performance
- **Error tracking** and debugging
- **Usage analytics** and patterns

## 📊 Features

- ⚡ **Real-time Dashboard** - Live metrics with auto-refresh
- 📈 **Performance Charts** - Response time timeline & tool usage distribution  
- 🔍 **Request History** - Detailed table with arguments and responses
- 🛠️ **CLI Tools** - Simple commands for monitoring and analysis
- 🎨 **Beautiful UI** - Professional gradient design with animations

## 🚀 Installation

### Option 1: One-Line Install (Recommended)

```bash
curl -sSL https://raw.githubusercontent.com/kunalnano/mcp-inspector/main/install.sh | bash
```

### Option 2: Homebrew (macOS)

```bash
brew tap kunalnano/mcp-inspector https://github.com/kunalnano/mcp-inspector
brew install mcp-inspector
```

### Option 3: Manual Install

```bash
git clone https://github.com/kunalnano/mcp-inspector.git
cd mcp-inspector
npm install
npm run build
npm start
```

## 📖 Quick Start

### 1. Start the Dashboard

```bash
mcp-inspector start
```

Dashboard opens at **http://localhost:3456**

### 2. Configure Your MCP Client (Optional)

For Claude Desktop:
```bash
mcp-inspector generate-config
```

Copy output to: `~/Library/Application Support/Claude/claude_desktop_config.json`

### 3. Watch Live Metrics

Every MCP tool call now appears in real-time!

## 🛠️ CLI Commands

| Command | Description |
|---------|-------------|
| `mcp-inspector start` | Launch dashboard |
| `mcp-inspector analyze` | Show metrics summary |
| `mcp-inspector generate-config` | Create Claude config |
| `mcp-inspector --version` | Show version |

### Options

```bash
mcp-inspector start --port 4000  # Custom port
mcp-inspector start --no-open    # Don't auto-open browser
```

## 🔌 Port.io Integration

Automatically tracks all Port.io operations:
- Blueprint management (`list_blueprints`, `get_blueprint`)
- Entity CRUD (`get_entities`, `create_entity`, `update_entity`)  
- AI Agent calls (`invoke_ai_agent`)
- Action executions
- Search operations

## 📊 Dashboard Features

### Live Metrics
- Total Requests Count
- Average Response Time
- Success Rate Percentage
- Unique Tools Used

### Visualizations
- **Timeline Chart** - Response times over time
- **Tool Distribution** - Doughnut chart of usage
- **Request Table** - Detailed history with filtering

## 🧑‍💻 Development

```bash
# Clone repository
git clone https://github.com/kunalnano/mcp-inspector.git
cd mcp-inspector

# Install dependencies
npm install

# Development mode with hot reload
npm run dev

# Build for production
npm run build

# Run tests
npm test
```

## 📁 Project Structure

```
mcp-inspector/
├── src/                 # TypeScript source
│   ├── cli.ts          # CLI entry point
│   ├── dashboard-server.ts
│   ├── mcp-server.ts
│   └── proxy-server.ts
├── public/             # Dashboard UI
│   └── index.html
├── Formula/            # Homebrew formula
│   └── mcp-inspector.rb
├── dist/              # Compiled JavaScript
└── package.json
```

## 📝 Data Storage

Metrics are stored locally in `.mcp-inspector/metrics.json`

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
  ]
}
```

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing`)
3. Commit changes (`git commit -m 'Add feature'`)
4. Push to branch (`git push origin feature/amazing`)
5. Open Pull Request

## 📄 License

MIT License - see [LICENSE](LICENSE)

## 🙏 Acknowledgments

Built for the MCP ecosystem by the community. Special thanks to Port.io users!

---

<p align="center">
  <a href="https://github.com/kunalnano/mcp-inspector">⭐ Star on GitHub</a>
</p>