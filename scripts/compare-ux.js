/**
 * UX Comparison Script for Methodology Navigator
 * Run this in browser console on both pages, then compare outputs
 * 
 * Usage:
 * 1. Open browser DevTools (F12)
 * 2. Go to Console tab
 * 3. Paste this entire script and press Enter
 * 4. Copy the JSON output
 * 5. Repeat on the other page
 * 6. Compare the two JSON outputs
 */

(function() {
    const report = {
        url: window.location.href,
        timestamp: new Date().toISOString(),
        tabs: [],
        links: [],
        buttons: [],
        phases: [],
        forms: []
    };

    // Extract all navigation tabs
    document.querySelectorAll('.nav-tab').forEach((tab, i) => {
        report.tabs.push({
            index: i,
            text: tab.textContent.trim(),
            hasOnclick: !!tab.onclick || tab.hasAttribute('onclick'),
            isActive: tab.classList.contains('active')
        });
    });

    // Extract all links
    document.querySelectorAll('a[href]').forEach((link, i) => {
        report.links.push({
            index: i,
            text: link.textContent.trim().substring(0, 50),
            href: link.getAttribute('href'),
            target: link.getAttribute('target') || '_self'
        });
    });

    // Extract all buttons (non-nav)
    document.querySelectorAll('button:not(.nav-tab), .quick-link-btn').forEach((btn, i) => {
        report.buttons.push({
            index: i,
            text: btn.textContent.trim().substring(0, 50),
            hasOnclick: !!btn.onclick || btn.hasAttribute('onclick'),
            href: btn.getAttribute('href') || null
        });
    });

    // Extract phase timeline items
    document.querySelectorAll('.phase-item').forEach((phase, i) => {
        report.phases.push({
            index: i,
            label: phase.querySelector('.phase-label')?.textContent.trim(),
            number: phase.querySelector('.phase-circle')?.textContent.trim(),
            hasOnclick: !!phase.onclick || phase.hasAttribute('onclick')
        });
    });

    // Extract form inputs
    document.querySelectorAll('input, select, textarea').forEach((input, i) => {
        report.forms.push({
            index: i,
            type: input.type || input.tagName.toLowerCase(),
            id: input.id,
            placeholder: input.placeholder || null
        });
    });

    // Summary
    report.summary = {
        totalTabs: report.tabs.length,
        totalLinks: report.links.length,
        totalButtons: report.buttons.length,
        totalPhases: report.phases.length,
        totalForms: report.forms.length
    };

    console.log('=== UX COMPARISON REPORT ===');
    console.log(JSON.stringify(report, null, 2));
    
    // Also create a quick visual summary
    console.table(report.summary);
    
    return report;
})();
