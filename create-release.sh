#!/bin/bash

# Create GitHub release with gh CLI

VERSION=${1:-v1.0.1}

echo "📦 Creating GitHub release $VERSION..."

# Create release notes
cat > release-notes.md << EOF
## 🚀 MCP Inspector $VERSION

### Installation

**Quick Install:**
\`\`\`bash
curl -sSL https://raw.githubusercontent.com/kunalnano/mcp-inspector/main/install.sh | bash
\`\`\`

**Homebrew:**
\`\`\`bash
brew tap kunalnano/mcp-inspector https://github.com/kunalnano/mcp-inspector
brew install mcp-inspector
\`\`\`

### What's New in $VERSION

#### 🐛 Fixes
- Fixed dashboard layout issues with chart heights
- Resolved page stretching problems
- Fixed table overflow with proper scrolling
- Added sticky headers for better UX

#### ✨ Features
- One-line install script
- Homebrew support (formula in main repo)
- Version display in CLI

#### 📊 Improvements
- Simplified installation to 2 main methods
- Better responsive design
- Enhanced performance

### Usage

Start the dashboard:
\`\`\`bash
mcp-inspector start
\`\`\`

View metrics:
\`\`\`bash
mcp-inspector analyze
\`\`\`

### Port.io Integration

MCP Inspector automatically tracks all Port.io operations including:
- Blueprint operations
- Entity CRUD
- AI Agent invocations
- Action executions

### Documentation

Full docs: [README](https://github.com/kunalnano/mcp-inspector#readme)

---
**Full Changelog**: https://github.com/kunalnano/mcp-inspector/compare/v1.0.0...$VERSION
EOF

# Create the release
gh release create "$VERSION" \
  --title "MCP Inspector $VERSION" \
  --notes-file release-notes.md \
  --repo kunalnano/mcp-inspector

rm release-notes.md

echo "✅ Release $VERSION created!"
echo "View at: https://github.com/kunalnano/mcp-inspector/releases/tag/$VERSION"