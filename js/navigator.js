/**
 * AI Delivery Methodology Navigator - JavaScript Logic
 * Extracted from methodology-navigator.html for easier maintenance
 * 
 * This file handles:
 * - Tab switching between Overview, Phases, Tools, etc.
 * - Loading and displaying phase details from phases.json
 * - Resource filtering/search functionality
 * 
 * Last updated: February 2026
 */

// Phase data will be loaded from phases.json
let phases = [];

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
 * Initialize the navigator on page load
 */
document.addEventListener('DOMContentLoaded', function() {
    // Load phase data from JSON
    loadPhases();
});
