// AI Value Analysis Chatbot
// Interactive conversational interface for value analysis

class ValueAnalysisChatbot {
    constructor() {
        // Try to load from local config file (if it exists)
        const localConfig = (typeof window !== 'undefined' && window.CHATBOT_CONFIG) || {};
        
        // OPTION: Hardcode your API key here for LOCAL TESTING ONLY (not recommended)
        // Better: Use js/config.local.js file (see instructions below)
        const HARDCODED_ANTHROPIC_KEY = localConfig.ANTHROPIC_API_KEY || ''; // Leave empty for git commits
        const HARDCODED_COPILOT_ENDPOINT = localConfig.COPILOT_ENDPOINT || ''; // Leave empty for git commits
        
        this.state = {
            stage: 'welcome',
            projectName: '',
            useCases: [],
            currentUseCase: {},
            costs: [],
            currentCost: {},
            discountRate: 0.10,
            anthropicApiKey: HARDCODED_ANTHROPIC_KEY || localStorage.getItem('anthropic_api_key') || '',
            copilotEndpoint: HARDCODED_COPILOT_ENDPOINT || localStorage.getItem('copilot_endpoint') || '',
            aiProvider: localStorage.getItem('ai_provider') || (HARDCODED_ANTHROPIC_KEY ? 'anthropic' : (HARDCODED_COPILOT_ENDPOINT ? 'copilot' : '')),
            conversationHistory: [],
            conversationalMode: true
        };
        
        this.messages = [];
        this.init();
    }

    init() {
        console.log('🤖 Initializing Value Analysis Chatbot...');
        
        this.chatMessages = document.getElementById('chatMessages');
        this.userInput = document.getElementById('userInput');
        this.sendBtn = document.getElementById('sendBtn');
        this.resetBtn = document.getElementById('resetBtn');
        this.apiKeyBtn = document.getElementById('apiKeyBtn');
        this.quickReplies = document.getElementById('quickReplies');
        
        // Check if all elements exist
        const missingElements = [];
        if (!this.chatMessages) missingElements.push('chatMessages');
        if (!this.userInput) missingElements.push('userInput');
        if (!this.sendBtn) missingElements.push('sendBtn');
        if (!this.resetBtn) missingElements.push('resetBtn');
        if (!this.apiKeyBtn) missingElements.push('apiKeyBtn');
        if (!this.quickReplies) missingElements.push('quickReplies');
        
        if (missingElements.length > 0) {
            console.error('❌ Missing DOM elements:', missingElements.join(', '));
            alert('Chatbot initialization failed. Missing elements: ' + missingElements.join(', '));
            return;
        }
        
        console.log('✅ All DOM elements found');
        
        // Event listeners with detailed error handling
        try {
            this.sendBtn.addEventListener('click', () => {
                console.log('📤 Send button clicked');
                try {
                    this.handleSend();
                } catch (error) {
                    console.error('❌ Error in handleSend:', error);
                    alert('Error processing message: ' + error.message);
                }
            });
            console.log('✅ Send button listener attached');
        } catch (error) {
            console.error('❌ Failed to attach send button listener:', error);
        }
        
        try {
            this.userInput.addEventListener('keypress', (e) => {
                if (e.key === 'Enter') {
                    console.log('⌨️ Enter key pressed');
                    try {
                        this.handleSend();
                    } catch (error) {
                        console.error('❌ Error in handleSend from Enter key:', error);
                    }
                }
            });
            console.log('✅ Input keypress listener attached');
        } catch (error) {
            console.error('❌ Failed to attach keypress listener:', error);
        }
        
        try {
            this.resetBtn.addEventListener('click', () => {
                console.log('🔄 Reset button clicked');
                this.reset();
            });
            console.log('✅ Reset button listener attached');
        } catch (error) {
            console.error('❌ Failed to attach reset button listener:', error);
        }
        
        try {
            this.apiKeyBtn.addEventListener('click', () => {
                console.log('🔑 API Key button clicked');
                this.manageApiKey();
            });
            console.log('✅ API Key button listener attached');
        } catch (error) {
            console.error('❌ Failed to attach API key button listener:', error);
        }
        
        console.log('✅ Event listeners attached');
        
        // Update button visual if provider is configured
        this.updateProviderIndicator();
        
        // Log current state
        console.log('📊 Current state:', {
            hasAnthropicKey: !!this.state.anthropicApiKey,
            hasCopilotEndpoint: !!this.state.copilotEndpoint,
            aiProvider: this.state.aiProvider
        });
        
        // Start conversation
        console.log('🚀 Starting conversation...');
        this.showWelcome();
    }

    updateProviderIndicator() {
        if (!this.apiKeyBtn) return;
        
        if (this.state.aiProvider) {
            this.apiKeyBtn.classList.add('has-provider');
            this.apiKeyBtn.title = `AI Provider: ${this.state.aiProvider === 'anthropic' ? 'Anthropic Claude' : 'Microsoft Copilot Studio'}`;
        } else {
            this.apiKeyBtn.classList.remove('has-provider');
            this.apiKeyBtn.title = 'AI Provider Settings';
        }
    }

    manageApiKey() {
        const hasAnthropicKey = !!this.state.anthropicApiKey;
        const hasCopilotEndpoint = !!this.state.copilotEndpoint;
        const hasAnyProvider = hasAnthropicKey || hasCopilotEndpoint;
        
        let message = '🤖 **AI Provider Settings**\n\n';
        
        message += '⚠️ **Important:** Browser CORS restrictions prevent direct API calls to Anthropic/OpenAI. ' +
                   'AI conversational mode requires a backend proxy server.\n\n' +
                   '✅ **Recommended:** Use the built-in Structured Mode for best experience.\n\n';
        
        if (hasAnyProvider) {
            message += '**Current Configuration:**\n';
            if (hasAnthropicKey) message += '✅ Anthropic Claude: Configured (requires proxy)\n';
            if (hasCopilotEndpoint) message += '✅ Microsoft Copilot Studio: Configured\n';
            message += `\n**Active Provider:** ${this.state.aiProvider || 'None selected'}\n\n`;
            message += 'What would you like to do?';
            
            this.addBotMessage(message);
            this.showQuickReplies([
                { label: '🔄 Change Provider', value: 'select_provider' },
                { label: '🔑 Manage Keys', value: 'manage_keys' },
                { label: '🗑️ Clear Configuration', value: 'clear_all' },
                { label: '❌ Cancel', value: 'cancel' }
            ]);
        } else {
            message += '💡 **Note:** The chatbot works great in Structured Mode without any API configuration.\n\n';
            message += 'Only configure API access if you have a backend proxy server setup.';
            
            this.addBotMessage(message);
            this.showQuickReplies([
                { label: '✅ Continue in Structured Mode', value: 'cancel' },
                { label: '🔧 Advanced: Configure API', value: 'show_api_options' }
            ]);
        }
        this.state.previousStage = this.state.stage;
        this.state.stage = 'ai_provider_menu';
    }

    async showWelcome() {
        // Always start with structured mode (AI mode has CORS limitations from browsers)
        this.addBotMessage(
            "👋 Hi! I'm your AI Value Analysis Assistant. I'll help you analyze the business value of your AI initiatives.",
            () => {
                this.addBotMessage(
                    "I'll guide you through a comprehensive structured analysis:\n\n" +
                    "• 📊 Quantifying business benefits\n" +
                    "• 💰 Calculating ROI and NPV\n" +
                    "• 🎯 Prioritizing use cases\n" +
                    "• 📈 Risk-adjusted value modeling\n\n" +
                    "Based on the Microsoft AI Frontier 9-phase delivery methodology.\n\n" +
                    "Let's get started! What's your project name?"
                );
            },
            500
        );
        this.state.stage = 'project_name';
    }

    handleSend() {
        const message = this.userInput.value.trim();
        console.log('📨 handleSend called, message:', message);
        
        if (!message) {
            console.log('⚠️ Empty message, ignoring');
            return;
        }
        
        this.addUserMessage(message);
        this.userInput.value = '';
        
        // Process based on current stage
        console.log('🔄 Processing input for stage:', this.state.stage);
        this.processInput(message);
    }

    processInput(input) {
        const stage = this.state.stage;
        console.log(`🎯 processInput - Stage: ${stage}, Input: ${input}`);
        
        // Handle conversational mode with Claude AI
        if (stage === 'conversational') {
            if (input === 'generate_analysis') {
                this.generateAnalysis();
            } else if (input === 'continue') {
                this.addBotMessage("Great! What else would you like to discuss about your AI initiative?");
            } else {
                this.handleConversationalInput(input);
            }
            return;
        }
        
        switch(stage) {
            case 'project_name':
                this.state.projectName = input;
                this.addBotMessage(
                    `Great! "${input}" it is. Now let's add your first use case.\n\n` +
                    `What would you like to call it? (e.g., "Customer Service Chatbot")`
                );
                this.state.stage = 'use_case_title';
                break;
                
            case 'use_case_title':
                this.state.currentUseCase = { title: input };
                this.addBotMessage(
                    `Perfect! Now, what business problem does "${input}" solve?\n\n` +
                    `Be specific about the current pain point.`
                );
                this.state.stage = 'use_case_problem';
                break;
                
            case 'use_case_problem':
                this.state.currentUseCase.problem = input;
                this.addBotMessage(
                    "Excellent. Now let's assess the impact level of this use case."
                );
                this.showQuickReplies([
                    { label: '🔴 CRITICAL', value: '5' },
                    { label: '🟠 HIGH', value: '4' },
                    { label: '🟡 MEDIUM', value: '3' },
                    { label: '🔵 LOW', value: '2' },
                    { label: '⚪ MINIMAL', value: '1' }
                ]);
                this.state.stage = 'use_case_impact';
                break;
                
            case 'use_case_impact':
                this.state.currentUseCase.impact = parseInt(input);
                const impactLabels = ['', 'MINIMAL', 'LOW', 'MEDIUM', 'HIGH', 'CRITICAL'];
                this.addBotMessage(
                    `Impact level: ${impactLabels[input]} ✓\n\n` +
                    `How much effort will this require? (in story points or person-days)`
                );
                this.state.stage = 'use_case_effort';
                break;
                
            case 'use_case_effort':
                this.state.currentUseCase.effort = parseFloat(input);
                this.state.currentUseCase.benefits = [];
                this.addBotMessage(
                    `Got it, ${input} points of effort.\n\n` +
                    `Now let's quantify the benefits. What type of benefit should we add first?`
                );
                this.showQuickReplies([
                    { label: '💰 Revenue Growth', value: 'revenue' },
                    { label: '💵 Cost Reduction', value: 'cost_reduction' },
                    { label: '🛡️ Risk Mitigation', value: 'risk' },
                    { label: '⚡ Efficiency', value: 'efficiency' },
                    { label: '👥 Customer Experience', value: 'customer' },
                    { label: '⏭️ Skip Benefits', value: 'skip' }
                ]);
                this.state.stage = 'benefit_category';
                break;
                
            case 'benefit_category':
                if (input === 'skip') {
                    this.finishUseCase();
                } else {
                    this.state.currentBenefit = { category: input };
                    const categoryNames = {
                        'revenue': 'Revenue Growth',
                        'cost_reduction': 'Cost Reduction',
                        'risk': 'Risk Mitigation',
                        'efficiency': 'Efficiency Improvement',
                        'customer': 'Customer Experience'
                    };
                    this.addBotMessage(
                        `Great! Let's add a ${categoryNames[input]} benefit.\n\n` +
                        `What's the description? (e.g., "Reduced labor costs from automation")`
                    );
                    this.state.stage = 'benefit_description';
                }
                break;
                
            case 'benefit_description':
                this.state.currentBenefit.description = input;
                this.addBotMessage(
                    `Perfect. Now let's project the annual benefits for 5 years.\n\n` +
                    `Enter Year 1 benefit in dollars (e.g., 500000):`
                );
                this.state.stage = 'benefit_year_1';
                break;
                
            case 'benefit_year_1':
                this.state.currentBenefit.year_1 = parseFloat(input);
                this.addBotMessage(`Year 2 benefit ($):`);
                this.state.stage = 'benefit_year_2';
                break;
                
            case 'benefit_year_2':
                this.state.currentBenefit.year_2 = parseFloat(input);
                this.addBotMessage(`Year 3 benefit ($):`);
                this.state.stage = 'benefit_year_3';
                break;
                
            case 'benefit_year_3':
                this.state.currentBenefit.year_3 = parseFloat(input);
                this.addBotMessage(`Year 4 benefit ($):`);
                this.state.stage = 'benefit_year_4';
                break;
                
            case 'benefit_year_4':
                this.state.currentBenefit.year_4 = parseFloat(input);
                this.addBotMessage(`Year 5 benefit ($):`);
                this.state.stage = 'benefit_year_5';
                break;
                
            case 'benefit_year_5':
                this.state.currentBenefit.year_5 = parseFloat(input);
                const total = this.state.currentBenefit.year_1 + 
                             this.state.currentBenefit.year_2 + 
                             this.state.currentBenefit.year_3 + 
                             this.state.currentBenefit.year_4 + 
                             this.state.currentBenefit.year_5;
                
                this.state.currentUseCase.benefits.push({...this.state.currentBenefit});
                
                this.addBotMessage(
                    `✅ Benefit added! Total 5-year value: $${this.formatCurrency(total)}\n\n` +
                    `Would you like to add another benefit for this use case?`
                );
                this.showQuickReplies([
                    { label: '✅ Yes, add another', value: 'yes' },
                    { label: '⏭️ No, finish use case', value: 'no' }
                ]);
                this.state.stage = 'benefit_more';
                break;
                
            case 'benefit_more':
                if (input === 'yes') {
                    this.addBotMessage('What type of benefit?');
                    this.showQuickReplies([
                        { label: '💰 Revenue Growth', value: 'revenue' },
                        { label: '💵 Cost Reduction', value: 'cost_reduction' },
                        { label: '🛡️ Risk Mitigation', value: 'risk' },
                        { label: '⚡ Efficiency', value: 'efficiency' },
                        { label: '👥 Customer Experience', value: 'customer' }
                    ]);
                    this.state.stage = 'benefit_category';
                } else {
                    this.finishUseCase();
                }
                break;
                
            case 'add_more_use_cases':
                if (input === 'yes') {
                    this.addBotMessage('Great! What\'s the title of the next use case?');
                    this.state.currentUseCase = {};
                    this.state.stage = 'use_case_title';
                } else if (input === 'costs') {
                    this.startCostEntry();
                } else {
                    this.generateAnalysis();
                }
                break;
                
            case 'cost_category':
                this.state.currentCost = { category: input };
                this.addBotMessage(
                    `Adding ${input} costs. Provide a description:`
                );
                this.state.stage = 'cost_description';
                break;
                
            case 'cost_description':
                this.state.currentCost.description = input;
                this.addBotMessage(`Year 0 (initial investment) cost ($):`);
                this.state.stage = 'cost_year_0';
                break;
                
            case 'cost_year_0':
                this.state.currentCost.year_0 = parseFloat(input);
                this.addBotMessage(`Year 1 recurring cost ($):`);
                this.state.stage = 'cost_year_1';
                break;
                
            case 'cost_year_1':
                this.state.currentCost.year_1 = parseFloat(input);
                this.addBotMessage(`Year 2 cost ($):`);
                this.state.stage = 'cost_year_2';
                break;
                
            case 'cost_year_2':
                this.state.currentCost.year_2 = parseFloat(input);
                this.addBotMessage(`Year 3 cost ($):`);
                this.state.stage = 'cost_year_3';
                break;
                
            case 'cost_year_3':
                this.state.currentCost.year_3 = parseFloat(input);
                this.addBotMessage(`Year 4 cost ($):`);
                this.state.stage = 'cost_year_4';
                break;
                
            case 'cost_year_4':
                this.state.currentCost.year_4 = parseFloat(input);
                this.addBotMessage(`Year 5 cost ($):`);
                this.state.stage = 'cost_year_5';
                break;
                
            case 'cost_year_5':
                this.state.currentCost.year_5 = parseFloat(input);
                const costTotal = this.state.currentCost.year_0 + 
                                 this.state.currentCost.year_1 + 
                                 this.state.currentCost.year_2 + 
                                 this.state.currentCost.year_3 + 
                                 this.state.currentCost.year_4 + 
                                 this.state.currentCost.year_5;
                
                this.state.costs.push({...this.state.currentCost});
                
                this.addBotMessage(
                    `✅ Cost added! Total: $${this.formatCurrency(costTotal)}\n\n` +
                    `Add another cost category?`
                );
                this.showQuickReplies([
                    { label: '✅ Yes', value: 'yes' },
                    { label: '✨ Generate Analysis', value: 'no' }
                ]);
                this.state.stage = 'cost_more';
                break;
                
            case 'cost_more':
                if (input === 'yes') {
                    this.addBotMessage('What cost category?');
                    this.showQuickReplies([
                        { label: '💻 Development', value: 'Development' },
                        { label: '☁️ Infrastructure', value: 'Infrastructure' },
                        { label: '⚙️ Operations', value: 'Operations' },
                        { label: '📚 Training', value: 'Training' },
                        { label: '📝 Other', value: 'Other' }
                    ]);
                    this.state.stage = 'cost_category';
                } else {
                    this.generateAnalysis();
                }
                break;
                
            case 'final_actions':
                if (input === 'ai_insights') {
                    // Check if any provider is configured
                    if (!this.state.aiProvider) {
                        this.addBotMessage('🤖 Choose your AI provider:');
                        this.showQuickReplies([
                            { label: '🔵 Anthropic Claude', value: 'setup_anthropic' },
                            { label: '🟢 Microsoft Copilot Studio', value: 'setup_copilot' },
                            { label: '⏭️ Skip AI Insights', value: 'report' }
                        ]);
                        this.state.stage = 'ai_provider_menu';
                    } else {
                        this.getAIInsights(this.state.analysis);
                    }
                } else if (input === 'api_key_input_request') {
                    this.addBotMessage(
                        '🔑 Please paste your Anthropic API key below.\n\n' +
                        'Get your key at: https://console.anthropic.com/\n\n' +
                        '(Your key is stored locally and never sent anywhere except Anthropic\'s API)'
                    );
                    this.state.stage = 'api_key_input';
                } else if (input === 'report') {
                    this.showDetailedReport();
                } else if (input === 'json') {
                    this.exportJSON();
                } else if (input === 'reset') {
                    this.reset();
                }
                break;

            case 'api_key_input':
                if (input && input.startsWith('sk-ant-')) {
                    this.saveApiKey(input);
                } else {
                    this.addBotMessage(
                        '❌ That doesn\'t look like a valid Anthropic API key.\n\n' +
                        'API keys start with "sk-ant-". Please try again or skip AI insights.'
                    );
                    this.showQuickReplies([
                        { label: '🔄 Try Again', value: 'api_key_input_request' },
                        { label: '⏭️ Skip AI Insights', value: 'report' }
                    ]);
                    this.state.stage = 'final_actions';
                }
                break;

            case 'ai_provider_menu':
                if (input === 'show_api_options') {
                    this.addBotMessage('Choose an AI provider to configure:');
                    this.showQuickReplies([
                        { label: '🔵 Anthropic Claude', value: 'setup_anthropic' },
                        { label: '🟢 Microsoft Copilot Studio', value: 'setup_copilot' },
                        { label: '❌ Cancel', value: 'cancel' }
                    ]);
                    this.state.stage = 'ai_provider_menu';
                } else if (input === 'setup_anthropic') {
                    this.addBotMessage(
                        '🔵 **Anthropic Claude Setup**\n\n' +
                        '⚠️ **Important:** Direct browser calls to Anthropic API are blocked by CORS.\n\n' +
                        'You need a backend proxy to use this. If you have one, paste your API key:\n' +
                        '(Starts with "sk-ant-")\n\n' +
                        'Get one at: https://console.anthropic.com/'
                    );
                    this.state.stage = 'anthropic_key_input';
                } else if (input === 'setup_copilot') {
                    this.addBotMessage(
                        '🟢 **Microsoft Copilot Studio Setup**\n\n' +
                        'Please paste your Copilot Studio endpoint URL:\n' +
                        '(Example: https://your-bot.azurewebsites.net/api/messages)\n\n' +
                        'Get this from your Copilot Studio bot settings.'
                    );
                    this.state.stage = 'copilot_endpoint_input';
                } else if (input === 'select_provider') {
                    this.addBotMessage('Which provider would you like to use?');
                    const options = [];
                    if (this.state.anthropicApiKey) {
                        options.push({ label: '🔵 Anthropic Claude', value: 'use_anthropic' });
                    }
                    if (this.state.copilotEndpoint) {
                        options.push({ label: '🟢 Microsoft Copilot Studio', value: 'use_copilot' });
                    }
                    options.push({ label: '❌ Cancel', value: 'cancel' });
                    this.showQuickReplies(options);
                    this.state.stage = 'provider_selection';
                } else if (input === 'manage_keys') {
                    this.addBotMessage('Which provider credentials would you like to manage?');
                    this.showQuickReplies([
                        { label: '🔵 Anthropic Claude', value: 'manage_anthropic' },
                        { label: '🟢 Microsoft Copilot Studio', value: 'manage_copilot' },
                        { label: '❌ Cancel', value: 'cancel' }
                    ]);
                    this.state.stage = 'key_management';
                } else if (input === 'clear_all') {
                    localStorage.removeItem('anthropic_api_key');
                    localStorage.removeItem('copilot_endpoint');
                    localStorage.removeItem('ai_provider');
                    this.state.anthropicApiKey = '';
                    this.state.copilotEndpoint = '';
                    this.state.aiProvider = '';
                    this.updateProviderIndicator();
                    this.addBotMessage('✅ All API configurations cleared. Continuing in Structured Mode.');
                    this.state.stage = 'project_name';
                } else {
                    this.addBotMessage('Cancelled.');
                    this.state.stage = this.state.previousStage || 'project_name';
                }
                break;

            case 'provider_selection':
                if (input === 'use_anthropic') {
                    this.state.aiProvider = 'anthropic';
                    localStorage.setItem('ai_provider', 'anthropic');
                    this.updateProviderIndicator();
                    this.addBotMessage('✅ Switched to Anthropic Claude!');
                    this.state.stage = this.state.previousStage;
                } else if (input === 'use_copilot') {
                    this.state.aiProvider = 'copilot';
                    localStorage.setItem('ai_provider', 'copilot');
                    this.updateProviderIndicator();
                    this.addBotMessage('✅ Switched to Microsoft Copilot Studio!');
                    this.state.stage = this.state.previousStage;
                } else {
                    this.addBotMessage('Cancelled.');
                    this.state.stage = this.state.previousStage;
                }
                break;

            case 'key_management':
                if (input === 'manage_anthropic') {
                    const hasKey = !!this.state.anthropicApiKey;
                    if (hasKey) {
                        this.addBotMessage('Anthropic API Key: Configured\n\nWhat would you like to do?');
                        this.showQuickReplies([
                            { label: '🔄 Update Key', value: 'update_anthropic' },
                            { label: '🗑️ Remove Key', value: 'remove_anthropic' },
                            { label: '❌ Cancel', value: 'cancel' }
                        ]);
                    } else {
                        this.addBotMessage('No Anthropic API key configured. Would you like to add one?');
                        this.showQuickReplies([
                            { label: '➕ Add Key', value: 'setup_anthropic' },
                            { label: '❌ Cancel', value: 'cancel' }
                        ]);
                    }
                    this.state.stage = 'ai_provider_menu';
                } else if (input === 'manage_copilot') {
                    const hasEndpoint = !!this.state.copilotEndpoint;
                    if (hasEndpoint) {
                        this.addBotMessage('Microsoft Copilot Studio: Configured\n\nWhat would you like to do?');
                        this.showQuickReplies([
                            { label: '🔄 Update Endpoint', value: 'update_copilot' },
                            { label: '🗑️ Remove Endpoint', value: 'remove_copilot' },
                            { label: '❌ Cancel', value: 'cancel' }
                        ]);
                    } else {
                        this.addBotMessage('No Copilot Studio endpoint configured. Would you like to add one?');
                        this.showQuickReplies([
                            { label: '➕ Add Endpoint', value: 'setup_copilot' },
                            { label: '❌ Cancel', value: 'cancel' }
                        ]);
                    }
                    this.state.stage = 'ai_provider_menu';
                } else if (input === 'update_anthropic') {
                    this.addBotMessage('Please paste your new Anthropic API key:');
                    this.state.stage = 'anthropic_key_input';
                } else if (input === 'remove_anthropic') {
                    localStorage.removeItem('anthropic_api_key');
                    this.state.anthropicApiKey = '';
                    if (this.state.aiProvider === 'anthropic') {
                        this.state.aiProvider = '';
                        localStorage.removeItem('ai_provider');
                        this.updateProviderIndicator();
                    }
                    this.addBotMessage('✅ Anthropic API key removed.');
                    this.state.stage = this.state.previousStage;
                } else if (input === 'update_copilot') {
                    this.addBotMessage('Please paste your new Copilot Studio endpoint URL:');
                    this.state.stage = 'copilot_endpoint_input';
                } else if (input === 'remove_copilot') {
                    localStorage.removeItem('copilot_endpoint');
                    this.state.copilotEndpoint = '';
                    if (this.state.aiProvider === 'copilot') {
                        this.state.aiProvider = '';
                        localStorage.removeItem('ai_provider');
                        this.updateProviderIndicator();
                    }
                    this.addBotMessage('✅ Copilot Studio endpoint removed.');
                    this.state.stage = this.state.previousStage;
                } else {
                    this.addBotMessage('Cancelled.');
                    this.state.stage = this.state.previousStage;
                }
                break;

            case 'anthropic_key_input':
                if (input && input.startsWith('sk-ant-')) {
                    this.state.anthropicApiKey = input;
                    localStorage.setItem('anthropic_api_key', input);
                    this.state.aiProvider = 'anthropic';
                    localStorage.setItem('ai_provider', 'anthropic');
                    this.updateProviderIndicator();
                    this.addBotMessage('✅ Anthropic Claude configured successfully!');
                    this.state.stage = this.state.previousStage;
                    // If we have analysis ready, offer to run insights
                    if (this.state.analysis) {
                        setTimeout(() => {
                            this.addBotMessage('Would you like to get AI insights now?');
                            this.showQuickReplies([
                                { label: '🤖 Get AI Insights', value: 'ai_insights' },
                                { label: '⏭️ Skip', value: 'report' }
                            ]);
                            this.state.stage = 'final_actions';
                        }, 500);
                    }
                } else {
                    this.addBotMessage(
                        '❌ Invalid API key format. Keys should start with "sk-ant-".\n\n' +
                        'Please try again or cancel.'
                    );
                    this.showQuickReplies([
                        { label: '🔄 Try Again', value: 'setup_anthropic' },
                        { label: '❌ Cancel', value: 'cancel' }
                    ]);
                    this.state.stage = 'ai_provider_menu';
                }
                break;

            case 'copilot_endpoint_input':
                if (input && (input.startsWith('http://') || input.startsWith('https://'))) {
                    this.state.copilotEndpoint = input;
                    localStorage.setItem('copilot_endpoint', input);
                    this.state.aiProvider = 'copilot';
                    localStorage.setItem('ai_provider', 'copilot');
                    this.updateProviderIndicator();
                    this.addBotMessage('✅ Microsoft Copilot Studio configured successfully!');
                    this.state.stage = this.state.previousStage;
                    // If we have analysis ready, offer to run insights
                    if (this.state.analysis) {
                        setTimeout(() => {
                            this.addBotMessage('Would you like to get AI insights now?');
                            this.showQuickReplies([
                                { label: '🤖 Get AI Insights', value: 'ai_insights' },
                                { label: '⏭️ Skip', value: 'report' }
                            ]);
                            this.state.stage = 'final_actions';
                        }, 500);
                    }
                } else {
                    this.addBotMessage(
                        '❌ Invalid endpoint URL. It should start with "http://" or "https://".\n\n' +
                        'Please try again or cancel.'
                    );
                    this.showQuickReplies([
                        { label: '🔄 Try Again', value: 'setup_copilot' },
                        { label: '❌ Cancel', value: 'cancel' }
                    ]);
                    this.state.stage = 'ai_provider_menu';
                }
                break;

            case 'api_key_manage':
                if (input === 'add_key' || input === 'update_key') {
                    this.addBotMessage(
                        '🔑 Please paste your Anthropic API key:\n\n' +
                        '(Starts with "sk-ant-")'
                    );
                    this.state.stage = 'api_key_input_direct';
                } else if (input === 'remove_key') {
                    localStorage.removeItem('anthropic_api_key');
                    this.state.anthropicApiKey = '';
                    this.addBotMessage('✅ API key removed from local storage.');
                    this.state.stage = this.state.previousStage;
                } else {
                    this.addBotMessage('Cancelled. Continuing...');
                    this.state.stage = this.state.previousStage;
                }
                break;

            case 'api_key_input_direct':
                if (input && input.startsWith('sk-ant-')) {
                    this.state.anthropicApiKey = input;
                    localStorage.setItem('anthropic_api_key', input);
                    this.state.aiProvider = 'anthropic';
                    localStorage.setItem('ai_provider', 'anthropic');
                    this.updateProviderIndicator();
                    this.addBotMessage('✅ API key saved successfully!');
                    this.state.stage = this.state.previousStage || 'project_name';
                } else {
                    this.addBotMessage(
                        '❌ Invalid API key format. Keys should start with "sk-ant-".\n\n' +
                        'Please try again or cancel.'
                    );
                    this.showQuickReplies([
                        { label: '🔄 Try Again', value: 'add_key' },
                        { label: '❌ Cancel', value: 'cancel' }
                    ]);
                    this.state.stage = 'api_key_manage';
                }
                break;

            case 'ai_provider_choice':
                if (input === 'use_structured') {
                    this.addBotMessage(
                        "Perfect! I'll guide you through a structured analysis.\n\n" +
                        "Let's get started! What's your project name?"
                    );
                    this.state.stage = 'project_name';
                } else if (input === 'configure_ai') {
                    this.manageApiKey();
                }
                break;

            case 'ai_error_recovery':
                if (input === 'use_structured') {
                    this.addBotMessage(
                        "No problem! Switching to structured mode.\n\n" +
                        "Let's get started! What's your project name?"
                    );
                    this.state.stage = 'project_name';
                } else if (input === 'configure_ai') {
                    this.manageApiKey();
                } else if (input === 'retry' && this.state.lastUserMessage) {
                    this.handleConversationalInput(this.state.lastUserMessage);
                }
                break;
        }
    }

    async handleConversationalInput(userMessage) {
        console.log('💬 Conversational mode - processing:', userMessage);
        
        // Check if AI provider is actually configured
        if (!this.state.anthropicApiKey && !this.state.copilotEndpoint) {
            console.warn('⚠️ No AI provider configured, falling back to structured mode');
            this.addBotMessage(
                `⚠️ **AI-Powered Conversational Mode**\n\n` +
                `This chatbot uses AI to provide intelligent guidance. To enable:\n\n` +
                `1. Click the 🤖 button in the header\n2. Configure your API key\n\n` +
                `💡 **No API key?** No problem! The chatbot will work in structured mode with guided questions.\n\n` +
                `Would you like to continue with structured mode?`
            );
            this.showQuickReplies([
                { label: '✅ Yes, continue in structured mode', value: 'use_structured' },
                { label: '🤖 Configure AI provider', value: 'configure_ai' }
            ]);
            this.state.stage = 'ai_provider_choice';
            return;
        }
        
        // Add to conversation history
        this.state.conversationHistory.push({
            role: 'user',
            content: userMessage
        });
        
        // Show typing indicator
        this.addBotMessage('💭 Thinking...');
        
        try {
            // Build conversational prompt with methodology context
            const response = await this.getConversationalResponse(userMessage);
            
            // Remove typing indicator
            const messages = this.chatMessages.querySelectorAll('.message');
            if (messages.length > 0) {
                const lastMessage = messages[messages.length - 1];
                if (lastMessage.textContent.includes('💭 Thinking...')) {
                    lastMessage.remove();
                }
            }
            
            // Add Claude's response
            this.addBotMessage(response.message);
            
            // Store in history
            this.state.conversationHistory.push({
                role: 'assistant',
                content: response.message
            });
            
            // If Claude has extracted structured data, update state
            if (response.extractedData) {
                this.updateStateFromExtraction(response.extractedData);
            }
            
            // Check if we have enough data to generate analysis
            if (response.readyForAnalysis) {
                setTimeout(() => {
                    this.showQuickReplies([
                        { label: '📊 Generate Analysis Now', value: 'generate_analysis' },
                        { label: '💬 Continue Discussion', value: 'continue' }
                    ]);
                }, 500);
            }
            
        } catch (error) {
            console.error('❌ Conversational error:', error);
            
            // Remove typing indicator
            const messages = this.chatMessages.querySelectorAll('.message');
            if (messages.length > 0) {
                const lastMessage = messages[messages.length - 1];
                if (lastMessage.textContent.includes('💭 Thinking...')) {
                    lastMessage.remove();
                }
            }
            
            // Check if it's an API key issue
            if (error.message.includes('Failed to fetch') || error.message.includes('API') || error.message.includes('401') || error.message.includes('403')) {
                this.addBotMessage(
                    `❌ **AI Service Error**\n\n` +
                    `${error.message}\n\n` +
                    `This might be due to:\n` +
                    `• Invalid or expired API key\n` +
                    `• Network connectivity issues\n` +
                    `• API service unavailable\n\n` +
                    `Would you like to continue in structured mode (without AI)?`
                );
                this.showQuickReplies([
                    { label: '✅ Yes, use structured mode', value: 'use_structured' },
                    { label: '🔧 Update API settings', value: 'configure_ai' },
                    { label: '🔄 Try again', value: 'retry' }
                ]);
                this.state.stage = 'ai_error_recovery';
                this.state.lastUserMessage = userMessage; // Store for retry
            } else {
                this.addBotMessage(
                    `❌ I encountered an error: ${error.message}\n\n` +
                    `Let's continue our discussion. What else would you like to tell me about your AI initiative?`
                );
            }
        }
    }

    async getConversationalResponse(userMessage) {
        const systemPrompt = this.buildConversationalSystemPrompt();
        const conversationContext = this.buildConversationContext();
        
        const fullPrompt = `${systemPrompt}\n\n${conversationContext}\n\nUser: ${userMessage}\n\nRespond naturally as an AI delivery consultant. Extract any relevant information about the project, use cases, benefits, or costs. If you have enough information for analysis, indicate readiness.`;
        
        let responseText;
        
        if (this.state.aiProvider === 'anthropic') {
            responseText = await this.callAnthropicAPI(fullPrompt);
        } else if (this.state.aiProvider === 'copilot') {
            responseText = await this.callCopilotStudioAPI(fullPrompt);
        }
        
        // Parse response for structured data
        const extractedData = this.extractStructuredData(responseText);
        const readyForAnalysis = this.checkIfReadyForAnalysis();
        
        return {
            message: responseText,
            extractedData: extractedData,
            readyForAnalysis: readyForAnalysis
        };
    }

    buildConversationalSystemPrompt() {
        return `You are an expert AI delivery consultant with deep knowledge of the Microsoft AI Frontier "Vision to Value" methodology. You guide delivery teams through value analysis in a natural, conversational way.

**YOUR ROLE:**
- Have natural, flowing conversations about AI initiatives
- Guide teams through value analysis using the methodology
- Ask clarifying questions when needed
- Extract structured information (use cases, benefits, costs) from natural language
- Provide insights based on delivery best practices

**MICROSOFT AI FRONTIER METHODOLOGY (9 Phases):**
1. **Business Envisioning** - Align stakeholders, define vision, identify high-value use cases
2. **Mobilization** - Establish governance, form teams, create project charter
3. **Hackathons & Prototyping** - Rapid experimentation, proof of concept
4. **Setup Platform** - Azure infrastructure, MLOps foundation, security
5. **Build** - Model development, feature engineering, iterative improvement
6. **Integrate** - API development, system integration, data pipelines
7. **Test & Evaluate** - Model validation, bias testing, performance benchmarking
8. **Prepare & Deploy** - Staging deployment, monitoring setup, rollout planning
9. **Operate & Care** - Production monitoring, continuous improvement, scaling

**BEST PRACTICES:**
- Prioritize by Value Score (Benefit/Effort ratio) and Business Impact
- Plan 3-6 month MVP cycles per use case
- Allocate 20-30% effort for MLOps, governance, platform
- Story points: 1 point = 1 person-day typically
- Factor in Azure costs (compute, storage, AI services)
- 40% of effort goes to data preparation
- Executive sponsorship is critical

**CONVERSATION GUIDELINES:**
- Be warm, professional, and consultative
- Ask one question at a time
- Acknowledge what you've learned
- Guide toward key information: project goals, use cases, benefits (quantified), costs, timeline
- Reference methodology phases when relevant
- Provide insights based on delivery patterns
- Keep responses concise (2-3 paragraphs max)

**INFORMATION TO GATHER:**
- Project name and vision
- Business problems being solved
- Specific use cases
- Expected benefits (with $ amounts when possible)
- Estimated effort (story points or person-days)
- Cost estimates (development, infrastructure, operations)
- Timeline expectations
- Stakeholder context

**CURRENT STATE:**
${this.state.projectName ? `Project: ${this.state.projectName}` : 'No project name yet'}
${this.state.useCases.length > 0 ? `Use cases identified: ${this.state.useCases.length}` : 'No use cases yet'}
${this.state.costs.length > 0 ? `Cost categories: ${this.state.costs.length}` : 'No costs captured yet'}

Respond naturally and guide the conversation forward.`;
    }

    buildConversationContext() {
        if (this.state.conversationHistory.length === 0) {
            return "This is the start of the conversation.";
        }
        
        return this.state.conversationHistory
            .slice(-10) // Last 10 messages for context
            .map(msg => `${msg.role === 'user' ? 'User' : 'Assistant'}: ${msg.content}`)
            .join('\n\n');
    }

    extractStructuredData(responseText) {
        // This is a simple extraction - in production, you'd use more sophisticated NLP
        // or have Claude return JSON alongside the conversational response
        const data = {};
        
        // Look for project name hints
        const projectMatch = responseText.match(/project.*?"([^"]+)"/i) || 
                           responseText.match(/initiative.*?"([^"]+)"/i);
        if (projectMatch && !this.state.projectName) {
            data.projectName = projectMatch[1];
        }
        
        return data;
    }

    updateStateFromExtraction(extractedData) {
        if (extractedData.projectName) {
            this.state.projectName = extractedData.projectName;
            console.log('📝 Extracted project name:', extractedData.projectName);
        }
        // Add more extraction logic as needed
    }

    checkIfReadyForAnalysis() {
        // Check if we have minimum information for analysis
        return this.state.projectName && 
               this.state.useCases.length > 0 && 
               this.state.useCases.some(uc => uc.benefits && uc.benefits.length > 0);
    }

    finishUseCase() {
        const uc = this.state.currentUseCase;
        const totalBenefit = uc.benefits.reduce((sum, b) => 
            sum + b.year_1 + b.year_2 + b.year_3 + b.year_4 + b.year_5, 0
        );
        
        uc.totalBenefit = totalBenefit;
        uc.valueScore = totalBenefit / uc.effort;
        this.state.useCases.push({...uc});
        
        this.addBotMessage(
            `✅ Use case "${uc.title}" completed!\n\n` +
            `📊 Quick Stats:\n` +
            `• Total 5-year benefit: $${this.formatCurrency(totalBenefit)}\n` +
            `• Effort: ${uc.effort} points\n` +
            `• Value Score: ${this.formatCurrency(uc.valueScore)} per point\n\n` +
            `What would you like to do next?`
        );
        
        this.showQuickReplies([
            { label: '➕ Add another use case', value: 'yes' },
            { label: '💰 Add costs', value: 'costs' },
            { label: '✨ Generate analysis', value: 'no' }
        ]);
        this.state.stage = 'add_more_use_cases';
    }

    startCostEntry() {
        this.addBotMessage(
            'Great! Let\'s add project costs.\n\n' +
            'What cost category should we start with?'
        );
        this.showQuickReplies([
            { label: '💻 Development', value: 'Development' },
            { label: '☁️ Infrastructure', value: 'Infrastructure' },
            { label: '⚙️ Operations', value: 'Operations' },
            { label: '📚 Training', value: 'Training' },
            { label: '📝 Other', value: 'Other' }
        ]);
        this.state.stage = 'cost_category';
    }

    generateAnalysis() {
        this.addBotMessage('🔄 Generating comprehensive analysis...');
        
        setTimeout(() => {
            const analysis = this.calculateAnalysis();
            this.displayAnalysis(analysis);
        }, 1000);
    }

    calculateAnalysis() {
        // Calculate totals
        const totalBenefits = this.state.useCases.reduce((sum, uc) => sum + uc.totalBenefit, 0);
        const totalCosts = this.state.costs.reduce((sum, cost) => 
            sum + cost.year_0 + cost.year_1 + cost.year_2 + cost.year_3 + cost.year_4 + cost.year_5, 0
        );
        
        const netBenefit = totalBenefits - totalCosts;
        const roi = totalCosts > 0 ? (netBenefit / totalCosts * 100) : 0;
        
        // Calculate NPV
        const cashFlows = [-(this.state.costs.reduce((sum, c) => sum + c.year_0, 0))];
        for (let year = 1; year <= 5; year++) {
            const yearBenefits = this.state.useCases.reduce((sum, uc) => 
                sum + (uc.benefits.reduce((bSum, b) => bSum + (b[`year_${year}`] || 0), 0)), 0
            );
            const yearCosts = this.state.costs.reduce((sum, c) => sum + (c[`year_${year}`] || 0), 0);
            cashFlows.push(yearBenefits - yearCosts);
        }
        
        const npv = this.calculateNPV(cashFlows, this.state.discountRate);
        
        // Calculate payback
        const initialInvestment = Math.abs(cashFlows[0]);
        const payback = this.calculatePayback(initialInvestment, cashFlows.slice(1));
        
        // Prioritize use cases
        const prioritized = this.state.useCases
            .map(uc => ({
                ...uc,
                priorityScore: uc.valueScore * uc.impact
            }))
            .sort((a, b) => b.priorityScore - a.priorityScore);
        
        return {
            totalBenefits,
            totalCosts,
            netBenefit,
            roi,
            npv,
            payback,
            prioritized
        };
    }

    calculateNPV(cashFlows, rate) {
        return cashFlows.reduce((npv, cf, year) => 
            npv + cf / Math.pow(1 + rate, year), 0
        );
    }

    calculatePayback(initial, annualCashFlows) {
        let cumulative = -initial;
        for (let year = 0; year < annualCashFlows.length; year++) {
            cumulative += annualCashFlows[year];
            if (cumulative >= 0) {
                const previousCumulative = cumulative - annualCashFlows[year];
                const fraction = Math.abs(previousCumulative) / annualCashFlows[year];
                return year + fraction;
            }
        }
        return null;
    }

    displayAnalysis(analysis) {
        let message = `✨ **Analysis Complete!**\n\n`;
        message += `📊 **Financial Summary**\n`;
        message += `• Total Benefits (5-year): $${this.formatCurrency(analysis.totalBenefits)}\n`;
        message += `• Total Investment: $${this.formatCurrency(analysis.totalCosts)}\n`;
        message += `• Net Benefit: $${this.formatCurrency(analysis.netBenefit)}\n`;
        message += `• ROI: ${analysis.roi.toFixed(1)}%\n`;
        message += `• NPV: $${this.formatCurrency(analysis.npv)}\n`;
        
        if (analysis.payback) {
            const years = Math.floor(analysis.payback);
            const months = Math.round((analysis.payback - years) * 12);
            message += `• Payback: ${years} years, ${months} months\n\n`;
        } else {
            message += `• Payback: Never\n\n`;
        }
        
        message += `🎯 **Use Case Prioritization**\n\n`;
        analysis.prioritized.forEach((uc, idx) => {
            const icon = idx === 0 ? '🚀' : idx === 1 ? '✅' : '⚠️';
            const rec = idx === 0 ? 'MUST DO' : idx === 1 ? 'SHOULD DO' : 'CONSIDER';
            message += `${idx + 1}. ${uc.title}\n`;
            message += `   ${icon} ${rec}\n`;
            message += `   Value: $${this.formatCurrency(uc.totalBenefit)} | Effort: ${uc.effort}\n\n`;
        });
        
        this.addBotMessage(message);
        
        setTimeout(() => {
            this.addBotMessage('Would you like AI-powered insights and recommendations?');
            this.showQuickReplies([
                { label: '🤖 Get AI Insights', value: 'ai_insights' },
                { label: '📄 View Report Only', value: 'report' },
                { label: '📥 Export JSON', value: 'json' },
                { label: '🔄 Start Over', value: 'reset' }
            ]);
            this.state.stage = 'final_actions';
            this.state.analysis = analysis;
        }, 500);
    }

    async getAIInsights(analysis) {
        // Check if provider is configured
        if (!this.state.aiProvider) {
            this.addBotMessage('🤖 Please select an AI provider first.');
            this.showQuickReplies([
                { label: '🔵 Anthropic Claude', value: 'setup_anthropic' },
                { label: '🟢 Microsoft Copilot Studio', value: 'setup_copilot' },
                { label: '⏭️ Skip AI Insights', value: 'report' }
            ]);
            this.state.stage = 'ai_provider_menu';
            return;
        }

        const providerName = this.state.aiProvider === 'anthropic' ? 'Claude AI' : 'Microsoft Copilot Studio';
        this.addBotMessage(`🤖 Analyzing your data with ${providerName}... This may take a moment.`);
        
        try {
            const prompt = this.buildAnalysisPrompt(analysis);
            let insights;
            
            if (this.state.aiProvider === 'anthropic') {
                insights = await this.callAnthropicAPI(prompt);
            } else if (this.state.aiProvider === 'copilot') {
                insights = await this.callCopilotStudioAPI(prompt);
            }
            
            this.addBotMessage(
                '✨ **AI-Powered Insights**\n\n' + insights
            );
            
            setTimeout(() => {
                this.addBotMessage('Would you like to do anything else?');
                this.showQuickReplies([
                    { label: '📄 View Full Report', value: 'report' },
                    { label: '📥 Export JSON', value: 'json' },
                    { label: '🔄 Start Over', value: 'reset' }
                ]);
                this.state.stage = 'final_actions';
            }, 500);
            
        } catch (error) {
            this.addBotMessage(
                '❌ Error getting AI insights: ' + error.message + '\n\n' +
                'Please check your configuration and try again, or continue without AI insights.'
            );
            this.showQuickReplies([
                { label: '🔑 Update Configuration', value: 'manage_keys' },
                { label: '📄 View Report', value: 'report' },
                { label: '🔄 Start Over', value: 'reset' }
            ]);
            this.state.stage = 'final_actions';
        }
    }

    buildAnalysisPrompt(analysis) {
        const useCasesDetails = this.state.useCases.map(uc => {
            return `\n### ${uc.title}\n` +
                   `- Problem: ${uc.problem}\n` +
                   `- Impact Level: ${uc.impact}/5\n` +
                   `- Effort: ${uc.effort} points\n` +
                   `- Benefits: ${uc.benefits.map(b => `${b.category}: $${b.amount}/year`).join(', ')}\n` +
                   `- Total 5-year benefit: $${uc.totalBenefit.toLocaleString()}`;
        }).join('\n');

        return `You are an expert AI strategy consultant with deep knowledge of the Microsoft AI Frontier "Vision to Value" delivery methodology. This proven framework transforms AI initiatives from executive vision to measurable business value through structured phases.

**AI DELIVERY METHODOLOGY CONTEXT:**

The Microsoft AI Frontier methodology follows these key phases:
1. **Business Envisioning** - Align stakeholders, define vision, identify high-value use cases
2. **Mobilization** - Establish governance, form teams, create project charter
3. **Hackathons & Prototyping** - Rapid experimentation, proof of concept development
4. **Setup Platform** - Azure infrastructure, MLOps foundation, security framework
5. **Build Phase** - Model development, feature engineering, iterative improvement
6. **Integrate** - API development, system integration, data pipelines
7. **Test & Evaluate** - Model validation, bias testing, performance benchmarking
8. **Prepare & Deploy** - Staging deployment, monitoring setup, rollout planning
9. **Operate & Care** - Production monitoring, continuous improvement, scaling

**VALUE ANALYSIS BEST PRACTICES:**
- Prioritize use cases by Value Score (Benefit/Effort ratio) and Business Impact
- Consider technical feasibility, data readiness, and organizational change management
- Plan for 3-6 month MVP delivery cycles for each use case
- Allocate 20-30% of effort for MLOps, governance, and platform setup
- Use story point estimation: 1 point = 1 person-day typically
- Factor in Azure infrastructure costs (compute, storage, AI services)
- Build executive buy-in with clear ROI and quick wins

**RISK MITIGATION STRATEGIES:**
- Data Quality: Allocate 40% of effort to data preparation
- Skills Gap: Plan for upskilling or external expertise
- Change Management: Executive sponsorship and user adoption programs
- Technical Debt: Invest in MLOps from day one
- Compliance: Embed governance, ethics, and security throughout

---

**PROJECT ANALYSIS:**

**Project:** ${this.state.projectName}

**Financial Summary:**
- Total 5-Year Benefits: $${this.formatCurrency(analysis.totalBenefits)}
- Total Investment: $${this.formatCurrency(analysis.totalCosts)}
- Net Benefit: $${this.formatCurrency(analysis.netBenefit)}
- ROI: ${analysis.roi.toFixed(1)}%
- NPV (10% discount): $${this.formatCurrency(analysis.npv)}
- Payback Period: ${analysis.payback ? `${Math.floor(analysis.payback)} years, ${Math.round((analysis.payback - Math.floor(analysis.payback)) * 12)} months` : 'Never'}

**Use Cases (Prioritized):**${useCasesDetails}

**Prioritization Scores:**
${analysis.prioritized.map((uc, idx) => `${idx + 1}. ${uc.title}: ${uc.priorityScore.toFixed(1)}`).join('\n')}

---

**ANALYSIS REQUEST:**

Using your expertise in the AI Delivery Methodology and the project data above, provide:

1. **Strategic Assessment** (2-3 sentences)
   - Overall viability and alignment with Microsoft AI Frontier best practices
   - Strategic fit for the organization

2. **Key Strengths** (3-4 bullet points)
   - What makes this compelling from a business and technical perspective
   - Alignment with proven delivery patterns

3. **Key Risks & Mitigations** (3-4 bullet points)
   - What could go wrong based on methodology experience
   - Specific mitigation strategies from the AI Delivery playbook

4. **Delivery Recommendations** (3-4 bullet points)
   - Specific actionable next steps aligned to methodology phases
   - Resource allocation and timeline guidance
   - Platform and governance considerations

5. **Implementation Sequence**
   - Recommended order for use cases based on value, risk, and dependencies
   - Suggested phase mapping (which methodology phases apply to each use case)
   - Timeline estimates based on effort and complexity

Keep your response concise, actionable, and focused on executive decision-making. Use clear formatting with markdown headings and bullets. Reference specific methodology phases where relevant.`;
    }

    async callAnthropicAPI(prompt) {
        try {
            const response = await fetch('https://api.anthropic.com/v1/messages', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'x-api-key': this.state.anthropicApiKey,
                    'anthropic-version': '2023-06-01'
                },
                body: JSON.stringify({
                    model: 'claude-3-5-sonnet-20241022',
                    max_tokens: 2000,
                    messages: [{
                        role: 'user',
                        content: prompt
                    }]
                })
            });

            if (!response.ok) {
                const error = await response.json();
                throw new Error(error.error?.message || `API request failed with status ${response.status}`);
            }

            const data = await response.json();
            return data.content[0].text;
        } catch (error) {
            // Check if it's a CORS error (common when calling Anthropic API directly from browser)
            if (error.message === 'Failed to fetch' || error.name === 'TypeError') {
                throw new Error(
                    'Browser CORS restriction detected. ' +
                    'The Anthropic API cannot be called directly from browsers due to security policies. ' +
                    'To use AI mode, you need a backend proxy server. ' +
                    'For now, please use Structured Mode which works entirely in your browser.'
                );
            }
            throw error;
        }
    }

    async callCopilotStudioAPI(prompt) {
        // Copilot Studio uses Direct Line API protocol
        const response = await fetch(this.state.copilotEndpoint, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                type: 'message',
                from: { id: 'user' },
                text: prompt
            })
        });

        if (!response.ok) {
            const errorText = await response.text();
            throw new Error(`Copilot Studio API error: ${response.status} - ${errorText}`);
        }

        const data = await response.json();
        
        // Handle Copilot Studio response format
        if (data.activities && data.activities.length > 0) {
            // Get the last bot response
            const botMessages = data.activities.filter(a => a.from.role === 'bot');
            if (botMessages.length > 0) {
                return botMessages[botMessages.length - 1].text;
            }
        }
        
        // Fallback for different response formats
        if (data.text) return data.text;
        if (data.response) return data.response;
        
        throw new Error('Unexpected response format from Copilot Studio');
    }

    saveApiKey(apiKey) {
        this.state.anthropicApiKey = apiKey;
        localStorage.setItem('anthropic_api_key', apiKey);
        this.addBotMessage(
            '✅ API key saved locally! Now let me analyze your project...'
        );
        // Trigger AI insights with the saved key
        setTimeout(() => {
            this.getAIInsights(this.state.analysis);
        }, 500);
    }

    showDetailedReport() {
        const analysis = this.state.analysis;
        let report = `📊 **Detailed Analysis Report**\n\n`;
        report += `**Project:** ${this.state.projectName}\n\n`;
        
        report += `**Financial Summary**\n`;
        report += `• Total 5-Year Benefits: $${this.formatCurrency(analysis.totalBenefits)}\n`;
        report += `• Total Investment: $${this.formatCurrency(analysis.totalCosts)}\n`;
        report += `• Net Benefit: $${this.formatCurrency(analysis.netBenefit)}\n`;
        report += `• ROI: ${analysis.roi.toFixed(1)}%\n`;
        report += `• NPV: $${this.formatCurrency(analysis.npv)}\n`;
        
        if (analysis.payback) {
            const years = Math.floor(analysis.payback);
            const months = Math.round((analysis.payback - years) * 12);
            report += `• Payback: ${years} years, ${months} months\n\n`;
        } else {
            report += `• Payback: Never\n\n`;
        }
        
        report += `**Use Cases Detail**\n`;
        this.state.useCases.forEach((uc, idx) => {
            report += `\n${idx + 1}. **${uc.title}**\n`;
            report += `   Problem: ${uc.problem}\n`;
            report += `   Impact: ${uc.impact}/5 | Effort: ${uc.effort} points\n`;
            report += `   Total Benefit: $${this.formatCurrency(uc.totalBenefit)}\n`;
        });
        
        this.addBotMessage(report);
        
        setTimeout(() => {
            this.showQuickReplies([
                { label: '📥 Export JSON', value: 'json' },
                { label: '🔄 Start Over', value: 'reset' }
            ]);
        }, 500);
    }

    exportJSON() {
        const exportData = {
            projectName: this.state.projectName,
            analysis: this.state.analysis,
            useCases: this.state.useCases,
            costs: this.state.costs,
            generatedAt: new Date().toISOString()
        };
        
        const dataStr = JSON.stringify(exportData, null, 2);
        const dataBlob = new Blob([dataStr], { type: 'application/json' });
        const url = URL.createObjectURL(dataBlob);
        const link = document.createElement('a');
        link.href = url;
        link.download = `${this.state.projectName.replace(/\s+/g, '-')}-analysis.json`;
        link.click();
        
        this.addBotMessage('✅ Analysis exported to JSON file!');
        
        setTimeout(() => {
            this.showQuickReplies([
                { label: '🔄 Start New Analysis', value: 'reset' }
            ]);
        }, 500);
    }

    addBotMessage(text, callback, delay = 300) {
        setTimeout(() => {
            const messageDiv = document.createElement('div');
            messageDiv.className = 'message bot-message';
            messageDiv.innerHTML = `
                <div class="message-avatar">🤖</div>
                <div class="message-content">${this.formatMessage(text)}</div>
            `;
            this.chatMessages.appendChild(messageDiv);
            this.scrollToBottom();
            
            if (callback) {
                setTimeout(callback, delay);
            }
        }, delay);
    }

    addUserMessage(text) {
        const messageDiv = document.createElement('div');
        messageDiv.className = 'message user-message';
        messageDiv.innerHTML = `
            <div class="message-content">${this.escapeHtml(text)}</div>
            <div class="message-avatar">👤</div>
        `;
        this.chatMessages.appendChild(messageDiv);
        this.clearQuickReplies();
        this.scrollToBottom();
    }

    showQuickReplies(replies) {
        console.log('💬 Showing quick replies:', replies.length, 'buttons');
        this.clearQuickReplies();
        replies.forEach((reply, index) => {
            const btn = document.createElement('button');
            btn.className = 'quick-reply-btn';
            btn.textContent = reply.label;
            btn.addEventListener('click', () => {
                console.log(`🖱️ Quick reply clicked: ${reply.label} (value: ${reply.value})`);
                this.addUserMessage(reply.label);
                this.processInput(reply.value);
            });
            this.quickReplies.appendChild(btn);
            console.log(`  ✅ Button ${index + 1}: ${reply.label}`);
        });
    }

    clearQuickReplies() {
        this.quickReplies.innerHTML = '';
    }

    formatMessage(text) {
        // Convert markdown-style formatting
        text = text.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>');
        text = text.replace(/\n/g, '<br>');
        return text;
    }

    formatCurrency(value) {
        return value.toLocaleString('en-US', { minimumFractionDigits: 0, maximumFractionDigits: 0 });
    }

    escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    scrollToBottom() {
        setTimeout(() => {
            this.chatMessages.scrollTop = this.chatMessages.scrollHeight;
        }, 100);
    }

    reset() {
        if (confirm('Are you sure you want to start a new analysis? All current data will be lost.')) {
            this.state = {
                stage: 'welcome',
                projectName: '',
                useCases: [],
                currentUseCase: {},
                costs: [],
                currentCost: {},
                discountRate: 0.10,
                anthropicApiKey: localStorage.getItem('anthropic_api_key') || '',
                copilotEndpoint: localStorage.getItem('copilot_endpoint') || '',
                aiProvider: localStorage.getItem('ai_provider') || '',
                conversationHistory: [],
                conversationalMode: true
            };
            this.messages = [];
            this.chatMessages.innerHTML = '';
            this.clearQuickReplies();
            this.showWelcome();
        }
    }
}

// Initialize chatbot when page loads
document.addEventListener('DOMContentLoaded', () => {
    console.log('🚀 DOM Content Loaded - Initializing chatbot...');
    try {
        window.chatbot = new ValueAnalysisChatbot();
        console.log('✅ Chatbot initialized successfully');
    } catch (error) {
        console.error('❌ Failed to initialize chatbot:', error);
        alert('Failed to initialize chatbot. Please refresh the page. Error: ' + error.message);
    }
});

// Fallback initialization if DOMContentLoaded already fired
if (document.readyState === 'complete' || document.readyState === 'interactive') {
    console.log('🔄 DOM already loaded, initializing immediately...');
    setTimeout(() => {
        if (!window.chatbot) {
            try {
                window.chatbot = new ValueAnalysisChatbot();
                console.log('✅ Chatbot initialized via fallback');
            } catch (error) {
                console.error('❌ Fallback initialization failed:', error);
            }
        }
    }, 100);
}
