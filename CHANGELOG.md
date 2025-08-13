# Changelog

All notable changes to MCP Inspector will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.1] - 2025-01-16

### Fixed
- Fixed dashboard layout issues with chart container heights
- Resolved page stretching problems by constraining chart sizes
- Fixed table overflow with proper scrolling
- Added sticky headers for better UX
- Fixed CI/CD by adding package-lock.json
- Consolidated branches to use main as default

### Added
- Homebrew installation support for macOS
- Automated Homebrew formula updates
- Version display in CLI (--version flag)
- Simplified installation instructions

### Changed
- Simplified README to focus on two installation methods
- Improved responsive design for mobile devices
- Enhanced chart rendering performance

## [1.0.0] - 2025-01-16

### Added
- Initial release of MCP Inspector
- Real-time monitoring dashboard with live updates
- Response time timeline chart
- Tool usage distribution chart
- Request history table with filtering
- CLI commands: `start`, `analyze`, `generate-config`
- Proxy mode for monitoring existing MCP servers
- Port.io integration support
- WebSocket streaming for real-time updates
- Metrics persistence in JSON format
- Beautiful gradient UI with animations
- Responsive design for mobile devices

### Fixed
- Dashboard layout issues with chart sizing
- Fixed chart container heights to prevent page stretching
- Improved table scrolling and overflow handling
- Added proper viewport constraints

### Technical
- Built with TypeScript for type safety
- Express.js backend with SSE support
- Chart.js for data visualization
- MCP SDK integration
- Modular architecture for extensibility

## [0.9.0] - 2025-01-15 (Pre-release)

### Added
- Beta version for testing
- Basic dashboard functionality
- CLI structure

---

## Release Notes Format

For each release:
- **Added** for new features
- **Changed** for changes in existing functionality
- **Deprecated** for soon-to-be removed features
- **Removed** for now removed features
- **Fixed** for any bug fixes
- **Security** in case of vulnerabilities