# ROI & Financial Analysis Module
## Shared Component for All AI Project Financial Calculations

**Purpose**: Central repository for ROI calculation formulas, tables, and methodologies  
**Use In**: Business cases, use case templates, executive memos, workshop materials  
**Version**: 1.0  
**Last Updated**: January 13, 2026

---

## Quick Links

- 🧮 **[Interactive ROI Calculator](https://andreaswasita.github.io/AI-Delivery-Methodology/)** - Automated calculations
- 📊 **Use This Module In**: Business cases, executive memos, use case evaluations
- 📖 **Related**: [Risk Library](./risk-library.md) | [Stakeholder Personas](./stakeholder-personas.md)

---

## 1. ROI Calculation Framework

### 1.1 Core ROI Formula

```
ROI % = (Total Benefits - Total Costs) / Total Costs × 100%

Where:
- Total Benefits = Sum of all quantified benefits over analysis period
- Total Costs = Initial investment + Recurring costs over analysis period
```

### 1.2 ROI Quick Reference Table

| Metric | Formula | Purpose |
|--------|---------|---------|
| **ROI %** | (Benefits - Costs) / Costs × 100 | Overall return percentage |
| **Net Benefit** | Total Benefits - Total Costs | Absolute value created |
| **Benefit-Cost Ratio** | Total Benefits / Total Costs | Value per dollar spent |
| **Payback Period** | Time until cumulative cash flow > 0 | Breakeven timeframe |
| **NPV** | Σ (Cash Flow / (1 + r)^t) | Time-value adjusted returns |
| **IRR** | Rate where NPV = 0 | Effective rate of return |

---

## 2. Standard ROI Table Template

### 2.1 ROI Summary Table

Copy this table into your business case or memo:

| Metric | Value |
|--------|-------|
| **Total Investment** | $[X] |
| **Total 5-Year Benefits** | $[Y] |
| **Net Benefit** | $[Y-X] |
| **ROI %** | [(Y-X)/X × 100]% |
| **Payback Period** | [Months/Years] |
| **NPV @ 10%** | $[Z] |
| **IRR** | [W]% |

**Example:**
| Metric | Value |
|--------|-------|
| **Total Investment** | $2,500,000 |
| **Total 5-Year Benefits** | $8,750,000 |
| **Net Benefit** | $6,250,000 |
| **ROI %** | 250% |
| **Payback Period** | 14 months |
| **NPV @ 10%** | $4,650,000 |
| **IRR** | 85% |

---

## 3. Cash Flow Analysis Template

### 3.1 5-Year Cash Flow Table

| Year | Investment | Benefits | Net Cash Flow | Cumulative | Discounted CF (10%) |
|------|-----------|----------|---------------|------------|---------------------|
| Year 0 | ($[X]) | $0 | ($[X]) | ($[X]) | ($[X]) |
| Year 1 | ($[X]) | $[Y] | $[Z] | $[Z] | $[W] |
| Year 2 | ($[X]) | $[Y] | $[Z] | $[Z] | $[W] |
| Year 3 | ($[X]) | $[Y] | $[Z] | $[Z] | $[W] |
| Year 4 | ($[X]) | $[Y] | $[Z] | $[Z] | $[W] |
| Year 5 | ($[X]) | $[Y] | $[Z] | $[Z] | $[W] |
| **Total** | **($[X])** | **$[Y]** | **$[Z]** | **$[Z]** | **$[W]** |

**Payback Period**: Calculate when cumulative cash flow becomes positive

**Example:**
| Year | Investment | Benefits | Net Cash Flow | Cumulative | Discounted CF (10%) |
|------|-----------|----------|---------------|------------|---------------------|
| Year 0 | ($2,500,000) | $0 | ($2,500,000) | ($2,500,000) | ($2,500,000) |
| Year 1 | ($200,000) | $1,500,000 | $1,300,000 | ($1,200,000) | $1,181,818 |
| Year 2 | ($200,000) | $1,800,000 | $1,600,000 | $400,000 | $1,322,314 |
| Year 3 | ($200,000) | $1,950,000 | $1,750,000 | $2,150,000 | $1,314,645 |
| Year 4 | ($200,000) | $2,100,000 | $1,900,000 | $4,050,000 | $1,297,723 |
| Year 5 | ($200,000) | $2,250,000 | $2,050,000 | $6,100,000 | $1,272,810 |
| **Total** | **($3,500,000)** | **$9,600,000** | **$6,100,000** | **$6,100,000** | **$3,889,310** |

**Payback Period**: Month 14 of Year 2 (when cumulative becomes positive)

---

## 4. NPV & IRR Calculations

### 4.1 Net Present Value (NPV)

**Formula:**
```
NPV = Σ [CFt / (1 + r)^t]

Where:
- CFt = Cash flow in period t
- r = Discount rate (typically organizational hurdle rate: 8-12%)
- t = Time period (0, 1, 2, 3, etc.)
```

**Decision Criteria:**
- NPV > 0: Project creates value → **Approve**
- NPV = 0: Project breaks even → **Consider**
- NPV < 0: Project destroys value → **Reject**

**Common Discount Rates:**
- Conservative: 12-15%
- Moderate: 8-10%
- Aggressive: 5-7%
- **Recommended for AI projects**: 10% (accounts for technology risk)

### 4.2 Internal Rate of Return (IRR)

**Definition**: The discount rate that makes NPV = 0

**Calculation**: Use Excel `=IRR()` function or financial calculator

**Decision Criteria:**
- IRR > Organizational hurdle rate → **Approve**
- IRR = Organizational hurdle rate → **Consider**
- IRR < Organizational hurdle rate → **Reject**

**Typical Organizational Hurdle Rates:**
- Enterprise: 15-20%
- Mid-market: 20-25%
- Startup/High-growth: 25-30%

---

## 5. Sensitivity Analysis

### 5.1 Scenario Analysis Template

Test multiple scenarios to understand risk and uncertainty:

| Scenario | Assumption Changes | ROI % | Payback | NPV @ 10% |
|----------|-------------------|-------|---------|-----------|
| **Best Case** | Benefits +20%, Costs -10% | [X]% | [Y] mo | $[Z] |
| **Base Case** | As modeled | [X]% | [Y] mo | $[Z] |
| **Worst Case** | Benefits -20%, Costs +10% | [X]% | [Y] mo | $[Z] |

**Example:**
| Scenario | Assumption Changes | ROI % | Payback | NPV @ 10% |
|----------|-------------------|-------|---------|-----------|
| **Best Case** | Benefits +20%, Costs -10% | 385% | 10 mo | $6,890,000 |
| **Base Case** | As modeled | 250% | 14 mo | $4,650,000 |
| **Worst Case** | Benefits -20%, Costs +10% | 145% | 22 mo | $2,310,000 |

**Analysis**: Even in worst case, project delivers 145% ROI with positive NPV → **Low financial risk**

### 5.2 Tornado Diagram Variables

Test sensitivity to key assumptions (which variables impact ROI most?):

| Variable | -20% Impact | +20% Impact | Sensitivity |
|----------|-------------|-------------|-------------|
| User adoption rate | ROI: 180% | ROI: 320% | **HIGH** |
| Implementation cost | ROI: 290% | ROI: 210% | **MEDIUM** |
| Benefit realization % | ROI: 200% | ROI: 300% | **HIGH** |
| Discount rate | NPV: $5.2M | NPV: $4.1M | **MEDIUM** |
| Annual growth rate | ROI: 230% | ROI: 270% | **LOW** |

---

## 6. Benefit Categories & Quantification

### 6.1 Quantitative Benefits Framework

#### Cost Savings (Hard Benefits)
| Category | Calculation Method | Example |
|----------|-------------------|---------|
| **Labor efficiency** | Hours saved × Hourly rate × # of users | 500 users × 4 hrs/week × $50/hr × 52 weeks = $5.2M/year |
| **Process automation** | Transactions × Cost per transaction | 1M transactions × $2.50 saved = $2.5M/year |
| **Error reduction** | Error rate reduction × Cost per error | 5% reduction × 10K errors × $100 = $50K/year |
| **Infrastructure optimization** | Current cost - New cost | $800K - $500K = $300K/year |

#### Revenue Impact (Hard Benefits)
| Category | Calculation Method | Example |
|----------|-------------------|---------|
| **Revenue increase** | Conversion improvement × Volume × Value | 2% × 100K leads × $1K = $2M/year |
| **Customer retention** | Churn reduction × Customer LTV | 5% × 1K customers × $50K = $2.5M/year |
| **New capabilities** | New revenue stream estimation | New product line: $3M/year |
| **Faster time-to-market** | Opportunity cost of delay | 3 months faster × $250K/mo = $750K one-time |

#### Risk Reduction (Hard Benefits - if quantifiable)
| Category | Calculation Method | Example |
|----------|-------------------|---------|
| **Compliance penalties avoided** | Probability × Penalty amount | 10% × $5M = $500K/year expected value |
| **Fraud prevention** | Fraud rate × Transaction value | 0.5% reduction × $100M = $500K/year |
| **Downtime reduction** | Hours saved × Revenue per hour | 20 hrs × $50K/hr = $1M/year |

### 6.2 5-Year Benefit Projection Table

| Category | Year 1 | Year 2 | Year 3 | Year 4 | Year 5 | Total |
|----------|--------|--------|--------|--------|--------|-------|
| **Cost Savings** |
| Labor efficiency | $[X] | $[X] | $[X] | $[X] | $[X] | $[X] |
| Process automation | $[X] | $[X] | $[X] | $[X] | $[X] | $[X] |
| Error reduction | $[X] | $[X] | $[X] | $[X] | $[X] | $[X] |
| **Revenue Impact** |
| Revenue increase | $[X] | $[X] | $[X] | $[X] | $[X] | $[X] |
| Customer retention | $[X] | $[X] | $[X] | $[X] | $[X] | $[X] |
| **Risk Reduction** |
| Compliance | $[X] | $[X] | $[X] | $[X] | $[X] | $[X] |
| **TOTAL BENEFITS** | **$[X]** | **$[X]** | **$[X]** | **$[X]** | **$[X]** | **$[X]** |

**Growth Assumptions:**
- Year 1: 60% of full run-rate (ramp-up period)
- Year 2: 90% of full run-rate
- Year 3-5: 100% with 3% annual growth

---

## 7. Cost Categories & Estimation

### 7.1 Total Cost of Ownership (TCO) Framework

#### One-Time Costs (Capital Expenditure)
| Category | Typical Range | Example |
|----------|--------------|---------|
| **Software/Platform licenses** | $50K - $500K | Azure ML: $150K |
| **Implementation services** | $200K - $2M | SI partner: $800K |
| **Data preparation & migration** | $50K - $500K | Data cleansing: $150K |
| **Integration** | $100K - $800K | API development: $200K |
| **Training & change management** | $50K - $300K | User training: $100K |
| **Hardware/Infrastructure** | $50K - $500K | GPU compute: $200K |
| **Contingency (15%)** | 15% of above | $225K |

**Total One-Time**: $1,825K

#### Recurring Annual Costs (Operational Expenditure)
| Category | Typical Range | Example |
|----------|--------------|---------|
| **Cloud infrastructure** | $50K - $500K/yr | Azure compute & storage: $180K/yr |
| **Software licenses** | $20K - $200K/yr | AI services: $60K/yr |
| **Support & maintenance** | 15-20% of software | 18% × $150K = $27K/yr |
| **Operations team** | $100K - $500K/yr | 2 FTEs: $250K/yr |
| **Model retraining & updates** | $20K - $150K/yr | Quarterly updates: $40K/yr |
| **Monitoring & observability** | $10K - $100K/yr | APM tools: $30K/yr |

**Total Annual**: $587K/yr

### 7.2 5-Year Cost Projection Table

| Category | Year 0 | Year 1 | Year 2 | Year 3 | Year 4 | Year 5 | Total |
|----------|--------|--------|--------|--------|--------|--------|-------|
| **One-Time Costs** |
| Implementation | $[X] | | | | | | $[X] |
| Data preparation | $[X] | | | | | | $[X] |
| Integration | $[X] | | | | | | $[X] |
| Training | $[X] | | | | | | $[X] |
| **Recurring Costs** |
| Cloud infrastructure | | $[X] | $[X] | $[X] | $[X] | $[X] | $[X] |
| Software licenses | | $[X] | $[X] | $[X] | $[X] | $[X] | $[X] |
| Operations | | $[X] | $[X] | $[X] | $[X] | $[X] | $[X] |
| **TOTAL COSTS** | **$[X]** | **$[X]** | **$[X]** | **$[X]** | **$[X]** | **$[X]** | **$[X]** |

---

## 8. Financial Analysis Best Practices

### 8.1 Conservative Estimation Guidelines

**✅ DO:**
- Use conservative benefit estimates (capture 70-80% of theoretical maximum)
- Include 15% contingency in costs
- Model benefits ramping up over 12-18 months (not instant)
- Use organizational discount rate (10-12% typical)
- Validate assumptions with finance team
- Document all assumptions clearly

**❌ DON'T:**
- Use "best case" benefits as your base case
- Forget ongoing operational costs
- Assume 100% user adoption immediately
- Include qualitative benefits in quantitative ROI
- Forget to discount future cash flows
- Hide unfavorable assumptions

### 8.2 Common Pitfalls to Avoid

| Pitfall | Impact | Mitigation |
|---------|--------|------------|
| Overestimating adoption | Inflated benefits | Use 60-70% adoption in Year 1 |
| Underestimating costs | Budget overruns | Add 15-20% contingency |
| Ignoring time value of money | Misleading ROI | Always calculate NPV |
| Double-counting benefits | Inflated ROI | Ensure benefits are mutually exclusive |
| Forgetting OpEx | Hidden costs | Include 5-year TCO |

---

## 9. ROI Reporting & Tracking

### 9.1 Quarterly ROI Tracking Template

Track actual vs. projected ROI quarterly:

| Quarter | Planned Benefits | Actual Benefits | Variance | Planned Costs | Actual Costs | Variance |
|---------|-----------------|-----------------|----------|---------------|--------------|----------|
| Q1 | $[X] | $[Y] | [Z]% | $[X] | $[Y] | [Z]% |
| Q2 | $[X] | $[Y] | [Z]% | $[X] | $[Y] | [Z]% |
| Q3 | $[X] | $[Y] | [Z]% | $[X] | $[Y] | [Z]% |
| Q4 | $[X] | $[Y] | [Z]% | $[X] | $[Y] | [Z]% |

**Cumulative ROI**: [X]% (Target: [Y]%)

### 9.2 Benefit Realization Dashboard

| KPI | Baseline | Target | Current | On Track? |
|-----|----------|--------|---------|-----------|
| Labor efficiency | [X] hrs | [Y] hrs | [Z] hrs | ✅/❌ |
| Process time | [X] days | [Y] days | [Z] days | ✅/❌ |
| Error rate | [X]% | [Y]% | [Z]% | ✅/❌ |
| Revenue impact | $[X] | $[Y] | $[Z] | ✅/❌ |

---

## 10. Excel Formulas & Functions

### 10.1 Quick Copy Formulas

**ROI Percentage:**
```excel
=((B1-A1)/A1)*100
Where: B1 = Total Benefits, A1 = Total Costs
```

**NPV Calculation:**
```excel
=NPV(rate, value1, [value2], ...) + initial_investment
Example: =NPV(0.10, B2:B6) + A1
```

**IRR Calculation:**
```excel
=IRR(values)
Example: =IRR(A1:A6)
```

**Payback Period:**
```excel
=MATCH(TRUE, cumulative_cash_flow>0, 0)
Gives the period when payback occurs
```

---

## 11. Interactive Calculator

### 11.1 Online ROI Calculator

**🧮 [Launch Interactive ROI Calculator](https://andreaswasita.github.io/AI-Delivery-Methodology/)**

**Features:**
- Real-time NPV, ROI, payback calculations
- Sensitivity analysis scenarios
- 5-year projections with growth modeling
- Export results to PowerPoint/Excel
- No data stored (fully client-side)

**Use When:**
- Building business cases
- Comparing multiple use cases
- Workshop facilitation
- Executive presentations

---

## 12. How to Use This Module

### 12.1 In Business Cases

**Reference this module:**
```markdown
## Financial Analysis
> **Framework**: See [ROI & Financial Analysis Module](./shared-components/roi-financial-analysis.md)
> **Calculator**: [Interactive ROI Calculator](https://andreaswasita.github.io/AI-Delivery-Methodology/)

### ROI Summary
[Copy ROI Summary Table from Section 2.1]

### Detailed Analysis
[Copy Cash Flow Table from Section 3.1]
[Copy Sensitivity Analysis from Section 5.1]
```

### 12.2 In Executive Memos

**Quick reference:**
```markdown
## Financial Justification
[Copy ROI Summary Table - Section 2.1]

**Sensitivity Analysis**: Even in worst-case scenario (benefits -20%), project delivers [X]% ROI.

> **Full Analysis**: See [Business Case](./02-business-case.md) Section 5
```

### 12.3 In Use Case Templates

**Summary format:**
```markdown
## Financial Impact
| Annual Value | $[X] |
| Investment Required | $[Y] |
| ROI | [Z]% |
| Payback | [W] months |

> **Calculator**: [Detailed ROI Analysis](https://andreaswasita.github.io/AI-Delivery-Methodology/)
```

---

## 13. Related Resources

### 13.1 Internal References
- **[Business Case Template](../02-business-case.md)** - Use this ROI framework in Section 5
- **[Use Case Template](../14-business-envisioning-use-case-template.md)** - Financial impact section
- **[Executive Decision Memo](../15-executive-decision-memo.md)** - ROI summary
- **[Risk Library](./risk-library.md)** - Financial risk considerations

### 13.2 External Resources
- [NPV Calculator](https://www.calculator.net/npv-calculator.html)
- [IRR Calculation Guide](https://corporatefinanceinstitute.com/resources/knowledge/finance/irr-internal-rate-return/)
- [Sensitivity Analysis Tutorial](https://www.wallstreetmojo.com/sensitivity-analysis/)

---

## 14. Version History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-13 | PM | Initial shared module created |

---

**Questions or Improvements?**  
Open an issue or submit a PR with suggestions!

**Last Updated**: January 13, 2026
