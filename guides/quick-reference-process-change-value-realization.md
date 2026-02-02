# Quick Reference: Identifying Process Changes & Value Realization for AI Use Cases

## 30-Second Overview

**For each AI use case, ask these 3 critical questions:**

1. **How will people work differently?** (Business Changes) → This delivers value
2. **What support do they need to change?** (Enabling Changes) → Training, new roles, governance
3. **What's the financial ROI?** (NPV Calculation) → Ensure positive return

**Golden Rule:** If you can't describe how people will work differently, you haven't identified real business value.

---

## 5-Minute Quick Start

### Step 1: Map Current vs. Future Process (10 min)

**Current Process (As-Is):**
- List each step people do today
- Note time, error rate, pain points

**Future Process (To-Be):**
- Show where AI automates/augments
- Calculate time savings, error reduction

**Example:**
```
As-Is: Manual data entry → 15 minutes, 15% errors
To-Be: AI auto-extracts → 30 seconds, 2% errors
Business Change: Staff review AI output instead of manual entry
```

### Step 2: Identify Business Changes (5 min)

For each process change, ask:
- What specific behavior must change?
- Who is impacted? (count people)
- What's their readiness? (High/Medium/Low)

**Example:**
- **BC-01:** Customer service reps review AI-processed transactions instead of manual entry (200 people, Low readiness)

### Step 3: Plan Enabling Changes (5 min)

What's needed to support business changes?
- **Training:** How many hours? Who delivers?
- **New Roles:** Any new job descriptions?
- **Governance:** Who oversees AI decisions?

**Example:**
- **EC-01:** 40-hour AI literacy program (HR, Month 1-2)
- **EC-02:** New "AI Exception Handler" role defined (HR, Month 2)

### Step 4: Calculate NPV (10 min)

**Simple NPV Formula:**
```
NPV = (Total Benefits - Total Costs) over 5 years, discounted

Benefits = Cost savings + Revenue increase + Risk reduction
Costs = Implementation + Annual operating costs
Discount Rate = Company's WACC (typically 8-12%)
```

**Quick Test:** 
- NPV > 0 ✅ → Proceed
- NPV < 0 ❌ → Stop or redesign

---

## 15-Minute Deep Dive

### Framework: Benefits Dependency Network

```
Business Drivers (Why do this?)
    ↓
Investment Objectives (What must we achieve?)
    ↓
Benefits (Measurable outcomes)
    ↓
Business Changes (How people work differently) ← THE KEY
    ↓
Enabling Changes (Organizational support)
    ↓
IT Enablers (Technology)
```

### Process Change Identification Technique

**Ask these questions in order:**

1. **What's broken today?**
   - "Customer onboarding takes 3 days"
   
2. **What's the root cause?** (Five Whys)
   - "Because: manual document review → no OCR → legacy systems → etc."
   
3. **How will AI fix it?**
   - "AI extracts data from documents in 30 seconds"
   
4. **How must people work differently?**
   - "Staff review AI-extracted data instead of manual typing"
   
5. **What's the new process flow?**
   - Before: Receive doc → Manual entry → Review → Route (62 min)
   - After: Receive doc → AI extracts → Human reviews → Auto-route (5 min)

### Business Change Classification

| Change Type | Example | Risk Level | Training Need |
|-------------|---------|------------|---------------|
| **Automated** | Data entry eliminated | High | Medium (learn to review AI) |
| **Augmented** | AI recommends, human decides | Medium | High (learn to evaluate AI) |
| **Eliminated** | Manual step removed | High | Low (but change management) |
| **New** | New AI oversight process | Medium | High (new skills) |

### Stakeholder Impact Analysis

**For each impacted group:**

| Factor | Score 1-5 | Action if Low |
|--------|-----------|---------------|
| **Understanding** | Do they understand why? | Communication campaign |
| **Ability** | Can they do it? | Training program |
| **Willingness** | Do they want to? | Incentives, WIIFM |
| **Resources** | Do they have time/tools? | Capacity planning |

**Overall Readiness = Average Score**
- < 3.0 = High Risk ❌
- 3.0-4.0 = Medium Risk ⚠️
- > 4.0 = Low Risk ✅

---

## NPV Calculation Quick Guide

### Step-by-Step NPV Calculation

**1. List Implementation Costs (Year 0):**
```
Technology: $______
Data prep: $______
Development: $______
Training: $______
Change management: $______
Total Year 0: $______
```

**2. List Annual Operating Costs (Year 1-5):**
```
Azure consumption: $______ /year
Licenses: $______ /year
Maintenance: $______ /year
Operations team: $______ /year
Total Annual: $______
```

**3. List Annual Benefits (Year 1-5):**
```
Cost savings: $______ /year
Revenue increase: $______ /year
Risk mitigation: $______ /year
Total Annual: $______
```

**4. Calculate Net Cash Flows:**
```
Year 0: -$______ (investment)
Year 1: $______ (benefits) - $______ (ops costs) = $______
Year 2-5: Similar calculation (may grow)
```

**5. Apply Discount Rate:**
```
Discount Rate: ___% (use company WACC)
Year 1 PV = Cash Flow / (1 + rate)^1
Year 2 PV = Cash Flow / (1 + rate)^2
...
```

**6. Sum All PVs:**
```
NPV = Sum of all discounted cash flows
```

### Discount Factor Table (Quick Reference)

| Year | 8% | 10% | 12% | 15% |
|------|-----|------|------|------|
| 1 | 0.926 | 0.909 | 0.893 | 0.870 |
| 2 | 0.857 | 0.826 | 0.797 | 0.756 |
| 3 | 0.794 | 0.751 | 0.712 | 0.658 |
| 4 | 0.735 | 0.683 | 0.636 | 0.572 |
| 5 | 0.681 | 0.621 | 0.567 | 0.497 |

### Quick NPV Example

**Use Case: AI Document Processing**

**Costs:**
- Year 0: -$200K (implementation)
- Years 1-5: -$50K/year (operations)

**Benefits:**
- Years 1-5: +$150K/year (cost savings)

**Net Cash Flow per Year:**
- Year 0: -$200K
- Years 1-5: $100K/year ($150K - $50K)

**NPV Calculation (10% discount rate):**
```
Year 0: -$200K × 1.000 = -$200K
Year 1: $100K × 0.909 = $90.9K
Year 2: $100K × 0.826 = $82.6K
Year 3: $100K × 0.751 = $75.1K
Year 4: $100K × 0.683 = $68.3K
Year 5: $100K × 0.621 = $62.1K

NPV = -$200K + $379K = $179K ✅ (positive, proceed!)
```

**Payback Period:** Year 0 + Year 1 + Year 2 = ~2.4 years

---

## Common Mistakes to Avoid

### ❌ Mistake 1: Technology-Only Focus
**Wrong:** "We'll implement Azure OpenAI"
**Right:** "Staff will review AI-generated summaries instead of reading 50-page documents"

### ❌ Mistake 2: Vague Business Changes
**Wrong:** "Users will adopt AI"
**Right:** "Compliance officers will spend 70% time on complex cases (AI handles routine 30%)"

### ❌ Mistake 3: Ignoring Enabling Changes
**Wrong:** Assume people will magically change
**Right:** Plan 40 hours AI literacy training + new AI Steward role

### ❌ Mistake 4: Unrealistic Change Readiness
**Wrong:** "Everyone is excited!" (all 10/10 scores)
**Right:** "Operations team skeptical (4/10), need champions program"

### ❌ Mistake 5: Benefits Without Business Change Link
**Wrong:** "We'll save $500K" (how?)
**Right:** "Automated processing eliminates 10 FTEs manual work = $500K savings (BC-02)"

### ❌ Mistake 6: Overly Optimistic NPV
**Wrong:** Assume 100% adoption, zero delays, maximum benefits
**Right:** Sensitivity analysis with 70/80/100% adoption scenarios

---

## Quick Decision Trees

### Decision 1: Is This Business Change Real?

```
Can you describe EXACTLY how daily work will change?
├─ Yes → Good, document it
└─ No → Not a business change, keep digging

Will this change require training or new skills?
├─ Yes → Good, plan enabling changes
└─ No → Probably not a significant change

Can benefits be realized WITHOUT this change?
├─ Yes → Wrong change identified
└─ No → Correct! This change is essential
```

### Decision 2: Is NPV Realistic?

```
Is NPV > 0?
├─ No → Stop or redesign
└─ Yes → Continue...

    Did you include ALL costs?
    ├─ Implementation: Technology, data, development, training, change
    ├─ Operating: Azure, licenses, maintenance, operations team
    └─ Opportunity cost: What else could we do with this money?

    Are benefits quantified with evidence?
    ├─ Current baseline measured (not assumed)
    ├─ Target realistic (not wishful thinking)
    ├─ Adoption ramp-up assumed (not 100% Day 1)
    └─ Risk adjustment applied (not best case only)

    Sensitivity analysis done?
    ├─ Best case NPV = $_____
    ├─ Base case NPV = $_____
    └─ Worst case NPV = $_____

        If worst case NPV > 0 → Strong case ✅
        If worst case NPV < 0 but base > 0 → Moderate risk ⚠️
        If base case NPV < 0 → Reject ❌
```

### Decision 3: Is Change Readiness Acceptable?

```
Leadership Support?
├─ No executive sponsor → High Risk ❌
└─ Yes → Continue...

    Stakeholder Buy-In?
    ├─ Majority resistant → High Risk ❌
    ├─ Mixed → Medium Risk ⚠️
    └─ Majority supportive → Low Risk ✅

        Resource Availability?
        ├─ No budget/time for training → High Risk ❌
        ├─ Limited capacity → Medium Risk ⚠️
        └─ Resources committed → Low Risk ✅

            Organizational Capacity?
            ├─ Already undergoing major changes → High Risk ❌
            ├─ Some change fatigue → Medium Risk ⚠️
            └─ Capacity for change → Low Risk ✅

Overall Readiness Score:
├─ < 40% → DO NOT PROCEED ❌
├─ 40-60% → Proceed with major mitigations ⚠️
├─ 60-75% → Proceed with mitigations ⚠️
└─ > 75% → Proceed ✅
```

---

## Cheat Sheet: What to Ask for Each Use Case

### Business Changes
- [ ] How will people work differently? (Be specific!)
- [ ] What behaviors must change?
- [ ] What processes will be eliminated/automated/augmented?
- [ ] Who is impacted? (Name roles + count)
- [ ] What's the magnitude of change? (High/Med/Low)

### Enabling Changes
- [ ] What training is needed? (Hours, who, when)
- [ ] What new roles are needed? (Job descriptions)
- [ ] What governance is needed? (Oversight, decision rights)
- [ ] What communication is needed? (Plan, messages, frequency)
- [ ] What processes need redesign? (SOPs, documentation)

### Financial ROI
- [ ] What are implementation costs? (Detailed breakdown)
- [ ] What are annual operating costs? (Recurring expenses)
- [ ] What are annual benefits? (Quantified with evidence)
- [ ] What's the NPV? (Use company discount rate)
- [ ] What's the payback period? (Months to break-even)
- [ ] What's the sensitivity analysis? (Best/base/worst case)

### Change Readiness
- [ ] Is there executive sponsorship? (Yes/No)
- [ ] Are stakeholders supportive? (Score 1-10)
- [ ] Are resources available? (Budget, time, people)
- [ ] Is organizational capacity sufficient? (Other change initiatives)
- [ ] What are the risks? (Resistance, complexity, timing)

---

## Templates & Tools

**Use These Resources:**
- ✅ [Use Case Business Change Checklist](../checklists/use-case-business-change-checklist.md) - Complete checklist
- ✅ [Benefits Dependency Network Template](../templates/15-benefits-dependency-network.md) - Full BDN framework
- ✅ [Business Process Change Analysis](../templates/16-business-process-change-analysis.md) - Detailed methodology
- ✅ [Use Case Template](../templates/14-business-envisioning-use-case-template.md) - Use case documentation
- ✅ [ROI Calculator](../calculators/roi-calculator.html) - Interactive NPV tool
- ✅ [Change Management Guide](../guides/change-management-ai-adoption.md) - Change best practices

---

## 5-Minute Workshop Exercise

**Run this with your team for each use case:**

**Round 1 (2 min):** Everyone writes on sticky notes:
- "How will [role] work differently with AI?"

**Round 2 (2 min):** Group similar changes, identify top 3 business changes

**Round 3 (1 min):** For each business change, quick vote:
- Change readiness: 👍 High 👐 Medium 👎 Low

**Output:** Top 3 business changes with readiness assessment

---

## One-Page Summary Template

```
Use Case: _______________________

BUSINESS CHANGES (How people work differently):
1. _________________________________ [Readiness: H/M/L]
2. _________________________________ [Readiness: H/M/L]
3. _________________________________ [Readiness: H/M/L]

ENABLING CHANGES (What support needed):
1. Training: _____ hours per person (Owner: _____)
2. New roles: _________________ (Owner: _____)
3. Governance: ________________ (Owner: _____)

FINANCIAL ROI:
- Implementation Cost: $_______
- Annual Operating Cost: $_______
- Annual Benefits: $_______
- NPV (5 years): $_______ [✅ Positive / ❌ Negative]
- Payback Period: _____ months

CHANGE READINESS: ___% [✅ >60% / ⚠️ 40-60% / ❌ <40%]

DECISION: [ ] Proceed [ ] Proceed with Mitigations [ ] Reject
```

---

## Document Control

**Version:** 1.0  
**Date:** February 2, 2026  
**Purpose:** Quick reference for practitioners  
**Next Review:** 3 months  

---

**Remember:** Technology enables, but business change delivers value!
