# Local CORS Proxy Server

## Quick Start

### 1. Set Your API Key
```powershell
$env:ANTHROPIC_API_KEY = "sk-ant-your-actual-api-key-here"
```

### 2. Start the Proxy
```powershell
cd c:\AI-Delivery-Methodology\calculators
node proxy-server.js
```

You should see:
```
🚀 CORS Proxy running at http://localhost:3000
📡 Forwarding requests to Anthropic API
🔑 Using API key: sk-ant-...
✅ Update your chatbot to use: http://localhost:3000/api/messages
```

### 3. Update the Chatbot

Modify the chatbot to use your local proxy instead of Anthropic's API directly.

**Open:** `calculators/js/value-analysis-chatbot.js`

**Find line ~1333** (the `callAnthropicAPI` function) and change:
```javascript
// BEFORE:
const response = await fetch('https://api.anthropic.com/v1/messages', {

// AFTER:
const response = await fetch('http://localhost:3000/api/messages', {
```

**Remove the API key header** (line ~1336) since the proxy handles it:
```javascript
// REMOVE THIS LINE:
'x-api-key': this.state.anthropicApiKey,
```

### 4. Test the Chatbot

1. Open the chatbot in your browser: `http://localhost:8000/calculators/value-analysis-chatbot.html`
2. Type a message - it should now work via the local proxy!

---

## Why This Works

```
┌─────────┐         ┌──────────┐         ┌─────────────┐
│ Browser │ ──────> │ Proxy    │ ──────> │ Anthropic   │
│         │   ✅    │ :3000    │   ✅    │ API         │
└─────────┘ No CORS └──────────┘ Has Key └─────────────┘
```

- **Browser → Proxy**: No CORS issues (same machine)
- **Proxy → Anthropic**: Server-to-server (no CORS restrictions)
- **API Key**: Stored securely on your machine, not in browser code

---

## Security Notes

⚠️ **This is for LOCAL TESTING ONLY**

- ✅ Fine for development on your own machine
- ❌ **DO NOT deploy this proxy publicly** without authentication
- ❌ **DO NOT commit your API key** to git

---

## Alternative: Python Proxy (If you prefer Python)

```python
# proxy-server.py
from flask import Flask, request, Response
import requests
import os

app = Flask(__name__)
ANTHROPIC_API_KEY = os.getenv('ANTHROPIC_API_KEY', 'your-key-here')

@app.route('/api/messages', methods=['POST', 'OPTIONS'])
def proxy():
    if request.method == 'OPTIONS':
        response = Response()
        response.headers['Access-Control-Allow-Origin'] = '*'
        response.headers['Access-Control-Allow-Methods'] = 'POST, OPTIONS'
        response.headers['Access-Control-Allow-Headers'] = 'Content-Type'
        return response
    
    # Forward to Anthropic
    anthropic_response = requests.post(
        'https://api.anthropic.com/v1/messages',
        json=request.json,
        headers={
            'Content-Type': 'application/json',
            'x-api-key': ANTHROPIC_API_KEY,
            'anthropic-version': '2023-06-01'
        }
    )
    
    response = Response(anthropic_response.content)
    response.headers['Content-Type'] = 'application/json'
    response.headers['Access-Control-Allow-Origin'] = '*'
    return response

if __name__ == '__main__':
    print('🚀 CORS Proxy running at http://localhost:3000')
    app.run(port=3000)
```

**Run it:**
```powershell
pip install flask requests
$env:ANTHROPIC_API_KEY = "sk-ant-your-key"
python proxy-server.py
```

---

## Troubleshooting

**"node: command not found"**
- Install Node.js from https://nodejs.org/

**Proxy won't start**
- Check if port 3000 is already in use
- Try a different port (change PORT in proxy-server.js)

**Still getting CORS errors**
- Make sure you updated the chatbot to use `http://localhost:3000`
- Check browser console for the exact error
- Ensure the proxy is running when you test

**API errors from Anthropic**
- Verify your API key is correct
- Check you have API credits at https://console.anthropic.com/

---

## Production Alternative

For production use, consider:
- **Azure Functions** with CORS enabled
- **Azure API Management** as a gateway
- **Microsoft Copilot Studio** (no CORS issues)

See `CHATBOT-TROUBLESHOOTING.md` for production setup guides.
