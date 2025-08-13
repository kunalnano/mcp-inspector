import * as net from 'net';
import * as fs from 'fs/promises';
import * as path from 'path';

interface ProxyConfig {
  targetHost: string;
  targetPort: number;
}

export async function setupProxy(port: number | string = 3457, config?: ProxyConfig) {
  const PORT = Number(port);
  const metricsPath = path.join(process.cwd(), '.mcp-inspector/metrics.json');
  
  // Create a proxy server that sits between Claude and the actual MCP server
  const server = net.createServer((clientSocket) => {
    const target = config || { targetHost: 'localhost', targetPort: 3458 };
    const serverSocket = net.connect(target.targetPort, target.targetHost);
    
    let requestBuffer = '';
    let responseBuffer = '';
    
    clientSocket.on('data', async (data) => {
      requestBuffer += data.toString();
      
      // Try to parse JSON-RPC messages
      try {
        const lines = requestBuffer.split('\n');
        for (const line of lines) {
          if (line.trim() && line.includes('{')) {
            try {
              const message = JSON.parse(line);
              if (message.method === 'tools/call') {
                // Log the tool call
                await logToolCall(message);
              }
            } catch {
              // Not a complete JSON message yet
            }
          }
        }
      } catch {
        // Continue buffering
      }
      
      serverSocket.write(data);
    });
    
    serverSocket.on('data', (data) => {
      responseBuffer += data.toString();
      clientSocket.write(data);
    });
    
    clientSocket.on('end', () => serverSocket.end());
    serverSocket.on('end', () => clientSocket.end());
    clientSocket.on('error', () => serverSocket.destroy());
    serverSocket.on('error', () => clientSocket.destroy());
  });
  
  async function logToolCall(message: any) {
    try {
      const metrics = await loadMetrics();
      
      const logEntry = {
        id: Date.now().toString(),
        tool: message.params?.name || 'unknown',
        arguments: message.params?.arguments || {},
        timestamp: new Date().toISOString(),
        responseTime: 0, // Will be updated when response is received
        success: true
      };
      
      metrics.requests.push(logEntry);
      await saveMetrics(metrics);
    } catch (error) {
      console.error('[PROXY] Error logging tool call:', error);
    }
  }
  
  async function loadMetrics() {
    try {
      const data = await fs.readFile(metricsPath, 'utf-8');
      return JSON.parse(data);
    } catch {
      return { requests: [] };
    }
  }
  
  async function saveMetrics(metrics: any) {
    await fs.mkdir(path.dirname(metricsPath), { recursive: true });
    await fs.writeFile(metricsPath, JSON.stringify(metrics, null, 2));
  }
  
  server.listen(PORT, () => {
    console.error(`[PROXY] MCP proxy listening on port ${PORT}`);
  });
}
