# 🔍 MCP Monitor (formerly MCP Inspector)

[![GitHub Stars](https://img.shields.io/github/stars/kunalnano/mcp-inspector)](https://github.com/kunalnano/mcp-inspector/stargazers)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![GitHub Release](https://img.shields.io/github/v/release/kunalnano/mcp-inspector)](https://github.com/kunalnano/mcp-inspector/releases)

**Real-time monitoring dashboard for MCP (Model Context Protocol) servers.** Track all tool calls, response times, and usage patterns from Claude, Port.io, or any MCP-compatible client.

> **Note:** This is MCP Monitor - a different tool from the other mcp-inspector. Our tool focuses on Port.io integration and provides a simple, beautiful dashboard without authentication complexity.

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
git clone https://github.com/kunalnano/mcp-inspector.git mcp-monitor
cd mcp-monitor
npm install
npm run build

# Start the dashboard
npm start
```

### Option 2: Quick Install Script

```bash
curl -sSL https://raw.githubusercontent.com/kunalnano/mcp-inspector/main/install.sh | bash
```

## 📖 Quick Start

### 1. Start the Dashboard

```bash
# From the mcp-monitor directory
npm start

# Or if installed globally
mcp-monitor start
```

Dashboard opens at **http://localhost:3456** (not 6274!)

### 2. No Configuration Needed!

Unlike other tools, MCP Monitor works immediately without:
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
| `npm start` | Launch dashboard at port 3456 |
| `mcp-monitor start` | Launch dashboard (if installed) |
| `mcp-monitor analyze` | Show metrics summary |
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

## 🆚 Comparison with Other Tools

| Feature | MCP Monitor (Ours) | Other mcp-inspector |
|---------|-------------------|---------------------|
| **Dashboard URL** | http://localhost:3456 | http://localhost:6274 |
| **Authentication** | None needed ✅ | Proxy token required |
| **Setup** | Simple - just run | Complex proxy setup |
| **Port.io Focus** | Yes ✅ | Generic |
| **Real-time Charts** | Yes ✅ | Limited |
| **Open Source** | Yes ✅ | Unknown |

## 📊 Dashboard Features

### What You'll See
- **Live Metrics Cards** - Total requests, response times, success rates
- **Timeline Chart** - Response times over time
- **Tool Distribution** - Pie chart of tool usage
- **Request Table** - Detailed history with search

### No Complex Setup
- ✅ No authentication tokens
- ✅ No proxy configuration  
- ✅ Direct connection to MCP
- ✅ Simple and straightforward

## 🧑‍💻 Development

```bash
# Clone repository
git clone https://github.com/kunalnano/mcp-inspector.git mcp-monitor
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
├── dist/              # Compiled JavaScript
└── package.json
```

## 🤝 Contributing

1. Fork the repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Open Pull Request

## 📄 License

MIT License - see [LICENSE](LICENSE)

## 🙏 Note

This is **MCP Monitor** - not to be confused with other similarly named tools. We focus on simplicity, Port.io integration, and a beautiful dashboard without complex authentication.

---

<p align="center">
  <b>The Simple MCP Monitoring Solution</b><br>
  <a href="https://github.com/kunalnano/mcp-inspector">⭐ Star on GitHub</a>
</p>