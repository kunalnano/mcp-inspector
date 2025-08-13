# 🔍 MCP Monitor

[![GitHub Stars](https://img.shields.io/github/stars/kunalnano/mcp-monitor)](https://github.com/kunalnano/mcp-monitor/stargazers)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![GitHub Release](https://img.shields.io/github/v/release/kunalnano/mcp-monitor)](https://github.com/kunalnano/mcp-monitor/releases)

**Real-time monitoring dashboard for MCP (Model Context Protocol) servers.** Track all tool calls, response times, and usage patterns from Claude, Port.io, or any MCP-compatible client.

> **Note:** MCP Monitor is a simple, authentication-free monitoring tool focused on Port.io integration and beautiful dashboards.

## 🎯 Why MCP Monitor?

Monitor everything happening between AI assistants and their tools:
- **Port.io API calls** from Claude
- **Custom MCP tools** performance  
- **Error tracking** and debugging
- **Usage analytics** and patterns

## 📊 Features

- ⚡ **Real-time Dashboard** - Live metrics with auto-refresh at http://localhost:3456
- 📈 **Performance Charts** - Response time timeline & tool usage distribution  
- 🔍 **Request History** - Detailed table with arguments and responses
- 🛠️ **Simple CLI** - No authentication needed, just run and monitor
- 🎨 **Beautiful UI** - Professional gradient design with animations

## 🚀 Installation

### Option 1: Direct Install (Recommended)

```bash
# Clone and install
git clone https://github.com/kunalnano/mcp-monitor.git
cd mcp-monitor
npm install
npm run build

# Start the dashboard
npm start
```

### Option 2: Quick Install Script

```bash
curl -sSL https://raw.githubusercontent.com/kunalnano/mcp-monitor/main/install.sh | bash
```

### Option 3: Homebrew (macOS)

```bash
brew tap kunalnano/mcp-monitor https://github.com/kunalnano/mcp-monitor
brew install mcp-monitor
```

## 📖 Quick Start

### 1. Start the Dashboard

```bash
# From the mcp-monitor directory
npm start

# Or if installed globally
mcp-monitor start
```

Dashboard opens at **http://localhost:3456**

### 2. No Configuration Needed!

Unlike other tools, MCP Monitor works immediately:
- No proxy authentication
- No complex setup
- No token configuration
- Just run and monitor!

### 3. Watch Live Metrics

Every MCP tool call appears in real-time with:
- Response times
- Success/failure status
- Tool usage distribution
- Request history

## 🛠️ CLI Commands

| Command | Description |
|---------|-------------|
| `mcp-monitor start` | Launch dashboard at port 3456 |
| `mcp-monitor analyze` | Show metrics summary |
| `mcp-monitor generate-config` | Generate Claude config |
| `mcp-monitor --version` | Show version |

### Options

```bash
mcp-monitor start --port 4000  # Custom port
mcp-monitor start --no-open    # Don't auto-open browser
```

## 🔌 Port.io Integration

Specifically designed for Port.io operations:
- Blueprint management (`list_blueprints`, `get_blueprint`)
- Entity CRUD (`get_entities`, `create_entity`, `update_entity`)  
- AI Agent calls (`invoke_ai_agent`)
- Action executions
- Search operations

## 📊 Dashboard Features

### Live Metrics
- **Total Requests** - Count of all MCP tool calls
- **Average Response Time** - Execution time in milliseconds
- **Success Rate** - Percentage of successful calls
- **Unique Tools** - Number of different tools used

### Visualizations
- **Timeline Chart** - Response times over time
- **Tool Distribution** - Doughnut chart of usage
- **Request Table** - Detailed history with search

### Simple Setup
- ✅ No authentication tokens
- ✅ No proxy configuration  
- ✅ Direct connection to MCP
- ✅ Works out of the box

## 🧑‍💻 Development

```bash
# Clone repository
git clone https://github.com/kunalnano/mcp-monitor.git
cd mcp-monitor

# Install dependencies
npm install

# Development mode
npm run dev

# Build for production
npm run build

# Start dashboard
npm start
```

## 📁 Project Structure

```
mcp-monitor/
├── src/                 # TypeScript source
│   ├── cli.ts          # CLI entry point
│   ├── dashboard-server.ts
│   └── mcp-server.ts
├── public/             # Dashboard UI
│   └── index.html      # Beautiful dashboard
├── Formula/            # Homebrew formula
├── dist/              # Compiled JavaScript
└── package.json
```

## 📝 Data Storage

Metrics are stored locally in `.mcp-inspector/metrics.json`

## 🤝 Contributing

1. Fork the repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Open Pull Request

## 📄 License

MIT License - see [LICENSE](LICENSE)

## 🙏 Acknowledgments

Built for the MCP ecosystem. Special thanks to Port.io users!

---

<p align="center">
  <b>The Simple MCP Monitoring Solution</b><br>
  <a href="https://github.com/kunalnano/mcp-monitor">⭐ Star on GitHub</a>
</p>