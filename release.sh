#!/bin/bash

# Release script for MCP Inspector
# Usage: ./release.sh [patch|minor|major]

VERSION_TYPE=${1:-patch}

echo "🚀 Releasing MCP Inspector..."

# Ensure we're on main branch
BRANCH=$(git branch --show-current)
if [ "$BRANCH" != "main" ]; then
  echo "❌ Must be on main branch to release"
  exit 1
fi

# Ensure working directory is clean
if [ -n "$(git status --porcelain)" ]; then
  echo "❌ Working directory is not clean. Commit or stash changes."
  exit 1
fi

# Pull latest changes
echo "📥 Pulling latest changes..."
git pull origin main

# Run tests (when we have them)
# echo "🧪 Running tests..."
# npm test

# Build the project
echo "🔨 Building project..."
npm run build

# Bump version
echo "📝 Bumping version ($VERSION_TYPE)..."
npm version $VERSION_TYPE -m "🔖 Release v%s"

# Get new version
NEW_VERSION=$(node -p "require('./package.json').version")

echo "✨ New version: v$NEW_VERSION"

# Push changes and tags
echo "📤 Pushing to GitHub..."
git push origin main
git push origin --tags

# Publish to NPM
echo "📦 Publishing to NPM..."
npm publish

# Create GitHub release
echo "📋 Creating GitHub release..."
gh release create "v$NEW_VERSION" \
  --title "Release v$NEW_VERSION" \
  --notes "## What's New

### Features
- Real-time monitoring dashboard
- Port.io integration support
- CLI tools for analysis

### Installation
\`\`\`bash
npm install -g mcp-inspector@$NEW_VERSION
\`\`\`

See [README](https://github.com/kunalnano/mcp-inspector#readme) for full documentation."

echo "✅ Release v$NEW_VERSION complete!"
echo ""
echo "Next steps:"
echo "1. Check NPM: https://www.npmjs.com/package/mcp-inspector"
echo "2. Check GitHub: https://github.com/kunalnano/mcp-inspector/releases"
echo "3. Update Homebrew formula (if applicable)"