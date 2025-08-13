import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
} from '@modelcontextprotocol/sdk/types.js';
import * as fs from 'fs/promises';
import * as path from 'path';

interface MetricsEntry {
  id: string;
  tool: string;
  arguments: any;
  timestamp: string;
  responseTime: number;
  success: boolean;
  error?: string;
}

interface Metrics {
  requests: MetricsEntry[];
  summary?: {
    totalRequests: number;
    averageResponseTime: number;
    successRate: number;
  };
}

export async function startMCPServer(port?: number | null, stdio: boolean = false) {
  const metricsPath = path.join(process.cwd(), '.mcp-inspector/metrics.json');
  
  async function loadMetrics(): Promise<Metrics> {
    try {
      const data = await fs.readFile(metricsPath, 'utf-8');
      return JSON.parse(data);
    } catch {
      return { requests: [] };
    }
  }
  
  async function saveMetrics(metrics: Metrics) {
    // Update summary
    const totalRequests = metrics.requests.length;
    const successfulRequests = metrics.requests.filter(r => r.success).length;
    const totalTime = metrics.requests.reduce((sum, r) => sum + r.responseTime, 0);
    
    metrics.summary = {
      totalRequests,
      averageResponseTime: totalRequests > 0 ? Math.round(totalTime / totalRequests) : 0,
      successRate: totalRequests > 0 ? (successfulRequests / totalRequests) * 100 : 100
    };
    
    await fs.mkdir(path.dirname(metricsPath), { recursive: true });
    await fs.writeFile(metricsPath, JSON.stringify(metrics, null, 2));
  }
  
  const server = new Server({
    name: 'mcp-inspector',
    version: '1.0.0'
  }, {
    capabilities: {
      tools: {}
    }
  });
  
  // Intercept all tool listings
  const originalListHandler = server.setRequestHandler(ListToolsRequestSchema, async () => ({
    tools: [
      {
        name: 'inspector_test',
        description: 'Test tool for MCP Inspector',
        inputSchema: {
          type: 'object',
          properties: {
            message: { type: 'string' }
          }
        }
      }
    ]
  }));
  
  // Intercept all tool calls
  server.setRequestHandler(CallToolRequestSchema, async (request) => {
    const startTime = Date.now();
    const metrics = await loadMetrics();
    
    try {
      // Simulate some processing
      await new Promise(resolve => setTimeout(resolve, Math.random() * 100));
      
      const responseTime = Date.now() - startTime;
      
      const logEntry: MetricsEntry = {
        id: Date.now().toString(),
        tool: request.params.name,
        arguments: request.params.arguments,
        timestamp: new Date().toISOString(),
        responseTime,
        success: true
      };
      
      metrics.requests.push(logEntry);
      
      // Keep only last 1000 entries
      if (metrics.requests.length > 1000) {
        metrics.requests = metrics.requests.slice(-1000);
      }
      
      await saveMetrics(metrics);
      
      console.error(`[MCP-INSPECTOR] ${request.params.name} - ${responseTime}ms`);
      
      return {
        content: [{
          type: 'text',
          text: `Tool "${request.params.name}" executed successfully (${responseTime}ms)`
        }]
      };
    } catch (error) {
      const logEntry: MetricsEntry = {
        id: Date.now().toString(),
        tool: request.params.name,
        arguments: request.params.arguments,
        timestamp: new Date().toISOString(),
        responseTime: Date.now() - startTime,
        success: false,
        error: String(error)
      };
      
      metrics.requests.push(logEntry);
      await saveMetrics(metrics);
      
      throw error;
    }
  });
  
  if (stdio) {
    const transport = new StdioServerTransport();
    await server.connect(transport);
    console.error('[MCP-INSPECTOR] Server running in stdio mode');
  } else {
    // TCP mode for development/testing
    console.error('[MCP-INSPECTOR] Server initialized');
  }
}
