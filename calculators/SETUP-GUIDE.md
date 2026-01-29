# Value Analysis Chatbot - Quick Setup Guide

## ✅ Your chatbot is now enhanced with AI Delivery Methodology knowledge!

Claude AI will now provide recommendations aligned with the Microsoft AI Frontier "Vision to Value" methodology, including:
- All 9 delivery phases
- Best practices for value analysis
- Risk mitigation strategies
- Implementation sequencing
- Resource allocation guidance

---

## 🔧 Setup Your API Key (Choose One Method)

### Method 1: Local Config File (Recommended - Already Set Up!)

Your API key is already in the local config file! Just verify:

1. File location: `calculators/js/config.local.js`
2. Contains your Anthropic API key: ✅ (Already added)
3. This file is gitignored: ✅ (Won't be committed)

**You're ready to test!**

### Method 2: UI Input (For Other Users)

Users without a local config can add their key via the chatbot UI:
1. Click the 🤖 icon in the header
2. Select "Anthropic Claude"
3. Enter API key
4. Key stored in browser localStorage

---

## 🧪 Testing the Chatbot

### Open the chatbot:
- **Local:** http://localhost:8001/value-analysis-chatbot.html
- **GitHub Pages:** https://andreaswasita.github.io/AI-Delivery-Methodology/calculators/value-analysis-chatbot.html (wait 2-3 min for deployment)

### Check the Console (F12):
Look for these messages:
```
✅ All DOM elements found
✅ Event listeners attached
📊 Current state: {hasAnthropicKey: true, ...}
✅ Chatbot initialized successfully
🔍 Post-check: Local config: Loaded ✅
```

### Test the Send Button:
1. Type "hello" in the input field
2. Click Send or press Enter
3. Console should show:
   ```
   📨 handleSend called, message: hello
   🎯 processInput - Stage: project_name, Input: hello
   ```

### Test Quick Replies:
Quick reply buttons should appear after the welcome message. Click any button and watch the console for:
```
🖱️ Quick reply clicked: [button label]
```

---

## 🤖 What Claude AI Now Knows

When you complete a value analysis, Claude AI receives context about:

### Methodology Phases:
1. Business Envisioning
2. Mobilization
3. Hackathons & Prototyping
4. Setup Platform
5. Build Phase
6. Integrate
7. Test & Evaluate
8. Prepare & Deploy
9. Operate & Care

### Best Practices:
- Value score prioritization (Benefit/Effort ratio)
- 3-6 month MVP cycles
- 20-30% effort for MLOps/governance
- Story point estimation (1 point = 1 person-day)
- Azure cost considerations

### Risk Mitigation:
- Data quality (40% effort to data prep)
- Skills gap management
- Change management strategies
- Technical debt prevention
- Compliance embedding

Claude will recommend:
- Strategic assessment aligned to methodology
- Phase-specific implementation guidance
- Resource allocation based on proven patterns
- Use case sequencing with dependencies
- Timeline estimates by complexity

---

## 🐛 Troubleshooting

### Send button not working?

**Check Console:**
1. Press F12
2. Look for errors (red text)
3. Check for initialization messages

**Common fixes:**
- Hard refresh: Ctrl+Shift+R (Windows) or Cmd+Shift+R (Mac)
- Clear browser cache
- Check config.local.js has valid API key
- Verify file is loaded: Look for "Local config: Loaded ✅" in console

### API Key not detected?

**Verify setup:**
```javascript
// Paste in browser console:
console.log('Config:', window.CHATBOT_CONFIG);
console.log('Has key:', !!window.chatbot?.state.anthropicApiKey);
```

Should show:
```
Config: {ANTHROPIC_API_KEY: "sk-ant-...", ...}
Has key: true
```

### Still having issues?

See [CHATBOT-TROUBLESHOOTING.md](CHATBOT-TROUBLESHOOTING.md) for comprehensive debugging guide.

---

## 📝 Usage Example

### Complete Conversation Flow:

1. **Welcome** → Bot introduces itself
2. **Project Name** → You: "Customer Service AI"
3. **Use Case Title** → You: "Support Ticket Automation"
4. **Problem Statement** → You: "Manual ticket routing taking 2 hours per ticket"
5. **Impact Level** → Click: "HIGH"
6. **Effort** → You: "80" (story points)
7. **Benefits** → Click: "Cost Reduction"
8. **Benefit Amount** → You enter 5-year projections
9. **More Use Cases?** → Add more or continue
10. **Generate Analysis** → Bot calculates ROI, NPV, payback
11. **AI Insights** → Claude provides methodology-aligned recommendations!

---

## 🚀 Next Steps

Your chatbot is now:
- ✅ Enhanced with AI Delivery Methodology knowledge
- ✅ Secured with gitignored config file
- ✅ API key loaded and ready
- ✅ Initialization improved with fallback logic
- ✅ Debugging enabled for troubleshooting

**Just open the chatbot and start chatting!**

Need help? Check the troubleshooting guide or open an issue on GitHub.
