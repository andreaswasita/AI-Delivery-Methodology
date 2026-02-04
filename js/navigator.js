/**
 * AI Delivery Methodology Navigator - JavaScript Logic
 * Extracted from methodology-navigator.html for easier maintenance
 * 
 * This file handles:
 * - Tab switching between Overview, Phases, Tools, etc.
 * - Loading and displaying phase details from phases.json
 * - Resource filtering/search functionality
 * - Global search across all content
 * 
 * Last updated: February 2026
 */

// Phase data will be loaded from phases.json
let phases = [];

// Searchable content index for global search
let searchIndex = [];

/**
 * Load phase data from JSON file
 * This separates content from code, allowing non-developers to edit phase data
 */
async function loadPhases() {
    try {
        const response = await fetch('data/phases.json');
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        phases = await response.json();
        console.log(`Loaded ${phases.length} phases successfully`);
        
        // If we're on the phases tab, show the first phase
        if (document.getElementById('phases').classList.contains('active')) {
            showPhaseDetails(0);
        }
    } catch (error) {
        console.error('Error loading phases:', error);
        // Show error message to user
        const container = document.getElementById('phase-details-container');
        if (container) {
            container.innerHTML = `
                <div class="error-message">
                    <h3>⚠️ Unable to load phase data</h3>
                    <p>Please ensure you're running this on a web server (not file://).</p>
                    <p>Run: <code>python -m http.server 8000</code> from the repository root.</p>
                </div>
            `;
        }
    }
}

/**
 * Switch between tabs (Overview, Phases, Tools, etc.)
 * @param {string} tabName - The ID of the tab to show
 * @param {Event} event - The click event (optional, for updating active state)
 */
function showTab(tabName, event) {
    // Hide all tabs
    const tabs = document.querySelectorAll('.tab-content');
    tabs.forEach(tab => tab.classList.remove('active'));

    // Show selected tab
    document.getElementById(tabName).classList.add('active');

    // Update nav tabs
    const navTabs = document.querySelectorAll('.nav-tab');
    navTabs.forEach(tab => {
        tab.classList.remove('active');
        tab.setAttribute('aria-selected', 'false');
    });
    
    // Handle both event parameter and inline onclick
    if (event && event.target) {
        event.target.classList.add('active');
        event.target.setAttribute('aria-selected', 'true');
    } else if (event && event.currentTarget) {
        event.currentTarget.classList.add('active');
        event.currentTarget.setAttribute('aria-selected', 'true');
    }

    // If phases tab, show first phase by default
    if (tabName === 'phases' && phases.length > 0) {
        showPhaseDetails(0);
    }
}

/**
 * Display details for a specific phase
 * @param {number} phaseNumber - The phase index (0-8)
 */
function showPhaseDetails(phaseNumber) {
    if (phases.length === 0) {
        console.warn('Phases not loaded yet');
        return;
    }

    const phase = phases[phaseNumber];
    if (!phase) {
        console.error(`Phase ${phaseNumber} not found`);
        return;
    }

    const container = document.getElementById('phase-details-container');

    // Update active phase in timeline
    const phaseItems = document.querySelectorAll('.phase-item');
    phaseItems.forEach(item => item.classList.remove('active'));
    if (phaseItems[phaseNumber]) {
        phaseItems[phaseNumber].classList.add('active');
    }

    // Generate phase details HTML
    const html = `
        <div class="phase-details">
            <h2>Phase ${phase.number}: ${phase.name}</h2>
            <div class="phase-meta">
                <div class="meta-item">
                    <div class="meta-icon">⏱️</div>
                    <div class="meta-text">
                        <span class="meta-label">Duration</span>
                        <span class="meta-value">${phase.duration}</span>
                    </div>
                </div>
                <div class="meta-item">
                    <div class="meta-icon">👥</div>
                    <div class="meta-text">
                        <span class="meta-label">Team Size</span>
                        <span class="meta-value">${phase.team}</span>
                    </div>
                </div>
            </div>

            <p style="font-size: 1.1em; margin-bottom: 25px; line-height: 1.8;">${phase.description}</p>

            <h3 style="margin-bottom: 15px;">🎯 Key Objectives</h3>
            <ul style="margin-left: 20px; margin-bottom: 25px;">
                ${phase.objectives.map(obj => `<li style="margin: 10px 0;">${obj}</li>`).join('')}
            </ul>

            <h3 style="margin-bottom: 15px;">📦 Key Deliverables</h3>
            <ul style="margin-left: 20px; margin-bottom: 25px;">
                ${phase.deliverables.map(del => `<li style="margin: 10px 0;">${del}</li>`).join('')}
            </ul>

            <h3 style="margin-bottom: 15px;">📚 Resources</h3>
            <div class="quick-links">
                ${generateResourceLinks(phase.resources)}
            </div>
        </div>
    `;

    container.innerHTML = html;
}

/**
 * Generate HTML for resource links based on available resources
 * @param {object} resources - The resources object from phase data
 * @returns {string} HTML string of resource links
 */
function generateResourceLinks(resources) {
    if (!resources) return '';

    // Define resource link mappings with icons and labels
    const resourceConfig = {
        checklist: { icon: '✅', label: 'Checklist', isPrimary: true },
        guide: { icon: '📖', label: 'Complete Guide' },
        day1ops: { icon: '🚀', label: 'Day 1 Operations' },
        hypercare: { icon: '🏥', label: 'Hypercare Guide' },
        valuetracker: { icon: '📊', label: 'Value Tracker' },
        workshop: { icon: '🎯', label: 'Workshop Guide' },
        templates: { icon: '📝', label: 'Templates' },
        template: { icon: '📝', label: 'Sprint Template' },
        charter: { icon: '📜', label: 'Project Charter' },
        businesscase: { icon: '💼', label: 'Business Case' },
        raci: { icon: '👥', label: 'RACI Matrix' },
        mlops: { icon: '🔄', label: 'MLOps Guide' },
        coe: { icon: '🏢', label: 'AI CoE Framework' },
        scaling: { icon: '📈', label: 'Scaling Patterns' },
        infrastructure: { icon: '🏗️', label: 'Infrastructure' },
        modelcard: { icon: '🎴', label: 'Model Card' },
        datasheet: { icon: '📋', label: 'Dataset Datasheet' },
        riskguide: { icon: '⚠️', label: 'Risk Management' },
        assessment: { icon: '🎯', label: 'Maturity Assessment' },
        calculator: { icon: '🧮', label: 'Calculator' },
        deploy: { icon: '🚀', label: 'Deploy to Azure', style: 'background: #107C10;' },
        evaluator: { icon: '🏆', label: 'Evaluator' },
        setup: { icon: '⚙️', label: 'Quick Setup' },
        datasets: { icon: '📊', label: 'Datasets' },
        snippets: { icon: '💡', label: 'Code Snippets' }
    };

    let links = [];

    for (const [key, url] of Object.entries(resources)) {
        if (url && resourceConfig[key]) {
            const config = resourceConfig[key];
            const btnClass = config.isPrimary ? 'quick-link-btn' : 'quick-link-btn secondary';
            const style = config.style ? ` style="${config.style}"` : '';
            links.push(`<a href="${url}" class="${btnClass}"${style}>${config.icon} ${config.label}</a>`);
        }
    }

    return links.join('\n                        ');
}

/**
 * Filter resources based on search input
 * Used in the Resources tab
 */
function filterResources() {
    const searchValue = document.getElementById('resourceSearch').value.toLowerCase();
    const resourceCards = document.querySelectorAll('#resourcesContainer .resource-card');

    resourceCards.forEach(card => {
        const text = card.textContent.toLowerCase();
        if (text.includes(searchValue)) {
            card.style.display = 'block';
        } else {
            card.style.display = 'none';
        }
    });
}

/**
 * Build search index from all content
 */
function buildSearchIndex() {
    searchIndex = [];
    
    // Index phases
    phases.forEach((phase, index) => {
        searchIndex.push({
            title: `Phase ${phase.number}: ${phase.name}`,
            description: phase.description,
            keywords: [phase.name, phase.duration, phase.team, ...phase.objectives, ...phase.deliverables].join(' '),
            category: 'Phase',
            action: () => {
                showTab('phases');
                setTimeout(() => showPhaseDetails(index), 100);
            }
        });
    });
    
    // Index calculators and tools
    const tools = [
        { title: 'ROI Calculator', description: 'Calculate NPV, ROI%, and payback period', url: 'calculators/roi-calculator.html', category: 'Calculator' },
        { title: 'Azure Cost Estimator', description: 'Estimate Azure infrastructure costs', url: 'calculators/azure-cost-estimator.html', category: 'Calculator' },
        { title: 'Effort Estimator', description: 'Convert story points to timeline', url: 'calculators/effort-estimator.html', category: 'Calculator' },
        { title: 'AI Maturity Assessment', description: '5-dimension 55-point assessment', url: 'calculators/ai-maturity-assessment.html', category: 'Assessment' },
        { title: 'Team Sizing Calculator', description: 'Calculate optimal team composition', url: 'calculators/team-sizer.html', category: 'Calculator' },
        { title: 'Value Analysis Chatbot', description: 'AI-powered use case discovery', url: 'calculators/value-analysis-chatbot.html', category: 'Tool' },
        { title: 'AI Academy Framework', description: 'Build internal AI training programs', url: 'calculators/ai-academy-framework.html', category: 'Framework' }
    ];
    
    tools.forEach(tool => {
        searchIndex.push({
            title: tool.title,
            description: tool.description,
            keywords: tool.title + ' ' + tool.description,
            category: tool.category,
            action: () => window.open(tool.url, '_blank')
        });
    });
    
    // Index checklists
    const checklists = [
        { title: 'Presales Discovery Checklist', phase: 'Phase 0', url: 'markdown-viewer.html?file=checklists/00-presales-discovery-checklist.md' },
        { title: 'Mobilisation Checklist', phase: 'Phase 1', url: 'markdown-viewer.html?file=checklists/01-mobilisation-checklist.md' },
        { title: 'Hackathons Checklist', phase: 'Phase 2', url: 'markdown-viewer.html?file=checklists/02-hackathons-checklist.md' },
        { title: 'Setup Platform Checklist', phase: 'Phase 3', url: 'markdown-viewer.html?file=checklists/03-setup-platform-checklist.md' },
        { title: 'Build Phase Checklist', phase: 'Phase 4', url: 'markdown-viewer.html?file=checklists/04-build-phase-checklist.md' },
        { title: 'Integrate Phase Checklist', phase: 'Phase 5', url: 'markdown-viewer.html?file=checklists/05-integrate-phase-checklist.md' },
        { title: 'Test & Evaluate Checklist', phase: 'Phase 6', url: 'markdown-viewer.html?file=checklists/06-test-evaluate-phase-checklist.md' },
        { title: 'Deploy Phase Checklist', phase: 'Phase 7', url: 'markdown-viewer.html?file=checklists/07-prepare-deploy-phase-checklist.md' },
        { title: 'Operate & Care Checklist', phase: 'Phase 8', url: 'markdown-viewer.html?file=checklists/08-operate-care-phase-checklist.md' },
        { title: 'Use Case Business Change Checklist', phase: 'Cross-Phase', url: 'markdown-viewer.html?file=checklists/use-case-business-change-checklist.md' }
    ];
    
    checklists.forEach(checklist => {
        searchIndex.push({
            title: checklist.title,
            description: checklist.phase,
            keywords: checklist.title + ' ' + checklist.phase + ' checklist',
            category: 'Checklist',
            action: () => window.open(checklist.url, '_blank')
        });
    });
    
    // Index guides
    const guides = [
        { title: 'Business Envisioning Workshop Guide', description: 'Plan and run effective envisioning workshops', url: 'guides/01-business-envisioning-workshop-guide.md' },
        { title: 'AI Maturity Assessment Guide', description: 'Assess organizational AI maturity', url: 'guides/99-ai-maturity-assessment-guide.md' },
        { title: 'AI Center of Excellence Framework', description: 'Build AI CoE capability', url: 'guides/91-ai-center-of-excellence-framework.md' },
        { title: 'AI Academy Framework', description: 'Internal AI training programs', url: 'markdown-viewer.html?file=guides/92-ai-academy-framework.md' },
        { title: 'Engagement Modes Framework', description: 'Different delivery approaches', url: 'guides/92-engagement-modes-framework.md' },
        { title: '3-Month Fast Track Guide', description: 'Accelerated delivery for mature orgs', url: 'guides/93-3-month-fast-track-guide.md' },
        { title: 'Story Points Estimation Guide', description: 'Estimate effort accurately', url: 'guides/94-story-points-estimation-guide.md' },
        { title: 'AI Scaling Patterns Guide', description: 'Scale AI across enterprise', url: 'guides/95-ai-scaling-patterns-guide.md' },
        { title: 'Model Risk Management Guide', description: 'Manage AI model risks', url: 'guides/96-ai-model-risk-management-guide.md' },
        { title: 'Executive Coaching Guide', description: 'Coach executives on AI', url: 'guides/90-executive-coaching-guide.md' }
    ];
    
    guides.forEach(guide => {
        searchIndex.push({
            title: guide.title,
            description: guide.description,
            keywords: guide.title + ' ' + guide.description + ' guide framework',
            category: 'Guide',
            action: () => window.open(guide.url, '_blank')
        });
    });
    
    // Index templates
    const templates = [
        { title: 'Business Case Template', description: 'Build financial justification', url: 'markdown-viewer.html?file=templates/02-business-case.md' },
        { title: 'Project Charter Template', description: 'Define project foundation', url: 'markdown-viewer.html?file=templates/01-project-charter.md' },
        { title: 'Use Case Template', description: 'Document AI use cases', url: 'markdown-viewer.html?file=templates/14-business-envisioning-use-case-template.md' },
        { title: 'Benefits Dependency Network', description: 'Map benefits relationships', url: 'markdown-viewer.html?file=templates/15-benefits-dependency-network.md' },
        { title: 'Process Change Analysis', description: 'Analyze business process changes', url: 'markdown-viewer.html?file=templates/16-business-process-change-analysis.md' },
        { title: 'Project Plan & Roadmap', description: 'Plan project timeline', url: 'markdown-viewer.html?file=templates/04-project-plan-roadmap.md' },
        { title: 'Risk Register', description: 'Track and manage risks', url: 'markdown-viewer.html?file=templates/05-risk-register.md' },
        { title: 'RACI Matrix', description: 'Define roles and responsibilities', url: 'markdown-viewer.html?file=templates/03-raci-matrix.md' }
    ];
    
    templates.forEach(template => {
        searchIndex.push({
            title: template.title,
            description: template.description,
            keywords: template.title + ' ' + template.description + ' template',
            category: 'Template',
            action: () => window.open(template.url, '_blank')
        });
    });
    
    // Index success stories
    const stories = [
        { title: 'Healthcare AI Success Story', description: '281% ROI - Medical imaging transformation', url: 'markdown-viewer.html?file=success-stories/case-study-healthcare-ai.md' },
        { title: 'Financial Fraud Detection', description: '1,203% ROI - Real-time fraud prevention', url: 'markdown-viewer.html?file=success-stories/case-study-financial-fraud-detection.md' },
        { title: 'Five Whys Analysis Impact', description: '43% higher success rate methodology', url: 'markdown-viewer.html?file=success-stories/five-whys-analysis-impact.md' }
    ];
    
    stories.forEach(story => {
        searchIndex.push({
            title: story.title,
            description: story.description,
            keywords: story.title + ' ' + story.description + ' success story case study',
            category: 'Success Story',
            action: () => window.open(story.url, '_blank')
        });
    });
    
    // Index hackathon resources
    const hackathons = [
        { title: 'Datasets for Hackathons', description: 'Sample datasets for AI prototyping', url: 'markdown-viewer.html?file=hackathons/datasets.md', keywords: 'datasets data hackathon sample training' },
        { title: 'Azure Dev Setup', description: 'Setup Azure environment for hackathons', url: 'markdown-viewer.html?file=hackathons/azure-dev-setup.md', keywords: 'azure setup environment configuration' },
        { title: 'Azure OpenAI Code Snippets', description: 'Code patterns for Azure OpenAI', url: 'markdown-viewer.html?file=hackathons/code-snippets/azure-openai-patterns.md', keywords: 'code snippets azure openai patterns examples' }
    ];
    
    hackathons.forEach(item => {
        searchIndex.push({
            title: item.title,
            description: item.description,
            keywords: item.keywords,
            category: 'Hackathon',
            action: () => window.open(item.url, '_blank')
        });
    });
    
    // Index industry use cases
    const industries = [
        { title: 'Financial Services Use Cases', description: 'Fraud detection, credit risk, trading AI', url: 'markdown-viewer.html?file=guides/industry-use-cases/financial-services-use-cases.md' },
        { title: 'Healthcare & Life Sciences Use Cases', description: 'Medical imaging, drug discovery, patient care', url: 'markdown-viewer.html?file=guides/industry-use-cases/healthcare-use-cases.md' },
        { title: 'Retail & Consumer Use Cases', description: 'Demand forecasting, personalization, inventory', url: 'markdown-viewer.html?file=guides/industry-use-cases/retail-use-cases.md' },
        { title: 'Energy & Mining Use Cases', description: 'Predictive maintenance, exploration, optimization', url: 'markdown-viewer.html?file=guides/industry-use-cases/energy-mining-use-cases.md' },
        { title: 'Public Sector Use Cases', description: 'Citizen services, infrastructure, compliance', url: 'markdown-viewer.html?file=guides/industry-use-cases/public-sector-use-cases.md' },
        { title: 'Defense & Security Use Cases', description: 'Intelligence, logistics, threat detection', url: 'markdown-viewer.html?file=guides/industry-use-cases/defense-use-cases.md' },
        { title: 'AI Workforce & Agent365', description: 'Document processing, customer handling, automation', url: 'markdown-viewer.html?file=guides/industry-use-cases/ai-workforce-agent365-use-case.md' }
    ];
    
    industries.forEach(industry => {
        searchIndex.push({
            title: industry.title,
            description: industry.description,
            keywords: industry.title + ' ' + industry.description + ' industry use case examples',
            category: 'Industry',
            action: () => window.open(industry.url, '_blank')
        });
    });
    
    // Index phase-specific guides
    const phaseGuides = [
        { title: 'Presales Discovery Activities', description: 'Discovery phase activities and qualification', url: 'markdown-viewer.html?file=guides/phases/00-presales-discovery-activities.md', phase: 0 },
        { title: 'Mobilisation Complete Guide', description: 'Project setup and team mobilisation', url: 'markdown-viewer.html?file=guides/phases/01-mobilisation-complete-guide.md', phase: 1 },
        { title: 'Hackathons Complete Guide', description: 'Run successful AI hackathons', url: 'markdown-viewer.html?file=guides/phases/02-hackathons-complete-guide.md', phase: 2 },
        { title: 'Setup Platform Complete Guide', description: 'Azure platform and MLOps setup', url: 'markdown-viewer.html?file=guides/phases/03-setup-platform-complete-guide.md', phase: 3 },
        { title: 'MLOps DevOps Complete Guide', description: 'MLOps and DevOps best practices', url: 'markdown-viewer.html?file=guides/phases/03-mlops-devops-complete-guide.md', phase: 3 },
        { title: 'Build Phase Complete Guide', description: 'Model development and application build', url: 'markdown-viewer.html?file=guides/phases/04-build-phase-complete-guide.md', phase: 4 },
        { title: 'Integrate Phase Complete Guide', description: 'System integration and APIs', url: 'markdown-viewer.html?file=guides/phases/05-integrate-phase-complete-guide.md', phase: 5 },
        { title: 'Test & Evaluate Complete Guide', description: 'Testing and model evaluation', url: 'markdown-viewer.html?file=guides/phases/06-test-evaluate-phase-complete-guide.md', phase: 6 },
        { title: 'Prepare & Deploy Complete Guide', description: 'Deployment preparation and go-live', url: 'markdown-viewer.html?file=guides/phases/07-prepare-deploy-phase-complete-guide.md', phase: 7 },
        { title: 'Operate & Care Complete Guide', description: 'Operations and continuous improvement', url: 'markdown-viewer.html?file=guides/phases/08-operate-care-phase-complete-guide.md', phase: 8 },
        { title: 'Day 1 Operations Runbook', description: 'Day 1 post-deployment operations', url: 'markdown-viewer.html?file=guides/phases/08-day1-operations-runbook.md', phase: 8 },
        { title: 'Hypercare Framework', description: 'Post-deployment hypercare support', url: 'markdown-viewer.html?file=guides/phases/08-hypercare-framework.md', phase: 8 }
    ];
    
    phaseGuides.forEach(guide => {
        searchIndex.push({
            title: guide.title,
            description: guide.description,
            keywords: guide.title + ' ' + guide.description + ' phase guide complete',
            category: 'Phase Guide',
            action: () => window.open(guide.url, '_blank')
        });
    });
    
    // Index additional frameworks
    const frameworks = [
        { title: 'Change Management AI Adoption', description: 'Organizational change for AI', url: 'markdown-viewer.html?file=guides/change-management-ai-adoption.md' },
        { title: 'AI Literacy Program Framework', description: 'Build AI literacy across organization', url: 'markdown-viewer.html?file=guides/ai-literacy-program-framework.md' },
        { title: 'AI Adoption Metrics Framework', description: 'Measure AI adoption success', url: 'markdown-viewer.html?file=guides/ai-adoption-metrics-framework.md' },
        { title: 'Program Governance Framework', description: 'AI program governance structure', url: 'markdown-viewer.html?file=guides/program-governance-framework.md' },
        { title: 'Planning & Execution How-To Guide', description: 'Plan and execute AI projects', url: 'markdown-viewer.html?file=guides/planning-execution-howto-guide.md' }
    ];
    
    frameworks.forEach(framework => {
        searchIndex.push({
            title: framework.title,
            description: framework.description,
            keywords: framework.title + ' ' + framework.description + ' framework guide',
            category: 'Framework',
            action: () => window.open(framework.url, '_blank')
        });
    });
    
    // Index additional templates
    const moreTemplates = [
        { title: 'Stakeholder Analysis Template', description: 'Analyze stakeholder interests and influence', url: 'markdown-viewer.html?file=templates/08-stakeholder-analysis.md' },
        { title: 'Business Requirements Document', description: 'Document business requirements', url: 'markdown-viewer.html?file=templates/09-business-requirements-document.md' },
        { title: 'Data Assessment Report', description: 'Assess data readiness and quality', url: 'markdown-viewer.html?file=templates/10-data-assessment-report.md' },
        { title: 'Presales Qualification Template', description: 'Qualify AI opportunities', url: 'markdown-viewer.html?file=templates/11-presales-qualification.md' },
        { title: 'Sprint Planning Template', description: 'Plan agile sprints', url: 'markdown-viewer.html?file=templates/12-sprint-planning-template.md' },
        { title: 'Business Envisioning Pre-Work', description: 'Prepare for envisioning workshop', url: 'markdown-viewer.html?file=templates/13-business-envisioning-pre-work.md' },
        { title: 'Executive Decision Memo', description: 'Executive decision documentation', url: 'markdown-viewer.html?file=templates/15-executive-decision-memo.md' },
        { title: 'Executive Readiness Assessment', description: 'Assess executive AI readiness', url: 'markdown-viewer.html?file=templates/16-executive-readiness-assessment.md' },
        { title: 'Model Card Template', description: 'Document ML model details', url: 'markdown-viewer.html?file=templates/17-model-card-template.md' },
        { title: 'Dataset Datasheet Template', description: 'Document dataset characteristics', url: 'markdown-viewer.html?file=templates/18-dataset-datasheet-template.md' },
        { title: 'OKRs Framework Template', description: 'Objectives and Key Results', url: 'markdown-viewer.html?file=templates/22-okrs-framework.md' },
        { title: 'AI Governance Blueprint', description: 'AI governance framework', url: 'markdown-viewer.html?file=templates/21-ai-governance-blueprint.md' }
    ];
    
    moreTemplates.forEach(template => {
        searchIndex.push({
            title: template.title,
            description: template.description,
            keywords: template.title + ' ' + template.description + ' template',
            category: 'Template',
            action: () => window.open(template.url, '_blank')
        });
    });
    
    // Index maturity framework
    const maturityFramework = [
        { title: 'AI Maturity Framework Overview', description: '5-dimension capability model', url: 'markdown-viewer.html?file=guides/maturity-framework/00-ai-maturity-framework-overview.md' },
        { title: 'Strategy & Leadership Dimension', description: 'AI strategy and leadership assessment', url: 'markdown-viewer.html?file=guides/maturity-framework/01-strategy-leadership-dimension.md' },
        { title: 'Data & Infrastructure Dimension', description: 'Data and infrastructure maturity', url: 'markdown-viewer.html?file=guides/maturity-framework/02-data-infrastructure-dimension.md' },
        { title: 'Technology & Operations Dimension', description: 'Technology and operations capability', url: 'markdown-viewer.html?file=guides/maturity-framework/03-technology-operations-dimension.md' },
        { title: 'Talent & Culture Dimension', description: 'People and culture assessment', url: 'markdown-viewer.html?file=guides/maturity-framework/04-talent-culture-dimension.md' },
        { title: 'Governance & Ethics Dimension', description: 'Governance and ethics maturity', url: 'markdown-viewer.html?file=guides/maturity-framework/05-governance-ethics-dimension.md' }
    ];
    
    maturityFramework.forEach(dimension => {
        searchIndex.push({
            title: dimension.title,
            description: dimension.description,
            keywords: dimension.title + ' ' + dimension.description + ' maturity assessment',
            category: 'Maturity',
            action: () => window.open(dimension.url, '_blank')
        });
    });
    
    // Index architecture and infrastructure
    const technical = [
        { title: 'Architecture Patterns Library', description: 'AI solution architecture patterns', url: 'markdown-viewer.html?file=architecture/README.md' },
        { title: 'Azure Infrastructure Setup', description: 'Production-ready Azure infrastructure', url: 'markdown-viewer.html?file=infrastructure/README.md' },
        { title: 'Microsoft Fabric Landing Zone', description: 'Fabric unified analytics platform', url: 'markdown-viewer.html?file=data/FABRIC-LANDING-ZONE.md' },
        { title: 'Python Value Analysis Agent', description: 'CLI tool for value analysis', url: 'markdown-viewer.html?file=agents/README.md' }
    ];
    
    technical.forEach(item => {
        searchIndex.push({
            title: item.title,
            description: item.description,
            keywords: item.title + ' ' + item.description + ' technical infrastructure',
            category: 'Technical',
            action: () => window.open(item.url, '_blank')
        });
    });
}

/**
 * Perform global search across all content
 */
function performGlobalSearch() {
    const searchInput = document.getElementById('globalSearch');
    const searchResults = document.getElementById('searchResults');
    const query = searchInput.value.toLowerCase().trim();
    
    // Clear results if query is too short
    if (query.length < 2) {
        searchResults.style.display = 'none';
        return;
    }
    
    // Search the index
    const results = searchIndex.filter(item => {
        const searchText = (item.title + ' ' + item.description + ' ' + item.keywords).toLowerCase();
        return searchText.includes(query);
    });
    
    // Display results
    if (results.length === 0) {
        searchResults.innerHTML = '<div class="search-result-item no-results">No results found</div>';
        searchResults.style.display = 'block';
        return;
    }
    
    // Limit to top 10 results
    const topResults = results.slice(0, 10);
    
    // Create result items with data attributes
    searchResults.innerHTML = topResults.map((result, index) => `
        <div class="search-result-item" data-result-index="${index}">
            <div class="search-result-category">${result.category}</div>
            <div class="search-result-title">${highlightMatch(result.title, query)}</div>
            <div class="search-result-description">${highlightMatch(result.description, query)}</div>
        </div>
    `).join('');
    
    // Attach click handlers to each result
    const resultItems = searchResults.querySelectorAll('.search-result-item[data-result-index]');
    resultItems.forEach((item, index) => {
        item.addEventListener('click', function() {
            // Execute the action for this result
            topResults[index].action();
            // Close search results
            searchResults.style.display = 'none';
            // Clear search input
            searchInput.value = '';
        });
    });
    
    searchResults.style.display = 'block';
}

/**
 * Highlight matching text in search results
 */
function highlightMatch(text, query) {
    if (!query || !text) return text;
    const regex = new RegExp(`(${escapeRegExp(query)})`, 'gi');
    return text.replace(regex, '<mark>$1</mark>');
}

/**
 * Escape special regex characters
 */
function escapeRegExp(string) {
    return string.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}

/**
 * Close search results when clicking outside
 */
document.addEventListener('click', function(event) {
    const searchContainer = document.querySelector('.global-search-container');
    const searchResults = document.getElementById('searchResults');
    
    if (searchContainer && !searchContainer.contains(event.target)) {
        searchResults.style.display = 'none';
    }
});

/**
 * Initialize the navigator on page load
 */
document.addEventListener('DOMContentLoaded', function() {
    // Load phase data from JSON
    loadPhases();
    
    // Build search index after a short delay (to ensure phases are loaded)
    setTimeout(() => {
        buildSearchIndex();
    }, 500);
    
    // Setup global search
    const searchInput = document.getElementById('globalSearch');
    if (searchInput) {
        searchInput.addEventListener('input', performGlobalSearch);
        searchInput.addEventListener('focus', function() {
            if (this.value.length >= 2) {
                performGlobalSearch();
            }
        });
    }
});
