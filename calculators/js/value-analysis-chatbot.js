// AI Value Analysis Chatbot
// Interactive conversational interface for value analysis

class ValueAnalysisChatbot {
    constructor() {
        this.state = {
            stage: 'welcome',
            projectName: '',
            useCases: [],
            currentUseCase: {},
            costs: [],
            currentCost: {},
            discountRate: 0.10
        };
        
        this.messages = [];
        this.init();
    }

    init() {
        this.chatMessages = document.getElementById('chatMessages');
        this.userInput = document.getElementById('userInput');
        this.sendBtn = document.getElementById('sendBtn');
        this.resetBtn = document.getElementById('resetBtn');
        this.quickReplies = document.getElementById('quickReplies');
        
        // Event listeners
        this.sendBtn.addEventListener('click', () => this.handleSend());
        this.userInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') this.handleSend();
        });
        this.resetBtn.addEventListener('click', () => this.reset());
        
        // Start conversation
        this.showWelcome();
    }

    showWelcome() {
        this.addBotMessage(
            "👋 Hi! I'm your AI Value Analysis Assistant. I'll help you analyze the business value of your AI initiatives.",
            () => {
                this.addBotMessage(
                    "I'll guide you through:\n\n" +
                    "• 📊 Quantifying business benefits\n" +
                    "• 💰 Calculating ROI and NPV\n" +
                    "• 🎯 Prioritizing use cases\n" +
                    "• 🔍 Conducting root cause analysis\n\n" +
                    "Let's get started! What's your project name?"
                );
            },
            500
        );
        this.state.stage = 'project_name';
    }

    handleSend() {
        const message = this.userInput.value.trim();
        if (!message) return;
        
        this.addUserMessage(message);
        this.userInput.value = '';
        
        // Process based on current stage
        this.processInput(message);
    }

    processInput(input) {
        const stage = this.state.stage;
        
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
        }
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
            this.addBotMessage('Would you like to view the detailed report or export the data?');
            this.showQuickReplies([
                { label: '📄 View Full Report', value: 'report' },
                { label: '📥 Export JSON', value: 'json' },
                { label: '🔄 Start Over', value: 'reset' }
            ]);
            this.state.stage = 'final_actions';
            this.state.analysis = analysis;
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
        this.clearQuickReplies();
        replies.forEach(reply => {
            const btn = document.createElement('button');
            btn.className = 'quick-reply-btn';
            btn.textContent = reply.label;
            btn.addEventListener('click', () => {
                this.addUserMessage(reply.label);
                this.processInput(reply.value);
            });
            this.quickReplies.appendChild(btn);
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
                discountRate: 0.10
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
    window.chatbot = new ValueAnalysisChatbot();
});
