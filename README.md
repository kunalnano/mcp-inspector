# 🔍 MCP Inspector

[![GitHub Stars](https://img.shields.io/github/stars/kunalnano/mcp-inspector)](https://github.com/kunalnano/mcp-inspector/stargazers)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![GitHub Issues](https://img.shields.io/github/issues/kunalnano/mcp-inspector)](https://github.com/kunalnano/mcp-inspector/issues)

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

### Option 1: Homebrew (macOS) - Recommended

```bash
brew tap kunalnano/mcp-inspector
brew install mcp-inspector

# Start the dashboard
mcp-inspector start
```

### Option 2: Clone & Run

```bash
# Clone the repository
git clone https://github.com/kunalnano/mcp-inspector.git
cd mcp-inspector

# Install dependencies
npm install

# Build the project
npm run build

# Start the dashboard
npm start
```

Dashboard opens at **http://localhost:3456**

## 📖 Quick Start

### 1. Start Monitoring

```bash
mcp-inspector start
```

### 2. Configure Your MCP Client

For Claude Desktop:
```bash
mcp-inspector generate-config
```

Copy output to: `~/Library/Application Support/Claude/claude_desktop_config.json`

### 3. Watch Live Metrics

Every MCP tool call now appears in the dashboard!

## 🛠️ CLI Commands

```bash
mcp-inspector start          # Launch dashboard
mcp-inspector analyze        # Show metrics summary
mcp-inspector generate-config # Create Claude config
```

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

## 📊 Dashboard Views

### Metrics Cards
- Total Requests
- Average Response Time
- Success Rate
- Unique Tools Used

### Charts
- **Timeline** - Response times over time
- **Distribution** - Tool usage breakdown

### Request Table
- Timestamp, tool name, arguments
- Response time and status
- Scrollable history

## 🧑‍💻 Development

```bash
# Clone repo
git clone https://github.com/kunalnano/mcp-inspector.git
cd mcp-inspector

# Install deps
npm install

# Development mode
npm run dev

# Build
npm run build
```

## 📝 Data Storage

Metrics stored locally in `.mcp-inspector/metrics.json`

## 🤝 Contributing

1. Fork the repo
2. Create feature branch
3. Commit changes
4. Push to branch
5. Open Pull Request

## 📄 License

MIT License - see [LICENSE](LICENSE)

## 🙏 Credits

Built for the MCP ecosystem by the community.

---

<p align="center">
  <a href="https://github.com/kunalnano/mcp-inspector">⭐ Star on GitHub</a>
</p>