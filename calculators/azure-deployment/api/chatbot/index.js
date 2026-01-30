const { app } = require('@azure/functions');
const fetch = require('node-fetch');

// Azure Function to proxy Anthropic API calls securely
// API key is stored in Azure Configuration (never exposed to browser)
app.http('chatbot', {
    methods: ['POST', 'OPTIONS'],
    authLevel: 'anonymous', // Change to 'function' for API key auth
    handler: async (request, context) => {
        context.log('Chatbot API request received');

        // Handle CORS preflight
        if (request.method === 'OPTIONS') {
            return {
                status: 200,
                headers: {
                    'Access-Control-Allow-Origin': '*', // Update to your domain in production
                    'Access-Control-Allow-Methods': 'POST, OPTIONS',
                    'Access-Control-Allow-Headers': 'Content-Type'
                }
            };
        }

        try {
            // Get API key from Azure Configuration (set in Portal or CLI)
            const apiKey = process.env.ANTHROPIC_API_KEY;
            
            if (!apiKey) {
                context.error('ANTHROPIC_API_KEY not configured');
                return {
                    status: 500,
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ 
                        error: 'Server configuration error. API key not set.' 
                    })
                };
            }

            // Parse request body
            const body = await request.json();
            
            // Optional: Add rate limiting, user authentication, etc.
            // const userId = request.headers.get('x-user-id');
            // if (!await checkRateLimit(userId)) {
            //     return { status: 429, body: 'Too many requests' };
            // }

            // Forward request to Anthropic API
            context.log('Forwarding to Anthropic API...');
            const response = await fetch('https://api.anthropic.com/v1/messages', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'x-api-key': apiKey,
                    'anthropic-version': '2023-06-01'
                },
                body: JSON.stringify(body)
            });

            const data = await response.json();

            if (!response.ok) {
                context.error('Anthropic API error:', data);
                return {
                    status: response.status,
                    headers: {
                        'Content-Type': 'application/json',
                        'Access-Control-Allow-Origin': '*'
                    },
                    body: JSON.stringify(data)
                };
            }

            context.log('Successfully received response from Anthropic');

            // Return response to client
            return {
                status: 200,
                headers: {
                    'Content-Type': 'application/json',
                    'Access-Control-Allow-Origin': '*' // Update to your domain
                },
                body: JSON.stringify(data)
            };

        } catch (error) {
            context.error('Error processing request:', error);
            return {
                status: 500,
                headers: {
                    'Content-Type': 'application/json',
                    'Access-Control-Allow-Origin': '*'
                },
                body: JSON.stringify({ 
                    error: 'Internal server error',
                    message: error.message 
                })
            };
        }
    }
});
