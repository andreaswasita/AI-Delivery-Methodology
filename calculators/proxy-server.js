// Simple CORS Proxy for Anthropic API
// Run this locally to bypass browser CORS restrictions
// Usage: node proxy-server.js

const http = require('http');
const https = require('https');

const PORT = 3000;
const ANTHROPIC_API_KEY = process.env.ANTHROPIC_API_KEY || 'your-key-here';

const server = http.createServer((req, res) => {
    // Enable CORS for browser requests
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

    // Handle preflight requests
    if (req.method === 'OPTIONS') {
        res.writeHead(200);
        res.end();
        return;
    }

    if (req.method === 'POST' && req.url === '/api/messages') {
        let body = '';
        
        req.on('data', chunk => {
            body += chunk.toString();
        });

        req.on('end', () => {
            // Forward to Anthropic API
            const options = {
                hostname: 'api.anthropic.com',
                path: '/v1/messages',
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'x-api-key': ANTHROPIC_API_KEY,
                    'anthropic-version': '2023-06-01',
                    'Content-Length': Buffer.byteLength(body)
                }
            };

            const anthropicReq = https.request(options, (anthropicRes) => {
                let responseData = '';
                
                anthropicRes.on('data', chunk => {
                    responseData += chunk;
                });

                anthropicRes.on('end', () => {
                    res.writeHead(anthropicRes.statusCode, {
                        'Content-Type': 'application/json',
                        'Access-Control-Allow-Origin': '*'
                    });
                    res.end(responseData);
                });
            });

            anthropicReq.on('error', (error) => {
                console.error('Error:', error);
                res.writeHead(500);
                res.end(JSON.stringify({ error: error.message }));
            });

            anthropicReq.write(body);
            anthropicReq.end();
        });
    } else {
        res.writeHead(404);
        res.end('Not Found');
    }
});

server.listen(PORT, () => {
    console.log(`🚀 CORS Proxy running at http://localhost:${PORT}`);
    console.log(`📡 Forwarding requests to Anthropic API`);
    console.log(`🔑 Using API key: ${ANTHROPIC_API_KEY.substring(0, 10)}...`);
    console.log(`\n✅ Update your chatbot to use: http://localhost:${PORT}/api/messages`);
});
