# AI Integration Guide - Value Analysis Chatbot

The Value Analysis Chatbot now supports multiple AI providers to generate strategic insights from your project data.

## Supported AI Providers

### 🔵 Anthropic Claude
**Model:** Claude 3.5 Sonnet (claude-3-5-sonnet-20241022)

**Setup:**
1. Get API key at: https://console.anthropic.com/
2. Click the 🤖 button in the chatbot header
3. Select "Anthropic Claude"
4. Paste your API key (starts with `sk-ant-`)

**Features:**
- Advanced strategic analysis
- Risk identification and mitigation
- Implementation sequencing
- Executive-ready insights
- 2000 token responses

**Pricing:** Pay-as-you-go based on API usage
- Input: ~$3 per million tokens
- Output: ~$15 per million tokens
- Typical analysis: $0.01-0.05

---

### 🟢 Microsoft Copilot Studio
**Platform:** Azure-hosted custom copilot

**Setup:**
1. Create a bot in Copilot Studio: https://copilotstudio.microsoft.com/
2. Deploy bot and get the endpoint URL
3. Click the 🤖 button in the chatbot header
4. Select "Microsoft Copilot Studio"
5. Paste your bot endpoint URL

**Features:**
- Enterprise security and compliance
- Custom knowledge bases
- Azure AD integration
- Governance controls
- Conversation analytics

**Pricing:** Based on Copilot Studio licensing
- Included with Microsoft 365 Copilot
- Or standalone licensing available

---

## How It Works

1. **Data Collection**: The chatbot guides you through structured data collection:
   - Project name
   - Use cases with impact, effort, and benefits
   - Cost projections
   
2. **Financial Analysis**: Calculates ROI, NPV, payback period using built-in algorithms

3. **AI Insights (Optional)**: After analysis, you can request AI-powered insights:
   - Strategic assessment of portfolio viability
   - Key strengths and risks
   - Actionable recommendations
   - Implementation sequence suggestions

4. **Export Options**: 
   - View detailed report
   - Export to JSON
   - Share with stakeholders

## Privacy & Security

### Local Storage
- All credentials stored in browser's localStorage
- Never sent to any server except the chosen AI provider
- Clear browser data to remove credentials

### API Keys
- **Anthropic**: Keys sent directly to Anthropic's API
- **Copilot Studio**: Requests sent to your Azure endpoint
- No intermediary servers or logging
- You control your data

### Data Handling
- Your project data is sent to AI provider only when you request insights
- No background data transmission
- Analysis data stays in your browser
- Export JSON for your own storage

## Usage Tips

### For Best Results

**Anthropic Claude:**
- Best for detailed strategic analysis
- Excellent at identifying risks
- Strong recommendations
- Good for external presentations

**Microsoft Copilot Studio:**
- Best for enterprise compliance
- Leverage custom knowledge bases
- Integration with Microsoft ecosystem
- Audit trail for governance

### Prompt Engineering

The chatbot automatically creates comprehensive prompts including:
- Financial summary (benefits, costs, ROI, NPV)
- Use case details (problem, impact, effort)
- Prioritization scores
- Specific analysis requests

You don't need to craft prompts - just provide accurate data!

## Switching Providers

You can configure multiple providers and switch between them:

1. Click 🤖 button
2. Select "Change Provider"
3. Choose which provider to use
4. Previous analysis still available

Each provider may give different insights based on their training and capabilities.

## Troubleshooting

### "404 Error" or "API request failed"
- **Anthropic**: Check that your API key is valid and has credits
- **Copilot Studio**: Verify endpoint URL is correct and bot is deployed

### "Invalid API key format"
- Anthropic keys must start with `sk-ant-`
- Copy entire key without extra spaces

### "Invalid endpoint URL"
- Must start with `http://` or `https://`
- Get from Copilot Studio deployment settings
- Ensure bot is published and running

### Slow Response
- Claude typically responds in 3-10 seconds
- Copilot Studio depends on your bot's complexity
- Check your internet connection

## API Cost Estimation

### Anthropic Claude

Typical analysis (5 use cases):
- Input tokens: ~1,500 tokens (~$0.005)
- Output tokens: ~1,000 tokens (~$0.015)
- **Total per analysis: ~$0.02**

Monthly usage (20 analyses): ~$0.40

### Microsoft Copilot Studio

Pricing varies by licensing:
- Included with Microsoft 365 Copilot license
- Standalone: Contact Microsoft for pricing
- No per-message costs if included in license

## Best Practices

1. **Start with one provider**: Test with Anthropic for quick setup
2. **Compare insights**: Try both providers on same data to compare
3. **Iterate on data**: More detailed use cases = better insights
4. **Save outputs**: Export JSON after each analysis for records
5. **Share insights**: Copy AI recommendations for stakeholder presentations

## Support

### Anthropic Claude
- Documentation: https://docs.anthropic.com/
- Support: support@anthropic.com

### Microsoft Copilot Studio
- Documentation: https://learn.microsoft.com/copilot-studio/
- Support: Through Microsoft Support

### Chatbot Issues
- GitHub Issues: https://github.com/andreaswasita/AI-Delivery-Methodology/issues
- Check browser console for error details

---

## Coming Soon

- Azure OpenAI integration
- Custom prompt templates
- Comparison mode (run multiple providers)
- Conversation history export
- Team sharing features

Last updated: January 24, 2026
