# Use Case Prioritization Matrix

**Template Version**: 1.0  
**Last Updated**: January 13, 2026  
**Project**: [Project Name]  
**Date**: [Date]  
**Prepared By**: [Name, Title]

---

## Purpose

This template provides a systematic framework for evaluating and prioritizing multiple AI use cases using a **Business Value vs Technical Feasibility** 2×2 matrix combined with a comprehensive **11-metric scoring rubric**.

**Use this template when:**
- 🎯 Multiple AI opportunities identified (5+ use cases)
- 💼 Need data-driven prioritization for portfolio planning
- 💰 Limited budget requires selecting highest-impact use cases
- 🚀 Building AI roadmap with phased delivery waves
- 🤝 Need executive alignment on priorities

**Key Outputs:**
1. Scored use cases across 11 dimensions
2. Visual 2×2 prioritization matrix (Quick Wins, Strategic Bets, Fill-Ins, Time Sinks)
3. Recommended implementation sequence
4. Portfolio roadmap with wave planning

---

## Section 1: Use Case Inventory

### 1.1 Use Case List

Capture all identified use cases from discovery activities:

| ID | Use Case Name | Business Area | Problem Statement | Sponsor |
|----|---------------|---------------|-------------------|---------|
| UC-01 | [e.g., Fraud Detection] | [e.g., Risk Management] | [Brief description of problem] | [Name, Title] |
| UC-02 | [e.g., Customer Churn Prediction] | [e.g., Sales & Marketing] | [Brief description] | [Name, Title] |
| UC-03 | [e.g., Inventory Optimization] | [e.g., Supply Chain] | [Brief description] | [Name, Title] |
| UC-04 | [Use Case Name] | [Business Area] | [Problem Statement] | [Sponsor] |
| UC-05 | [Use Case Name] | [Business Area] | [Problem Statement] | [Sponsor] |
| ... | ... | ... | ... | ... |

**Total Use Cases Identified**: [Number]

**Source**: Refer to:
- [Business Envisioning Workshop outcomes](13-business-envisioning-pre-work.md)
- [Use Case Templates](14-business-envisioning-use-case-template.md) completed during discovery
- [Business Requirements Documents](09-business-requirements-document.md)

---

## Section 2: Evaluation Framework

### 2.1 The 11 Metrics

Each use case is scored across **11 dimensions** combining quantitative financial metrics and qualitative strategic factors:

#### Financial Metrics (Quantitative)

| Metric | Description | Data Source | Scoring Range |
|--------|-------------|-------------|---------------|
| **1. Current-State Cost** | Annual cost of current process/problem | Baseline assessment | 0-10 (higher cost = higher score) |
| **2. Future-State Benefit** | Annual benefit after AI implementation | ROI calculator | 0-10 (higher benefit = higher score) |
| **3. Build Cost** | One-time implementation cost | Vendor quotes, estimates | 0-10 (lower cost = higher score) |
| **4. Run Cost (Annual)** | Ongoing operational cost | Cloud pricing, staffing | 0-10 (lower cost = higher score) |
| **5. ROI %** | Return on investment percentage | ROI calculator | 0-10 (higher ROI = higher score) |
| **6. Payback Period** | Months to break even | ROI calculator | 0-10 (shorter = higher score) |
| **7. NPV (3-5 years)** | Net present value | ROI calculator | 0-10 (higher NPV = higher score) |
| **8. TCO (3-5 years)** | Total cost of ownership | ROI calculator | 0-10 (lower TCO = higher score) |

#### Strategic Metrics (Qualitative)

| Metric | Description | Assessment Method | Scoring Range |
|--------|-------------|-------------------|---------------|
| **9. Strategic Alignment** | Alignment with business strategy | Executive input | 0-10 (higher alignment = higher score) |
| **10. Risk Score** | Overall project risk (inverse) | Risk assessment | 0-10 (lower risk = higher score) |
| **11. Scalability/Reusability** | Potential for reuse across business | Architecture review | 0-10 (higher reuse = higher score) |

### 2.2 Scoring Rubric

#### Metric 1: Current-State Cost (Annual Baseline)

| Score | Current-State Cost | Description |
|-------|-------------------|-------------|
| 10 | >$5M/year | Extremely expensive current process |
| 8-9 | $2M-$5M/year | High cost current process |
| 6-7 | $500K-$2M/year | Moderate cost current process |
| 4-5 | $100K-$500K/year | Low cost current process |
| 1-3 | <$100K/year | Minimal cost current process |
| 0 | No quantifiable cost | Unable to baseline current state |

#### Metric 2: Future-State Benefit (Annual Value)

| Score | Annual Benefit | Description |
|-------|----------------|-------------|
| 10 | >$5M/year | Transformational business impact |
| 8-9 | $2M-$5M/year | Very high value potential |
| 6-7 | $500K-$2M/year | High value potential |
| 4-5 | $100K-$500K/year | Moderate value potential |
| 1-3 | <$100K/year | Low value potential |
| 0 | No quantifiable benefit | Unable to quantify benefits |

#### Metric 3: Build Cost (Implementation)

| Score | Build Cost | Description |
|-------|-----------|-------------|
| 10 | <$100K | Very low implementation cost |
| 8-9 | $100K-$300K | Low implementation cost |
| 6-7 | $300K-$750K | Moderate implementation cost |
| 4-5 | $750K-$1.5M | High implementation cost |
| 1-3 | $1.5M-$3M | Very high implementation cost |
| 0 | >$3M | Extremely high implementation cost |

#### Metric 4: Run Cost (Annual Operations)

| Score | Annual Run Cost | Description |
|-------|----------------|-------------|
| 10 | <$50K/year | Minimal ongoing cost |
| 8-9 | $50K-$150K/year | Low ongoing cost |
| 6-7 | $150K-$400K/year | Moderate ongoing cost |
| 4-5 | $400K-$800K/year | High ongoing cost |
| 1-3 | $800K-$1.5M/year | Very high ongoing cost |
| 0 | >$1.5M/year | Extremely high ongoing cost |

#### Metric 5: ROI % (Return on Investment)

| Score | ROI % | Description |
|-------|-------|-------------|
| 10 | >200% | Exceptional return |
| 8-9 | 100%-200% | Very high return |
| 6-7 | 50%-100% | High return |
| 4-5 | 20%-50% | Moderate return |
| 1-3 | 0%-20% | Low return |
| 0 | <0% (negative) | No return / loss |

#### Metric 6: Payback Period (Months)

| Score | Payback Period | Description |
|-------|---------------|-------------|
| 10 | <6 months | Immediate payback |
| 8-9 | 6-12 months | Fast payback |
| 6-7 | 12-18 months | Moderate payback |
| 4-5 | 18-24 months | Acceptable payback |
| 1-3 | 24-36 months | Slow payback |
| 0 | >36 months | Very slow / no payback |

#### Metric 7: NPV (3-5 Year Net Present Value)

| Score | NPV (3-5 years) | Description |
|-------|----------------|-------------|
| 10 | >$10M | Exceptional value creation |
| 8-9 | $5M-$10M | Very high value creation |
| 6-7 | $2M-$5M | High value creation |
| 4-5 | $500K-$2M | Moderate value creation |
| 1-3 | $0-$500K | Low value creation |
| 0 | <$0 (negative) | Value destruction |

#### Metric 8: TCO (3-5 Year Total Cost of Ownership)

| Score | TCO (3-5 years) | Description |
|-------|----------------|-------------|
| 10 | <$500K | Very low total cost |
| 8-9 | $500K-$1M | Low total cost |
| 6-7 | $1M-$2.5M | Moderate total cost |
| 4-5 | $2.5M-$5M | High total cost |
| 1-3 | $5M-$10M | Very high total cost |
| 0 | >$10M | Extremely high total cost |

#### Metric 9: Strategic Alignment

| Score | Strategic Alignment | Description |
|-------|-------------------|-------------|
| 10 | Critical strategic priority | Directly supports CEO/Board OKRs |
| 8-9 | High strategic importance | Supports key business strategy |
| 6-7 | Moderate strategic fit | Aligns with business goals |
| 4-5 | Low strategic importance | Tactical improvement only |
| 1-3 | Minimal strategic value | Nice-to-have, not strategic |
| 0 | No strategic alignment | Disconnected from strategy |

#### Metric 10: Risk Score (Inverse - Lower Risk = Higher Score)

| Score | Risk Level | Description |
|-------|-----------|-------------|
| 10 | Very Low Risk | Proven technology, clear requirements, low complexity |
| 8-9 | Low Risk | Standard AI, good data, manageable complexity |
| 6-7 | Moderate Risk | Some unknowns, data quality concerns, medium complexity |
| 4-5 | High Risk | Experimental AI, poor data, high complexity |
| 1-3 | Very High Risk | Unproven technology, no data, extreme complexity |
| 0 | Extreme Risk | Likely to fail, multiple critical risks |

**Risk Assessment**: Use [Risk Library](shared-components/risk-library.md) and [Risk Register](05-risk-register.md) to evaluate:
- Technical risk (R001-R005)
- Data risk (R006-R008)
- Business risk (R009-R012)
- Organizational risk (R013-R015)

#### Metric 11: Scalability/Reusability

| Score | Scalability/Reusability | Description |
|-------|------------------------|-------------|
| 10 | Highly reusable platform capability | Can be reused across 5+ business areas |
| 8-9 | Significant reuse potential | Can be reused across 3-4 business areas |
| 6-7 | Moderate reuse potential | Can be reused across 2 business areas |
| 4-5 | Limited reuse potential | Single business area, some components reusable |
| 1-3 | Minimal reuse potential | One-off solution, low reusability |
| 0 | No reuse potential | Completely custom, throwaway solution |

---

## Section 3: Use Case Scoring

### 3.1 Detailed Scoring Matrix

Complete the scoring for each use case using the rubrics above:

#### Use Case UC-01: [Use Case Name]

| Metric | Score (0-10) | Justification | Data Source |
|--------|--------------|---------------|-------------|
| 1. Current-State Cost | [Score] | [Brief explanation] | [Source] |
| 2. Future-State Benefit | [Score] | [Brief explanation] | [Source] |
| 3. Build Cost | [Score] | [Brief explanation] | [Source] |
| 4. Run Cost | [Score] | [Brief explanation] | [Source] |
| 5. ROI % | [Score] | [Brief explanation] | ROI Calculator |
| 6. Payback Period | [Score] | [Brief explanation] | ROI Calculator |
| 7. NPV | [Score] | [Brief explanation] | ROI Calculator |
| 8. TCO | [Score] | [Brief explanation] | ROI Calculator |
| 9. Strategic Alignment | [Score] | [Brief explanation] | Executive input |
| 10. Risk Score | [Score] | [Brief explanation] | Risk assessment |
| 11. Scalability/Reusability | [Score] | [Brief explanation] | Architecture review |
| **TOTAL SCORE** | **[Sum/110]** | **Average: [Sum/11]** | **Percentage: [Sum/110 × 100%]** |

**Quick Financial Summary** (from [ROI Calculator](../calculators/roi-calculator.html)):
- Annual Benefit: $[Amount]
- Build Cost: $[Amount]
- Annual Run Cost: $[Amount]
- ROI: [%]
- Payback: [Months]
- NPV (5-year): $[Amount]

**Key Risks** (from [Risk Register](05-risk-register.md)):
- [Risk 1]
- [Risk 2]
- [Risk 3]

---

#### Use Case UC-02: [Use Case Name]

| Metric | Score (0-10) | Justification | Data Source |
|--------|--------------|---------------|-------------|
| 1. Current-State Cost | [Score] | [Brief explanation] | [Source] |
| 2. Future-State Benefit | [Score] | [Brief explanation] | [Source] |
| 3. Build Cost | [Score] | [Brief explanation] | [Source] |
| 4. Run Cost | [Score] | [Brief explanation] | [Source] |
| 5. ROI % | [Score] | [Brief explanation] | ROI Calculator |
| 6. Payback Period | [Score] | [Brief explanation] | ROI Calculator |
| 7. NPV | [Score] | [Brief explanation] | ROI Calculator |
| 8. TCO | [Score] | [Brief explanation] | ROI Calculator |
| 9. Strategic Alignment | [Score] | [Brief explanation] | Executive input |
| 10. Risk Score | [Score] | [Brief explanation] | Risk assessment |
| 11. Scalability/Reusability | [Score] | [Brief explanation] | Architecture review |
| **TOTAL SCORE** | **[Sum/110]** | **Average: [Sum/11]** | **Percentage: [Sum/110 × 100%]** |

**Quick Financial Summary**:
- Annual Benefit: $[Amount]
- Build Cost: $[Amount]
- Annual Run Cost: $[Amount]
- ROI: [%]
- Payback: [Months]
- NPV (5-year): $[Amount]

**Key Risks**:
- [Risk 1]
- [Risk 2]
- [Risk 3]

---

*[Repeat for all use cases UC-03, UC-04, UC-05, etc.]*

---

### 3.2 Portfolio Scoring Summary

| Use Case ID | Use Case Name | Total Score (/110) | Average Score (/10) | Percentage (%) | Rank |
|-------------|---------------|-------------------|-------------------|----------------|------|
| UC-01 | [Name] | [Sum] | [Avg] | [%] | [Rank] |
| UC-02 | [Name] | [Sum] | [Avg] | [%] | [Rank] |
| UC-03 | [Name] | [Sum] | [Avg] | [%] | [Rank] |
| UC-04 | [Name] | [Sum] | [Avg] | [%] | [Rank] |
| UC-05 | [Name] | [Sum] | [Avg] | [%] | [Rank] |
| ... | ... | ... | ... | ... | ... |

**Portfolio Statistics**:
- **Highest Scoring Use Case**: [UC-XX: Name] - [Score]
- **Lowest Scoring Use Case**: [UC-XX: Name] - [Score]
- **Average Portfolio Score**: [Average]
- **Median Score**: [Median]

---

## Section 4: Business Value vs Technical Feasibility Matrix

### 4.1 Dimension Calculation

To create the 2×2 matrix, calculate **Business Value** and **Technical Feasibility** composite scores:

#### Business Value Calculation

**Formula**: Business Value = Average of Metrics 1, 2, 5, 6, 7, 9, 11

| Use Case | M1: Cost | M2: Benefit | M5: ROI | M6: Payback | M7: NPV | M9: Strategic | M11: Scale | **Business Value** |
|----------|----------|-------------|---------|-------------|---------|---------------|------------|-------------------|
| UC-01 | [Score] | [Score] | [Score] | [Score] | [Score] | [Score] | [Score] | **[Avg/10]** |
| UC-02 | [Score] | [Score] | [Score] | [Score] | [Score] | [Score] | [Score] | **[Avg/10]** |
| UC-03 | [Score] | [Score] | [Score] | [Score] | [Score] | [Score] | [Score] | **[Avg/10]** |
| ... | ... | ... | ... | ... | ... | ... | ... | ... |

#### Technical Feasibility Calculation

**Formula**: Technical Feasibility = Average of Metrics 3, 4, 8, 10

| Use Case | M3: Build Cost | M4: Run Cost | M8: TCO | M10: Risk | **Technical Feasibility** |
|----------|----------------|--------------|---------|-----------|--------------------------|
| UC-01 | [Score] | [Score] | [Score] | [Score] | **[Avg/10]** |
| UC-02 | [Score] | [Score] | [Score] | [Score] | **[Avg/10]** |
| UC-03 | [Score] | [Score] | [Score] | [Score] | **[Avg/10]** |
| ... | ... | ... | ... | ... | ... |

### 4.2 The 2×2 Prioritization Matrix

Plot each use case on the matrix based on Business Value (Y-axis) and Technical Feasibility (X-axis):

```
    10 │ STRATEGIC BETS          │ QUICK WINS ⭐
       │ (Plan Carefully)        │ (Prioritize!)
       │                         │
       │ • High value            │ • High value
  B    │ • Hard to build         │ • Easy to build
  u  7 │ • Longer timeline       │ • Fast ROI
  s    │ • Higher risk           │ • Lower risk
  i    │ • Wave 2-3              │ • Wave 1 🚀
  n    ├─────────────────────────┼─────────────────────
  e    │                         │
  s    │ TIME SINKS ❌           │ FILL-INS
  s  5 │ (Avoid!)                │ (Low Priority)
       │                         │
  V    │ • Low value             │ • Low value
  a    │ • Hard to build         │ • Easy to build
  l    │ • Not worth effort      │ • Not strategic
  u    │ • Deprioritize          │ • Wave 3+ (optional)
  e    │                         │
     0 └─────────────────────────┴─────────────────────
       0                       5                      10
              Technical Feasibility →
```

**Quadrant Definitions**:

| Quadrant | Business Value | Technical Feasibility | Action | Typical Timeline |
|----------|---------------|----------------------|--------|------------------|
| **Quick Wins** ⭐ | High (7-10) | High (7-10) | **Prioritize** - Deliver first | Wave 1 (Months 1-9) |
| **Strategic Bets** | High (7-10) | Low (0-6) | **Plan carefully** - Deliver after quick wins | Wave 2-3 (Months 9-18) |
| **Fill-Ins** | Low (0-6) | High (7-10) | **Low priority** - Deliver if capacity | Wave 3+ (Months 18+) |
| **Time Sinks** ❌ | Low (0-6) | Low (0-6) | **Avoid** - Deprioritize or cancel | Not recommended |

### 4.3 Use Case Placement

Map each use case to its quadrant:

#### Quick Wins (High Value + High Feasibility) ⭐

| Use Case ID | Name | Business Value | Technical Feasibility | Rank | Wave |
|-------------|------|----------------|----------------------|------|------|
| UC-[X] | [Name] | [Score] | [Score] | 1 | Wave 1 |
| UC-[Y] | [Name] | [Score] | [Score] | 2 | Wave 1 |
| ... | ... | ... | ... | ... | ... |

**Recommendation**: **PRIORITIZE** - Deliver these first to generate early wins and build momentum.

#### Strategic Bets (High Value + Low Feasibility)

| Use Case ID | Name | Business Value | Technical Feasibility | Rank | Wave |
|-------------|------|----------------|----------------------|------|------|
| UC-[X] | [Name] | [Score] | [Score] | 3 | Wave 2 |
| UC-[Y] | [Name] | [Score] | [Score] | 4 | Wave 2-3 |
| ... | ... | ... | ... | ... | ... |

**Recommendation**: **PLAN CAREFULLY** - High value justifies investment but requires:
- Proof of concept (PoC) to validate feasibility
- Risk mitigation planning (see [Risk Register](05-risk-register.md))
- Longer timeline and budget
- Consider breaking into phases

#### Fill-Ins (Low Value + High Feasibility)

| Use Case ID | Name | Business Value | Technical Feasibility | Rank | Wave |
|-------------|------|----------------|----------------------|------|------|
| UC-[X] | [Name] | [Score] | [Score] | 5 | Wave 3+ |
| UC-[Y] | [Name] | [Score] | [Score] | 6 | Wave 3+ |
| ... | ... | ... | ... | ... | ... |

**Recommendation**: **LOW PRIORITY** - Deliver only if:
- Capacity available after Quick Wins and Strategic Bets
- Bundled with higher-priority use cases
- Very low effort (e.g., <2 weeks)

#### Time Sinks (Low Value + Low Feasibility) ❌

| Use Case ID | Name | Business Value | Technical Feasibility | Rank | Wave |
|-------------|------|----------------|----------------------|------|------|
| UC-[X] | [Name] | [Score] | [Score] | - | Not recommended |
| UC-[Y] | [Name] | [Score] | [Score] | - | Not recommended |
| ... | ... | ... | ... | ... | ... |

**Recommendation**: **AVOID** - Not worth the effort. Consider:
- Parking for future re-evaluation
- Canceling entirely
- Revisiting if feasibility improves (e.g., new technology emerges)

---

## Section 5: Implementation Roadmap

### 5.1 Wave Planning

Based on the prioritization matrix, organize use cases into delivery waves:

#### Wave 1: Quick Wins (Months 1-9)

| Use Case | Business Value | Technical Feasibility | Build Duration | Expected ROI | Status |
|----------|----------------|----------------------|----------------|--------------|--------|
| UC-[X]: [Name] | [Score] | [Score] | [Months] | [%] | ⏳ Planned |
| UC-[Y]: [Name] | [Score] | [Score] | [Months] | [%] | ⏳ Planned |

**Wave 1 Objectives**:
- ✅ Generate early wins to build momentum
- ✅ Demonstrate value within 6-9 months
- ✅ Secure executive buy-in for subsequent waves
- ✅ Establish platform and patterns for reuse

**Wave 1 Timeline**: [Start Date] - [End Date]

#### Wave 2: Strategic Bets (Months 9-18)

| Use Case | Business Value | Technical Feasibility | Build Duration | Expected ROI | Status |
|----------|----------------|----------------------|----------------|--------------|--------|
| UC-[X]: [Name] | [Score] | [Score] | [Months] | [%] | ⏳ Planned |
| UC-[Y]: [Name] | [Score] | [Score] | [Months] | [%] | ⏳ Planned |

**Wave 2 Objectives**:
- ✅ Deliver high-value strategic use cases
- ✅ Leverage platform from Wave 1
- ✅ Build internal AI capability (CoE)
- ✅ Expand adoption across business units

**Wave 2 Timeline**: [Start Date] - [End Date]

#### Wave 3+: Fill-Ins (Months 18+)

| Use Case | Business Value | Technical Feasibility | Build Duration | Expected ROI | Status |
|----------|----------------|----------------------|----------------|--------------|--------|
| UC-[X]: [Name] | [Score] | [Score] | [Months] | [%] | ⏳ Backlog |
| UC-[Y]: [Name] | [Score] | [Score] | [Months] | [%] | ⏳ Backlog |

**Wave 3+ Objectives**:
- ✅ Deliver lower-priority use cases if capacity exists
- ✅ Continuous improvement of existing solutions
- ✅ Explore new AI opportunities

**Wave 3+ Timeline**: [Start Date] - Ongoing

### 5.2 Portfolio Roadmap

Visual timeline showing parallel and sequential delivery:

```
Month:  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18
        │                                                    │
Wave 1: ├──────────[UC-X]──────────┤
        │     ├─────────[UC-Y]─────────┤
        │                ├─────────[UC-Z]──────────┤
        │                                    │
Wave 2: │                           ├───────────[UC-A]─────────┤
        │                                 ├──────────[UC-B]──────────┤
        │                                                    │
Wave 3: │                                           ├────────[UC-C]────
        │                                                    │
```

**Key Milestones**:
- Month 3: First use case (UC-X) in production
- Month 6: Wave 1 midpoint review
- Month 9: Wave 1 complete, Wave 2 kickoff
- Month 12: Portfolio value review
- Month 18: Wave 2 complete, Wave 3 planning

### 5.3 Portfolio Value Projection

Cumulative financial impact across waves:

| Wave | Use Cases | Total Build Cost | Annual Benefit | Cumulative NPV (5yr) | Portfolio ROI |
|------|-----------|-----------------|----------------|---------------------|---------------|
| Wave 1 | [Count] | $[Amount] | $[Amount] | $[Amount] | [%] |
| Wave 2 | [Count] | $[Amount] | $[Amount] | $[Amount] | [%] |
| Wave 3+ | [Count] | $[Amount] | $[Amount] | $[Amount] | [%] |
| **TOTAL** | **[Count]** | **$[Amount]** | **$[Amount]** | **$[Amount]** | **[%]** |

**Portfolio Targets**:
- **Target Portfolio ROI**: >30%
- **Target NPV**: >$5M (5-year)
- **Target Payback**: <18 months (average)

---

## Section 6: Dependencies & Constraints

### 6.1 Cross-Use Case Dependencies

Identify dependencies between use cases that may impact sequencing:

| Upstream Use Case | Downstream Use Case | Dependency Type | Impact |
|-------------------|---------------------|-----------------|--------|
| UC-[X]: [Name] | UC-[Y]: [Name] | [Platform / Data / Model / Team] | [Description] |
| [Use Case] | [Use Case] | [Type] | [Impact] |

**Example Dependencies**:
- **Platform**: UC-02 requires platform built in UC-01
- **Data**: UC-03 needs data pipeline from UC-01
- **Model**: UC-04 can reuse model from UC-02
- **Team**: Same data science team across UC-01 and UC-02

### 6.2 Constraints

| Constraint Type | Description | Impact on Roadmap |
|-----------------|-------------|-------------------|
| **Budget** | [Total available budget] | [Limits number of parallel use cases] |
| **Team Capacity** | [Team size and skills] | [Limits parallelization] |
| **Data Availability** | [Data readiness by use case] | [May delay some use cases] |
| **Infrastructure** | [Platform readiness] | [Platform must be built first] |
| **Stakeholder Availability** | [Key sponsor calendars] | [May affect start dates] |
| **Regulatory** | [Compliance requirements] | [May extend timelines] |

---

## Section 7: Sensitivity Analysis

### 7.1 Scoring Sensitivity

Test how changes in key assumptions affect prioritization:

#### Scenario 1: Increase Strategic Alignment Weight

If strategic alignment (Metric 9) is weighted 2× in Business Value calculation:

| Use Case | Original Business Value | Adjusted Business Value | Change in Rank |
|----------|------------------------|------------------------|----------------|
| UC-[X] | [Score] | [Score] | [+/- positions] |
| ... | ... | ... | ... |

**Impact**: [Does prioritization change significantly?]

#### Scenario 2: Increase Risk Aversion

If risk (Metric 10) is weighted 2× in Technical Feasibility calculation:

| Use Case | Original Feasibility | Adjusted Feasibility | Change in Rank |
|----------|---------------------|---------------------|----------------|
| UC-[X] | [Score] | [Score] | [+/- positions] |
| ... | ... | ... | ... |

**Impact**: [Does prioritization change significantly?]

#### Scenario 3: ROI-Only Prioritization

Rank by ROI % (Metric 5) only:

| Use Case | ROI % | Rank (ROI-only) | Rank (11-Metric) | Difference |
|----------|-------|----------------|------------------|------------|
| UC-[X] | [%] | [Rank] | [Rank] | [+/- positions] |
| ... | ... | ... | ... | ... |

**Impact**: [Does ROI-only ranking differ from holistic 11-metric approach?]

**Recommendation**: [Which scenario best reflects business priorities?]

---

## Section 8: Executive Summary

### 8.1 Recommended Prioritization

**Top 3 Priority Use Cases** (Quick Wins for Wave 1):

#### 1. UC-[X]: [Use Case Name]

- **Business Value**: [Score/10] - [High/Medium/Low]
- **Technical Feasibility**: [Score/10] - [High/Medium/Low]
- **Quadrant**: Quick Win ⭐
- **Annual Benefit**: $[Amount]
- **ROI**: [%]
- **Payback**: [Months]
- **Timeline**: [Months to deliver]
- **Why prioritize**: [1-2 sentence rationale]

#### 2. UC-[Y]: [Use Case Name]

- **Business Value**: [Score/10]
- **Technical Feasibility**: [Score/10]
- **Quadrant**: Quick Win ⭐
- **Annual Benefit**: $[Amount]
- **ROI**: [%]
- **Payback**: [Months]
- **Timeline**: [Months to deliver]
- **Why prioritize**: [1-2 sentence rationale]

#### 3. UC-[Z]: [Use Case Name]

- **Business Value**: [Score/10]
- **Technical Feasibility**: [Score/10]
- **Quadrant**: Quick Win ⭐ or Strategic Bet
- **Annual Benefit**: $[Amount]
- **ROI**: [%]
- **Payback**: [Months]
- **Timeline**: [Months to deliver]
- **Why prioritize**: [1-2 sentence rationale]

### 8.2 Portfolio Summary

| Metric | Value |
|--------|-------|
| **Total Use Cases Evaluated** | [Number] |
| **Quick Wins Identified** | [Number] |
| **Strategic Bets** | [Number] |
| **Fill-Ins** | [Number] |
| **Time Sinks** | [Number] |
| **Recommended Wave 1 Use Cases** | [Number] |
| **Portfolio NPV (5-year)** | $[Amount] |
| **Portfolio ROI** | [%] |
| **Average Payback** | [Months] |

### 8.3 Decision Request

**Requested Decision**: Approve the following:

1. ✅ **Prioritization Matrix** - Accept 2×2 Business Value vs Technical Feasibility approach
2. ✅ **Wave 1 Use Cases** - Approve [X] use cases for immediate delivery
3. ✅ **Budget Allocation** - Approve $[Amount] for Wave 1 (Months 1-9)
4. ✅ **Wave 2 Planning** - Approve planning for [X] Strategic Bet use cases
5. ✅ **Roadmap** - Approve 18-month portfolio roadmap

**Approval Required From**:
- [ ] **Executive Sponsor**: [Name, Title]
- [ ] **CFO**: [Name] (Budget approval)
- [ ] **Business Owners**: [Names]
- [ ] **CIO/CTO**: [Name] (Technology approval)

**Decision Date**: [Date]

---

## Section 9: Next Steps

### 9.1 Immediate Actions (Week 1-2)

1. ✅ **Socialize prioritization** - Share matrix with stakeholders
2. ✅ **Executive review** - Present to steering committee
3. ✅ **Refine scores** - Incorporate feedback from stakeholders
4. ✅ **Approve Wave 1** - Secure decision on top 2-3 use cases
5. ✅ **Create detailed business cases** - Use [Business Case template](02-business-case.md) for each Wave 1 use case

### 9.2 Short-term (Month 1)

1. ✅ **Mobilize delivery team** - Assign PM, architects, engineers
2. ✅ **Detailed discovery** - For each Wave 1 use case, complete:
   - [Business Requirements](09-business-requirements-document.md)
   - [Data Assessment](10-data-assessment-report.md)
   - [Risk Register](05-risk-register.md)
   - [Project Charter](01-project-charter.md)
3. ✅ **Platform planning** - If shared platform needed, start [Setup Platform phase](../guides/setup-platform-complete-guide.md)
4. ✅ **Kickoff Wave 1** - Formal project kickoff for first use case

### 9.3 Medium-term (Months 2-3)

1. ✅ **Begin Wave 1 build** - Start development of first use case(s)
2. ✅ **Monitor portfolio** - Track actual vs projected value
3. ✅ **Plan Wave 2** - Detailed planning for Strategic Bet use cases
4. ✅ **Adjust roadmap** - Based on Wave 1 learnings

---

## Appendix A: Tools & Resources

### A.1 ROI Calculator

Use the **interactive ROI calculator** to calculate financial metrics:

🧮 **[ROI Calculator](../calculators/roi-calculator.html)**

**Inputs**:
- Baseline cost (current state)
- Annual benefit (future state)
- Implementation cost
- Ongoing cost
- Discount rate

**Outputs**:
- ROI %
- Payback period
- NPV (5-year)
- 5-year cash flow projection

### A.2 Related Templates

**Discovery & Assessment**:
- [Business Envisioning Pre-Work](13-business-envisioning-pre-work.md) (13)
- [Use Case Template](14-business-envisioning-use-case-template.md) (14)
- [Business Requirements](09-business-requirements-document.md) (09)
- [Data Assessment](10-data-assessment-report.md) (10)

**Financial Analysis**:
- [ROI Financial Analysis Module](shared-components/roi-financial-analysis.md) (Shared Component)
- [Business Case](02-business-case.md) (02)
- [Executive Decision Memo](15-executive-decision-memo.md) (15)

**Risk Assessment**:
- [Risk Library](shared-components/risk-library.md) (18 pre-defined AI risks)
- [Risk Register](05-risk-register.md) (05)

**Portfolio Management**:
- [Project Charter](01-project-charter.md) (01)
- [Project Plan/Roadmap](04-project-plan-roadmap.md) (04)
- [Success Criteria/KPIs](07-success-criteria-kpis.md) (07)

### A.3 Visual Templates

**Excel Template**: [Download Prioritization Matrix Template.xlsx](../tools/prioritization-matrix-template.xlsx)

**Miro Template**: [Prioritization Matrix Miro Board](https://miro.com/...) *(if available)*

---

## Appendix B: Example Scoring

### Example Use Case: Customer Churn Prediction

**Context**: Telecom company wants to predict customer churn to enable proactive retention.

| Metric | Score | Justification | Data Source |
|--------|-------|---------------|-------------|
| 1. Current-State Cost | 8 | $3M annual churn cost | Customer data analysis |
| 2. Future-State Benefit | 7 | $1.5M annual savings (50% churn reduction) | ROI calculator |
| 3. Build Cost | 8 | $250K implementation | Vendor quote |
| 4. Run Cost | 7 | $120K/year cloud + support | Azure pricing |
| 5. ROI % | 9 | 150% ROI | ROI calculator |
| 6. Payback Period | 9 | 10 months payback | ROI calculator |
| 7. NPV | 7 | $4.2M (5-year NPV) | ROI calculator |
| 8. TCO | 7 | $850K (5-year TCO) | ROI calculator |
| 9. Strategic Alignment | 8 | High - supports customer retention strategy | Executive input |
| 10. Risk Score | 7 | Moderate risk - good data but complex model | Risk assessment |
| 11. Scalability/Reusability | 6 | Some reuse potential for other retention models | Architecture review |
| **TOTAL SCORE** | **83/110** | **Average: 7.5/10** | **Percentage: 75%** |

**Business Value**: (8+7+9+9+7+8+6)/7 = **7.7/10**  
**Technical Feasibility**: (8+7+7+7)/4 = **7.25/10**

**Quadrant**: **Quick Win** ⭐ (High value + High feasibility)  
**Recommendation**: **Prioritize for Wave 1**

---

**Template Version**: 1.0  
**Document Owner**: Portfolio Management / PMO  
**Review Cycle**: Quarterly (re-score use cases based on learnings)  
**Last Updated**: January 13, 2026
