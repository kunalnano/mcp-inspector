#!/usr/bin/env node
import { Command } from 'commander';
import chalk from 'chalk';
import ora from 'ora';
import open from 'open';
import { startDashboard } from './dashboard-server.js';
import { startMCPServer } from './mcp-server.js';
import { setupProxy } from './proxy-server.js';
import * as fs from 'fs/promises';
import * as path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const program = new Command();

const packageJson = JSON.parse(await fs.readFile(new URL('../package.json', import.meta.url), 'utf-8'));

program
  .name('mcp-inspector')
  .description('📊 Real-time monitoring for MCP (Model Context Protocol) servers')
  .version(packageJson.version);

program
  .command('start')
  .description('Start the MCP monitoring dashboard')
  .option('-p, --port <port>', 'Dashboard port', '3456')
  .option('-m, --mcp-port <port>', 'MCP server port', '3457')
  .option('--no-open', 'Don\'t open browser automatically')
  .option('--proxy', 'Start in proxy mode to monitor existing MCP servers')
  .action(async (options) => {
    console.log(chalk.cyan.bold('\n🚀 Starting MCP Inspector...\n'));
    
    const spinner = ora('Initializing services...').start();
    
    try {
      // Ensure data directory exists
      const dataDir = path.join(process.cwd(), '.mcp-inspector');
      await fs.mkdir(dataDir, { recursive: true });
      
      // Start dashboard
      spinner.text = 'Starting dashboard server...';
      const dashboardUrl = await startDashboard(options.port);
      
      if (options.proxy) {
        spinner.text = 'Starting MCP proxy server...';
        await setupProxy(options.mcpPort);
        
        spinner.succeed(chalk.green('✓ MCP Inspector started in proxy mode'));
        console.log(chalk.gray('  Configure your MCP client to connect through:'));
        console.log(chalk.white(`  localhost:${options.mcpPort}\n`));
      } else {
        spinner.text = 'Starting MCP monitoring server...';
        await startMCPServer(options.mcpPort);
        
        spinner.succeed(chalk.green('✓ MCP Inspector started'));
      }
      
      console.log(chalk.cyan('📊 Dashboard:'), chalk.white.underline(dashboardUrl));
      console.log(chalk.gray('\n  Press Ctrl+C to stop\n'));
      
      if (options.open) {
        await open(dashboardUrl);
      }
    } catch (error) {
      spinner.fail(chalk.red('Failed to start MCP Inspector'));
      console.error(error);
      process.exit(1);
    }
  });

program
  .command('generate-config')
  .description('Generate Claude Desktop configuration')
  .option('-n, --name <name>', 'Server name', 'mcp-inspector')
  .action(async (options) => {
    const config = {
      mcpServers: {
        [options.name]: {
          command: 'npx',
          args: ['mcp-inspector', 'server'],
          env: {}
        }
      }
    };
    
    console.log(chalk.cyan('\n📝 Add this to your Claude Desktop config:\n'));
    console.log(chalk.gray('  ~/Library/Application Support/Claude/claude_desktop_config.json\n'));
    console.log(JSON.stringify(config, null, 2));
    console.log(chalk.yellow('\n⚠️  Remember to restart Claude Desktop after updating the config'));
  });

program
  .command('server')
  .description('Run as MCP server (for Claude integration)')
  .action(async () => {
    // This mode runs the MCP server directly for Claude to connect to
    await startMCPServer(null, true);
  });

program
  .command('analyze')
  .description('Analyze MCP metrics')
  .option('-f, --file <path>', 'Metrics file path', '.mcp-inspector/metrics.json')
  .action(async (options) => {
    try {
      const data = await fs.readFile(options.file, 'utf-8');
      const metrics = JSON.parse(data);
      
      console.log(chalk.cyan.bold('\n📈 MCP Metrics Analysis\n'));
      
      const toolUsage = {};
      let totalRequests = 0;
      let totalTime = 0;
      
      for (const req of metrics.requests) {
        totalRequests++;
        totalTime += req.responseTime || 0;
        toolUsage[req.tool] = (toolUsage[req.tool] || 0) + 1;
      }
      
      console.log(chalk.white('Total Requests:'), totalRequests);
      console.log(chalk.white('Average Response Time:'), `${Math.round(totalTime / totalRequests)}ms`);
      console.log(chalk.white('\nTool Usage:'));
      
      for (const [tool, count] of Object.entries(toolUsage)) {
        const percentage = ((count as number) / totalRequests * 100).toFixed(1);
        console.log(`  ${chalk.cyan(tool)}: ${count} (${percentage}%)`);
      }
    } catch (error) {
      console.error(chalk.red('Error analyzing metrics:'), error);
    }
  });

program.parse();
