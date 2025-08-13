import express from 'express';
import * as fs from 'fs/promises';
import * as path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

export async function startDashboard(port: string | number = 3456): Promise<string> {
  const app = express();
  const PORT = Number(port);
  
  // Serve static files
  app.use(express.static(path.join(__dirname, '../public')));
  
  // API endpoint for metrics
  app.get('/api/metrics', async (req, res) => {
    try {
      const metricsPath = path.join(process.cwd(), '.mcp-inspector/metrics.json');
      const data = await fs.readFile(metricsPath, 'utf-8');
      res.json(JSON.parse(data));
    } catch (error) {
      res.json({ requests: [] });
    }
  });
  
  // WebSocket endpoint for real-time updates
  app.get('/api/stream', (req, res) => {
    res.writeHead(200, {
      'Content-Type': 'text/event-stream',
      'Cache-Control': 'no-cache',
      'Connection': 'keep-alive'
    });
    
    // Send updates every second
    const interval = setInterval(async () => {
      try {
        const metricsPath = path.join(process.cwd(), '.mcp-inspector/metrics.json');
        const data = await fs.readFile(metricsPath, 'utf-8');
        res.write(`data: ${data}\n\n`);
      } catch (error) {
        // No metrics yet
      }
    }, 1000);
    
    req.on('close', () => {
      clearInterval(interval);
    });
  });
  
  return new Promise((resolve) => {
    app.listen(PORT, () => {
      resolve(`http://localhost:${PORT}`);
    });
  });
}
