#!/usr/bin/env python3
"""
Simple CORS Proxy for Anthropic API
Allows browser-based chatbot to call Anthropic API without CORS issues
Usage: python proxy_server.py
"""

from http.server import HTTPServer, BaseHTTPRequestHandler
import json
import os
import sys

try:
    import requests
except ImportError:
    print("❌ Error: 'requests' module not found")
    print("📦 Installing requests...")
    import subprocess
    subprocess.check_call([sys.executable, "-m", "pip", "install", "requests"])
    import requests

# Get API key from environment variable
ANTHROPIC_API_KEY = os.getenv('ANTHROPIC_API_KEY', '')
PORT = 3000

class ProxyHandler(BaseHTTPRequestHandler):
    def log_message(self, format, *args):
        """Custom logging format"""
        print(f"📡 {self.command} {self.path} - {args[1]}")

    def _send_cors_headers(self):
        """Add CORS headers to response"""
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
    
    def do_OPTIONS(self):
        """Handle preflight CORS requests"""
        self.send_response(200)
        self._send_cors_headers()
        self.end_headers()
    
    def do_POST(self):
        """Forward POST requests to Anthropic API"""
        if self.path != '/api/messages':
            self.send_error(404, 'Not Found')
            return
        
        if not ANTHROPIC_API_KEY:
            self.send_response(500)
            self._send_cors_headers()
            self.send_header('Content-Type', 'application/json')
            self.end_headers()
            error_response = {
                'error': 'ANTHROPIC_API_KEY environment variable not set'
            }
            self.wfile.write(json.dumps(error_response).encode())
            return
        
        try:
            # Read request body
            content_length = int(self.headers.get('Content-Length', 0))
            body = self.rfile.read(content_length)
            
            # Forward to Anthropic API
            print(f"🚀 Forwarding request to Anthropic API...")
            response = requests.post(
                'https://api.anthropic.com/v1/messages',
                data=body,
                headers={
                    'Content-Type': 'application/json',
                    'x-api-key': ANTHROPIC_API_KEY,
                    'anthropic-version': '2023-06-01'
                },
                timeout=60
            )
            
            # Send response back to browser
            self.send_response(response.status_code)
            self._send_cors_headers()
            self.send_header('Content-Type', 'application/json')
            self.end_headers()
            self.wfile.write(response.content)
            
            print(f"✅ Response sent: {response.status_code}")
            
        except requests.exceptions.Timeout:
            self.send_response(504)
            self._send_cors_headers()
            self.send_header('Content-Type', 'application/json')
            self.end_headers()
            error_response = {'error': 'Request timeout'}
            self.wfile.write(json.dumps(error_response).encode())
            print("⏱️ Request timeout")
            
        except Exception as e:
            self.send_response(500)
            self._send_cors_headers()
            self.send_header('Content-Type', 'application/json')
            self.end_headers()
            error_response = {'error': str(e)}
            self.wfile.write(json.dumps(error_response).encode())
            print(f"❌ Error: {e}")

def main():
    print("\n" + "="*60)
    print("🤖 ANTHROPIC API CORS PROXY SERVER")
    print("="*60)
    
    if not ANTHROPIC_API_KEY:
        print("\n⚠️  WARNING: ANTHROPIC_API_KEY not set!")
        print("\n📝 To set it, run:")
        print('   $env:ANTHROPIC_API_KEY = "sk-ant-your-key-here"')
        print("\n❌ Proxy will not work without an API key.")
        print("\n💡 Press Ctrl+C to stop and set the API key first.")
        print("\n" + "="*60 + "\n")
    else:
        key_preview = ANTHROPIC_API_KEY[:10] + "..." + ANTHROPIC_API_KEY[-4:]
        print(f"\n✅ API Key configured: {key_preview}")
        print("="*60 + "\n")
    
    try:
        server = HTTPServer(('localhost', PORT), ProxyHandler)
        print(f"🚀 Proxy server running at: http://localhost:{PORT}")
        print(f"📡 Endpoint: http://localhost:{PORT}/api/messages")
        print("\n💡 Update your chatbot to use this URL instead of Anthropic's direct URL")
        print("\n📋 Next steps:")
        print("   1. Update value-analysis-chatbot.js line ~1333:")
        print(f"      Change URL to: http://localhost:{PORT}/api/messages")
        print("   2. Open chatbot in browser and test!")
        print("\n⌨️  Press Ctrl+C to stop the server\n")
        print("="*60 + "\n")
        
        server.serve_forever()
        
    except KeyboardInterrupt:
        print("\n\n👋 Shutting down proxy server...")
        server.shutdown()
        print("✅ Server stopped")
    except OSError as e:
        if "address already in use" in str(e).lower():
            print(f"\n❌ Error: Port {PORT} is already in use")
            print("💡 Either:")
            print(f"   - Stop the other process using port {PORT}")
            print("   - Change PORT variable in this script")
        else:
            print(f"\n❌ Error starting server: {e}")

if __name__ == '__main__':
    main()
