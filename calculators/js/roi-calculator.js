// ROI Calculator JavaScript

document.getElementById('roiForm').addEventListener('submit', function(e) {
    e.preventDefault();
    calculateROI();
});

function calculateROI() {
    // Get inputs
    const initialCost = parseFloat(document.getElementById('initialCost').value) || 0;
    const dataPrep = parseFloat(document.getElementById('dataPrep').value) || 0;
    const changeManagement = parseFloat(document.getElementById('changeManagement').value) || 0;
    const infraCost = parseFloat(document.getElementById('infraCost').value) || 0;
    const maintenanceCost = parseFloat(document.getElementById('maintenanceCost').value) || 0;
    const licenseCost = parseFloat(document.getElementById('licenseCost').value) || 0;
    const costSavings = parseFloat(document.getElementById('costSavings').value) || 0;
    const revenueIncrease = parseFloat(document.getElementById('revenueIncrease').value) || 0;
    const riskReduction = parseFloat(document.getElementById('riskReduction').value) || 0;
    const benefitGrowth = parseFloat(document.getElementById('benefitGrowth').value) / 100 || 0;
    const discountRate = parseFloat(document.getElementById('discountRate').value) / 100 || 0;
    const timeHorizon = parseInt(document.getElementById('timeHorizon').value) || 5;

    // Calculate total initial investment
    const totalInitialInvestment = initialCost + dataPrep + changeManagement;
    
    // Calculate annual ongoing costs
    const annualCost = infraCost + maintenanceCost + licenseCost;
    
    // Calculate initial annual benefits
    const initialAnnualBenefit = costSavings + revenueIncrease + riskReduction;

    // Calculate year-by-year cash flows
    let cashFlows = [];
    let cumulativeCashFlow = -totalInitialInvestment;
    let paybackYear = null;
    let npv = -totalInitialInvestment;

    for (let year = 1; year <= timeHorizon; year++) {
        const annualBenefit = initialAnnualBenefit * Math.pow(1 + benefitGrowth, year - 1);
        const netCashFlow = annualBenefit - annualCost;
        const discountedCashFlow = netCashFlow / Math.pow(1 + discountRate, year);
        
        cumulativeCashFlow += netCashFlow;
        npv += discountedCashFlow;

        cashFlows.push({
            year: year,
            benefit: annualBenefit,
            cost: annualCost,
            netCashFlow: netCashFlow,
            discountedCashFlow: discountedCashFlow,
            cumulativeCashFlow: cumulativeCashFlow
        });

        // Calculate payback period
        if (paybackYear === null && cumulativeCashFlow >= 0) {
            const previousCumulative = cumulativeCashFlow - netCashFlow;
            const fractionOfYear = Math.abs(previousCumulative) / netCashFlow;
            paybackYear = year - 1 + fractionOfYear;
        }
    }

    // Calculate ROI
    const totalBenefits = cashFlows.reduce((sum, cf) => sum + cf.benefit, 0);
    const totalCosts = totalInitialInvestment + (annualCost * timeHorizon);
    const roi = ((totalBenefits - totalCosts) / totalCosts) * 100;

    // Display results
    displayResults(npv, roi, paybackYear, cashFlows, totalInitialInvestment);
}

function displayResults(npv, roi, paybackYear, cashFlows, initialInvestment) {
    // Show results section
    document.getElementById('results').style.display = 'block';
    
    // Scroll to results
    document.getElementById('results').scrollIntoView({ behavior: 'smooth' });

    // NPV
    const npvElement = document.getElementById('npvResult');
    npvElement.textContent = formatCurrency(npv);
    npvElement.className = 'result-value ' + (npv > 0 ? 'result-positive' : 'result-negative');
    
    const npvInterpretation = document.getElementById('npvInterpretation');
    if (npv > 0) {
        npvInterpretation.innerHTML = `✅ <strong>Positive NPV:</strong> This project is expected to create value. The project generates ${formatCurrency(npv)} more than the initial investment after accounting for the time value of money.`;
    } else if (npv < 0) {
        npvInterpretation.innerHTML = `❌ <strong>Negative NPV:</strong> This project may destroy value. The project returns ${formatCurrency(Math.abs(npv))} less than the initial investment.`;
    } else {
        npvInterpretation.innerHTML = `⚠️ <strong>Break-even:</strong> This project breaks even, neither creating nor destroying value.`;
    }

    // ROI
    const roiElement = document.getElementById('roiResult');
    roiElement.textContent = roi.toFixed(2) + '%';
    roiElement.className = 'result-value ' + (roi > 0 ? 'result-positive' : (roi < 0 ? 'result-negative' : 'result-warning'));
    
    const roiInterpretation = document.getElementById('roiInterpretation');
    if (roi > 100) {
        roiInterpretation.innerHTML = `🚀 <strong>Excellent ROI:</strong> For every dollar invested, you'll get ${(roi / 100).toFixed(2)} dollars back. This is a highly attractive investment.`;
    } else if (roi > 50) {
        roiInterpretation.innerHTML = `✅ <strong>Good ROI:</strong> The project returns ${roi.toFixed(1)}% on investment, which is a solid return.`;
    } else if (roi > 0) {
        roiInterpretation.innerHTML = `⚠️ <strong>Modest ROI:</strong> The project is profitable but returns only ${roi.toFixed(1)}%. Consider if this meets your hurdle rate.`;
    } else {
        roiInterpretation.innerHTML = `❌ <strong>Negative ROI:</strong> The project is expected to lose ${Math.abs(roi).toFixed(1)}% of the investment.`;
    }

    // Payback Period
    const paybackElement = document.getElementById('paybackResult');
    const paybackInterpretation = document.getElementById('paybackInterpretation');
    
    if (paybackYear !== null) {
        const years = Math.floor(paybackYear);
        const months = Math.round((paybackYear - years) * 12);
        paybackElement.textContent = `${years} years, ${months} months`;
        paybackElement.className = 'result-value ' + (paybackYear <= 2 ? 'result-positive' : (paybackYear <= 3 ? 'result-warning' : 'result-negative'));
        
        if (paybackYear <= 2) {
            paybackInterpretation.innerHTML = `🚀 <strong>Fast Payback:</strong> You'll recover your initial investment quickly, reducing financial risk.`;
        } else if (paybackYear <= 3) {
            paybackInterpretation.innerHTML = `✅ <strong>Reasonable Payback:</strong> Investment recovery timeline is acceptable for most organizations.`;
        } else {
            paybackInterpretation.innerHTML = `⚠️ <strong>Long Payback:</strong> It will take over 3 years to recover the initial investment. Ensure the project has executive sponsorship for long-term commitment.`;
        }
    } else {
        paybackElement.textContent = 'Never';
        paybackElement.className = 'result-value result-negative';
        paybackInterpretation.innerHTML = `❌ <strong>No Payback:</strong> The project does not generate enough benefits to recover the initial investment within the time horizon.`;
    }

    // Summary Table
    const summaryTable = document.getElementById('summaryTable');
    let tableHTML = `
        <table style="width: 100%; border-collapse: collapse; margin-top: 15px;">
            <thead>
                <tr style="background-color: #f3f2f1; border-bottom: 2px solid #d2d0ce;">
                    <th style="padding: 10px; text-align: left;">Year</th>
                    <th style="padding: 10px; text-align: right;">Benefits</th>
                    <th style="padding: 10px; text-align: right;">Costs</th>
                    <th style="padding: 10px; text-align: right;">Net Cash Flow</th>
                    <th style="padding: 10px; text-align: right;">Cumulative</th>
                </tr>
            </thead>
            <tbody>
                <tr style="border-bottom: 1px solid #d2d0ce;">
                    <td style="padding: 10px;">Year 0</td>
                    <td style="padding: 10px; text-align: right;">-</td>
                    <td style="padding: 10px; text-align: right;">${formatCurrency(initialInvestment)}</td>
                    <td style="padding: 10px; text-align: right; color: #d13438;">-${formatCurrency(initialInvestment)}</td>
                    <td style="padding: 10px; text-align: right; color: #d13438;">-${formatCurrency(initialInvestment)}</td>
                </tr>
    `;

    cashFlows.forEach(cf => {
        const netColor = cf.netCashFlow >= 0 ? '#13a10e' : '#d13438';
        const cumColor = cf.cumulativeCashFlow >= 0 ? '#13a10e' : '#d13438';
        tableHTML += `
                <tr style="border-bottom: 1px solid #d2d0ce;">
                    <td style="padding: 10px;">Year ${cf.year}</td>
                    <td style="padding: 10px; text-align: right;">${formatCurrency(cf.benefit)}</td>
                    <td style="padding: 10px; text-align: right;">${formatCurrency(cf.cost)}</td>
                    <td style="padding: 10px; text-align: right; color: ${netColor};">${formatCurrency(cf.netCashFlow)}</td>
                    <td style="padding: 10px; text-align: right; color: ${cumColor};">${formatCurrency(cf.cumulativeCashFlow)}</td>
                </tr>
        `;
    });

    tableHTML += `
            </tbody>
        </table>
    `;
    
    summaryTable.innerHTML = tableHTML;
}

function formatCurrency(value) {
    return new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD',
        minimumFractionDigits: 0,
        maximumFractionDigits: 0
    }).format(value);
}

function copyResults() {
    const npv = document.getElementById('npvResult').textContent;
    const roi = document.getElementById('roiResult').textContent;
    const payback = document.getElementById('paybackResult').textContent;
    
    const text = `AI Project ROI Analysis Results\n\n` +
                 `Net Present Value (NPV): ${npv}\n` +
                 `Return on Investment (ROI): ${roi}\n` +
                 `Payback Period: ${payback}\n\n` +
                 `Generated by AI Delivery Methodology ROI Calculator\n` +
                 `https://github.com/andreaswasita/AI-Delivery-Methodology`;
    
    navigator.clipboard.writeText(text).then(() => {
        alert('Results copied to clipboard!');
    });
}
