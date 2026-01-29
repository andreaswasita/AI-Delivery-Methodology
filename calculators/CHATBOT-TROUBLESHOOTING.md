# Value Analysis Chatbot - Troubleshooting Guide

## Issue: Buttons Not Working (Send, Quick Replies, API Key Button)

### Quick Fixes

#### Option 1: Use Hardcoded API Key (Recommended for Testing)

1. **Open the JavaScript file:**
   - Navigate to `calculators/js/value-analysis-chatbot.js`

2. **Find lines 4-5 and add your API key:**
   ```javascript
   const HARDCODED_ANTHROPIC_KEY = 'sk-ant-your-key-here'; // Add your Anthropic API key
   const HARDCODED_COPILOT_ENDPOINT = ''; // Or add your Copilot endpoint
   ```

3. **Save the file and reload the page**
   - The chatbot will automatically detect and use your hardcoded key
   - You can remove the key later before committing to git

4. **Important:** Never commit your API key to git! Add it only for local testing.

---

### Debugging Steps

#### Step 1: Open Browser Console

1. Open the chatbot page in your browser
2. Press `F12` or right-click and select "Inspect"
3. Click on the "Console" tab
4. Look for error messages (red text)

**Expected Console Output (if working correctly):**
```
🤖 Initializing Value Analysis Chatbot...
✅ All DOM elements found
✅ Event listeners attached
📊 Current state: {hasAnthropicKey: false, hasCopilotEndpoint: false, aiProvider: ""}
🚀 Starting conversation...
💬 Showing quick replies: 0 buttons
```

#### Step 2: Use the Test Page

1. **Open the test page:**
   - Navigate to: `http://localhost:8000/test-chatbot.html` (if running locally)
   - Or: `https://andreaswasita.github.io/AI-Delivery-Methodology/calculators/test-chatbot.html`

2. **Click test buttons to diagnose:**
   - "Check LocalStorage" - See if keys are stored
   - "Test Buttons" - Verify button elements exist
   - "Set Test API Key" - Quickly set an API key

3. **Review console output** in the test panel

---

### Common Issues and Solutions

#### Issue 1: "Send" button doesn't work

**Symptoms:**
- Clicking send button does nothing
- No console messages appear

**Solution:**
1. Open console and check for JavaScript errors
2. Verify the button exists: Look for `sendBtn` in console logs
3. Try clicking "Test Buttons" in test-chatbot.html

**Debug command in console:**
```javascript
// Paste this in browser console
console.log('Send button:', document.getElementById('sendBtn'));
console.log('Chatbot instance:', window.chatbot);
```

#### Issue 2: Quick Reply buttons don't appear

**Symptoms:**
- The chatbot shows messages but no button options
- Console shows "💬 Showing quick replies: 0 buttons"

**Possible causes:**
1. CSS file not loaded correctly
2. JavaScript execution error before showQuickReplies

**Solution:**
1. Check Network tab in DevTools for 404 errors on CSS files
2. Look for JavaScript errors in Console tab
3. Verify `quickReplies` element exists in DOM

#### Issue 3: API Key button does nothing

**Symptoms:**
- Clicking the 🤖 button shows no response
- No modal or message appears

**Solution:**
1. Check console for "🔑 API Key button clicked" message
2. If message appears but nothing happens, check `manageApiKey()` function
3. Try using hardcoded key instead (see Option 1 above)

**Debug in console:**
```javascript
// Check if API key button is registered
console.log('API Key Button:', document.getElementById('apiKeyBtn'));
// Manually trigger the function
if (window.chatbot) window.chatbot.manageApiKey();
```

#### Issue 4: Input field not accepting text

**Symptoms:**
- Can't type in the text input
- Input appears disabled

**Solution:**
1. Click directly in the input field
2. Check if JavaScript errors are blocking the page
3. Reload the page

---

### How to Set Up AI Provider

#### Option A: Using Anthropic Claude (Recommended)

1. **Get API Key:**
   - Visit: https://console.anthropic.com/
   - Sign up for an account
   - Navigate to "API Keys" section
   - Create a new API key

2. **Add to Chatbot:**
   - **Method 1 (Hardcode):** Edit `js/value-analysis-chatbot.js` line 4
   - **Method 2 (UI):** Click the 🤖 icon and select "Anthropic Claude"

#### Option B: Using Microsoft Copilot Studio

1. **Get Endpoint:**
   - Access your Copilot Studio workspace
   - Go to Settings > Channels
   - Copy the Direct Line endpoint URL

2. **Add to Chatbot:**
   - Click the 🤖 icon
   - Select "Microsoft Copilot Studio"
   - Paste your endpoint

---

### Testing Checklist

Run through this checklist to verify everything works:

- [ ] Page loads without errors (check console)
- [ ] Welcome message appears from bot
- [ ] Can type in the input field
- [ ] "Send" button responds when clicked
- [ ] Quick reply buttons appear for options
- [ ] Quick reply buttons work when clicked
- [ ] 🤖 API key button opens settings menu
- [ ] 🔄 Reset button prompts confirmation
- [ ] Bot responds to inputs correctly

---

### File Structure

Ensure these files exist and are accessible:

```
calculators/
├── value-analysis-chatbot.html   # Main chatbot page
├── test-chatbot.html              # Debugging test page
├── js/
│   └── value-analysis-chatbot.js  # Main JavaScript (EDIT THIS for hardcoded key)
├── css/
│   ├── styles.css                 # General styles
│   └── chatbot-styles.css         # Chatbot-specific styles
```

---

### Advanced Debugging

#### Enable Verbose Logging

The updated chatbot already includes extensive logging. Every action logs to console:
- `🤖` Initialization messages
- `📤` Send button clicks
- `🖱️` Quick reply clicks
- `🎯` Input processing
- `💬` Quick reply rendering

#### Inspect State

Check the chatbot's current state at any time:

```javascript
// Paste in browser console
console.log('Current stage:', window.chatbot.state.stage);
console.log('Project name:', window.chatbot.state.projectName);
console.log('Use cases:', window.chatbot.state.useCases);
console.log('Has API key:', !!window.chatbot.state.anthropicApiKey);
```

#### Manual Testing

Trigger chatbot functions manually:

```javascript
// Send a message programmatically
window.chatbot.processInput('Test Project');

// Show welcome message again
window.chatbot.showWelcome();

// Test API key dialog
window.chatbot.manageApiKey();

// Show quick replies
window.chatbot.showQuickReplies([
  { label: 'Test 1', value: 'test1' },
  { label: 'Test 2', value: 'test2' }
]);
```

---

### Still Having Issues?

1. **Clear browser cache and reload**
   - Press `Ctrl+Shift+R` (Windows/Linux) or `Cmd+Shift+R` (Mac)

2. **Try a different browser**
   - Chrome, Firefox, or Edge recommended

3. **Check GitHub Pages deployment**
   - Wait 2-3 minutes after pushing changes
   - Visit: https://andreaswasita.github.io/AI-Delivery-Methodology/calculators/value-analysis-chatbot.html

4. **Run locally for testing**
   ```bash
   cd calculators
   python -m http.server 8000
   # Visit http://localhost:8000/value-analysis-chatbot.html
   ```

5. **Check for CORS issues** (if using external APIs)
   - Look for CORS errors in console
   - Ensure API keys are valid and have proper permissions

---

### Security Reminders

⚠️ **Important:**
- Never commit API keys to git
- Use environment variables for production
- Remove hardcoded keys before pushing to GitHub
- Use `.gitignore` to exclude sensitive files

---

### Contact & Support

- **GitHub Issues:** https://github.com/andreaswasita/AI-Delivery-Methodology/issues
- **Documentation:** Check README.md in the repository
- **Test Page:** Use test-chatbot.html for live debugging

---

## Summary: Quick Start with Hardcoded Key

**The fastest way to get started:**

1. Open `calculators/js/value-analysis-chatbot.js`
2. On line 4, add: `const HARDCODED_ANTHROPIC_KEY = 'sk-ant-your-actual-key-here';`
3. Save and reload the page
4. The chatbot will work immediately with AI insights

This bypasses all localStorage and UI complexity for quick testing!
