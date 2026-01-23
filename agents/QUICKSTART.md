# Value Analysis Agent - Quick Start Guide

## What is this?

The **Value Analysis Agent** helps you quantify the business value of AI projects. It's an interactive Python tool that guides you through:

1. **Adding AI use cases** with effort estimates
2. **Quantifying benefits** across 5 years
3. **Tracking costs** (development, infrastructure, operations)
4. **Calculating ROI** (NPV, payback period, IRR)
5. **Prioritizing use cases** by value vs. effort
6. **Conducting Five Whys** root cause analysis

---

## Quick Start (5 Minutes)

### 1. Open Terminal
```powershell
cd c:\Users\anwasita\AI-Delivery-Methodology\agents
```

### 2. Run Interactive Mode
```powershell
python value_analysis_agent.py
```

### 3. Follow the Menu
```
1. Add Use Case         ← Start here
2. Conduct Five Whys    ← Root cause analysis
3. Add Cost Item        ← Track investments
4. View Prioritization  ← See rankings
5. Generate Report      ← Full analysis
```

---

## Example: Quick Win Use Case

Let's add a simple chatbot use case:

**Menu Option 1: Add Use Case**

```
Use Case ID: UC-001
Title: Customer Service Chatbot
Description: AI chatbot for tier-1 support
Business Problem: 85% of inquiries are repetitive
Impact Level: 2 (HIGH)
Effort Estimate: 25

Add financial benefits? y

Benefit Category: 2 (Cost Reduction)
Benefit description: Labor cost savings from automation
Year 1 benefit ($): 400000
Year 2 benefit ($): 450000
Year 3 benefit ($): 500000
Year 4 benefit ($): 550000
Year 5 benefit ($): 600000
Confidence level: 0.85
```

**Result:**
- Total 5-year benefit: $2,500,000
- Value score: $100,000 per effort point
- Priority: HIGH

---

## Run Pre-Built Examples

### Option 1: Financial Services Example
```powershell
python example_usage.py
```
Select: `1` for Fraud Detection scenario

### Option 2: Retail Example
Select: `2` for Demand Forecasting + Recommendations

### Option 3: Manufacturing Example
Select: `3` for Predictive Maintenance

---

## What You Get

### 1. Prioritization Table
```
Rank  Use Case                    Priority   Value         Effort
1     Customer Chatbot            85.3       $2,500,000    29
      🚀 MUST DO - High value, high impact

2     Fraud Detection             62.1       $1,800,000    29
      ✅ SHOULD DO - Good value proposition
```

### 2. Value Matrix
```
🎯 QUICK WINS (High Value, Low Effort):
   • Customer Service Chatbot - Value: $2,500,000, Effort: 29

📈 STRATEGIC (High Value, High Effort):
   • Predictive Maintenance - Value: $1,800,000, Effort: 89

❌ AVOID (Low Value, High Effort):
   • Legacy Migration - Value: $220,000, Effort: 144
```

### 3. Financial Summary
```
Total Expected Benefits (5-year): $8,750,000
Total Investment Required: $2,100,000
Net Benefit: $6,650,000
ROI: 316.7%
Payback Period: 1.2 years
```

### 4. Export Options
- **JSON export** for integration with other tools
- **Text report** for stakeholder presentations
- **Full analysis** with recommendations

---

## When to Use This

### Use Case Identification Phase
- Business Envisioning Workshop
- Discovery sessions
- Hackathon planning

### Business Case Development
- Building financial justification
- Executive presentations
- Budget approvals

### Portfolio Management
- Prioritizing backlog
- Roadmap planning
- Resource allocation

### Benefit Tracking
- Quarterly reviews
- Value realization
- ROI validation

---

## Tips for Success

### 1. Start with Root Cause Analysis
Use **Five Whys** (Menu Option 2) before adding use cases to ensure you're solving the right problem.

### 2. Be Conservative
- Start with 70-85% confidence levels
- Use lower estimates for uncertain benefits
- Include all costs (don't forget change management!)

### 3. Validate with Stakeholders
- Review assumptions with Finance
- Confirm effort estimates with Tech Lead
- Validate benefits with Business Owners

### 4. Track Actuals
- Update quarterly with real data
- Adjust future projections
- Document lessons learned

---

## Integration with Methodology

This agent supports these methodology artifacts:

- **[Business Case Template](../templates/02-business-case.md)** - Section 3: Benefits Analysis
- **[Use Case Template](../templates/14-business-envisioning-use-case-template.md)** - Business Value section
- **[Presales Qualification](../templates/11-presales-qualification.md)** - Business Value scoring
- **[Executive Decision Memo](../templates/15-executive-decision-memo.md)** - Investment justification
- **[ROI Calculator](../calculators/roi-calculator.html)** - Web-based alternative

---

## Common Questions

**Q: Do I need Python experience?**  
A: No! The interactive mode guides you step-by-step. Just answer the questions.

**Q: Can I import existing data?**  
A: Currently manual entry only. Excel import coming soon. You can edit the JSON export and re-import.

**Q: How accurate are the calculations?**  
A: The math is precise. Accuracy depends on your input assumptions. Use confidence levels to adjust for uncertainty.

**Q: Can multiple people use this?**  
A: Currently single-user. Export JSON files to share. Collaborative version planned.

**Q: What if my use case never pays back?**  
A: The agent will show "Never" for payback period. Review if this is strategic (acceptable negative ROI) or should be deprioritized.

---

## Next Steps

1. **Try the examples**: Run `python example_usage.py`
2. **Add your own use case**: Run `python value_analysis_agent.py`
3. **Generate a report**: Use Menu Option 6
4. **Share with stakeholders**: Export JSON (Option 7) or TXT (Option 8)

---

## Need Help?

- **Documentation**: See [agents/README.md](README.md) for full guide
- **Templates**: Check [../templates/](../templates/) for integration examples
- **Methodology**: Review [../guides/01-business-envisioning-workshop-guide.md](../guides/01-business-envisioning-workshop-guide.md)

---

**Ready to quantify your AI value? Start now:**
```powershell
python value_analysis_agent.py
```
