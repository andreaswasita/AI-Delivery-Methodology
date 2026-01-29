// Local configuration template for Value Analysis Chatbot
// 
// SETUP INSTRUCTIONS:
// 1. Copy this file to: calculators/js/config.local.js
// 2. Add your API key to the new file
// 3. The config.local.js file is in .gitignore and won't be committed
//
// This keeps your API keys private while allowing local testing

const CONFIG = {
    // Add your Anthropic API key here for local testing
    // Get your key from: https://console.anthropic.com/
    ANTHROPIC_API_KEY: '',
    
    // Or add your Microsoft Copilot Studio endpoint here
    COPILOT_ENDPOINT: '',
    
    // Default provider: 'anthropic' or 'copilot'
    DEFAULT_PROVIDER: 'anthropic'
};

// Make config available globally
if (typeof window !== 'undefined') {
    window.CHATBOT_CONFIG = CONFIG;
}
