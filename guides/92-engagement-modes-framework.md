# AI Delivery Engagement Modes Framework

**Version**: 1.0  
**Last Updated**: January 13, 2026  
**Purpose**: Unified framework for selecting and executing AI delivery engagements across Pre-Sales, Reactive, and Proactive scenarios

---

## Executive Summary

This framework defines **three engagement modes** for AI delivery, each tailored to different client scenarios while leveraging the same unified methodology and templates.

**The Three Engagement Modes:**

1. **🎯 Pre-Sales Advisory** - Help clients evaluate, prioritize, and build business cases for AI opportunities
2. **🚨 Reactive Delivery** - Respond to specific client requests with defined scope and timeline
3. **🚀 Proactive Transformation** - Drive strategic AI adoption with comprehensive program delivery

**Key Principle**: Same methodology phases and templates, different entry points and engagement depth.

---

## 1. Engagement Modes Overview

### Mode Comparison Matrix

| Dimension | Pre-Sales Advisory | Reactive Delivery | Proactive Transformation |
|-----------|-------------------|-------------------|--------------------------|
| **Trigger** | Client exploring AI | Specific project request | Strategic AI initiative |
| **Duration** | 2-6 weeks | 3-9 months | 6-24 months |
| **Scope** | Discovery + Business Case | Single use case delivery | Portfolio of use cases |
| **Entry Point** | Business Envisioning | Any phase (often Build) | Discovery or Mobilisation |
| **Depth** | Advisory + Planning | Full delivery | Full delivery + CoE |
| **Deliverables** | Business case, ROI, roadmap | Working AI solution | Multiple solutions + governance |
| **Team Size** | 2-4 consultants | 4-8 delivery team | 8-20+ program team |
| **Revenue Model** | Fixed fee workshop/advisory | T&M or fixed price project | Program-based engagement |

### Visual Decision Flow

```
                    Client Need?
                         │
        ┌────────────────┼────────────────┐
        │                │                │
   Exploring AI?   Specific Project?  Strategic Initiative?
        │                │                │
        ▼                ▼                ▼
   PRE-SALES         REACTIVE         PROACTIVE
    Advisory          Delivery      Transformation
        │                │                │
   Discovery +      Full SDLC      Portfolio + CoE
   Business Case    (Build→Deploy)  (Discovery→Sustain)
```

---

## 2. Mode 1: Pre-Sales Advisory

### When to Use

✅ Client is **exploring AI** but hasn't committed to specific projects  
✅ Need to **build business case** for AI investment  
✅ Client wants to **prioritize** multiple AI opportunities  
✅ **ROI validation** required before project approval  
✅ Client needs **proof of value** before full engagement  

### Typical Entry Points

- Business Envisioning Workshop (cold start)
- Discovery phase only
- Use case prioritization
- ROI/Business case development

### Phases & Activities

| Phase | Activities | Duration | Deliverables |
|-------|-----------|----------|--------------|
| **Discovery** | Business Envisioning Workshop<br>Current-state assessment<br>Pain points identification<br>Opportunity mapping | 1-2 weeks | • Use case inventory (14)<br>• Current-state baseline<br>• Problem statements |
| **Prioritization** | Use case scoring (Value vs Feasibility)<br>ROI calculation (calculator tool)<br>Risk assessment (risk library)<br>Strategic alignment review | 1-2 weeks | • Prioritization matrix (19)<br>• ROI analysis per use case<br>• Risk summary |
| **Business Case** | Financial analysis (NPV, payback)<br>TCO modeling<br>Benefits quantification<br>Implementation roadmap | 1-2 weeks | • Business case (02)<br>• Executive decision memo (15)<br>• Project charter (01) |

**Total Duration**: 2-6 weeks  
**Key Templates**:
- [Business Envisioning Pre-Work](../templates/13-business-envisioning-pre-work.md) (13)
- [Use Case Template](../templates/14-business-envisioning-use-case-template.md) (14)
- [Prioritization Matrix](../templates/19-use-case-prioritization-matrix.md) (19) - NEW
- [ROI Calculator](../calculators/roi-calculator.html) (Interactive tool)
- [Business Case](../templates/02-business-case.md) (02)
- [Executive Decision Memo](../templates/15-executive-decision-memo.md) (15)

### Success Criteria

✅ Client has **data-driven prioritization** of AI opportunities  
✅ **Business case approved** with clear ROI (>20% typical target)  
✅ **Executive sponsorship** secured  
✅ **Decision to proceed** to Reactive or Proactive delivery  

### Transition Path

**If Approved** → Transition to:
- **Reactive Delivery** (single use case, fixed scope)
- **Proactive Transformation** (portfolio approach, strategic program)

**If Not Approved** → Park engagement:
- Maintain relationship for future opportunities
- Provide industry insights and benchmark data
- Re-engage when client readiness improves

---

## 3. Mode 2: Reactive Delivery

### When to Use

✅ Client has **specific AI project** with defined scope  
✅ **Business case already exists** or not required (tactical project)  
✅ Client requests **solution for known problem**  
✅ **Time-bound delivery** expected (e.g., 6-month project)  
✅ **Single use case** focus (not portfolio)  

### Typical Entry Points

- **Most common**: Build phase (client already completed discovery)
- Setup Platform (infrastructure needed)
- Test/Evaluate (PoC/pilot required)
- Integrate (existing model needs productionization)

### Phases & Activities

**Scenario A: Full Lifecycle (Discovery → Operate/Care)**

| Phase | Activities | Duration | Key Templates |
|-------|-----------|----------|---------------|
| **Discovery** | ✅ Requirements gathering<br>✅ Data assessment<br>✅ Feasibility validation | 2-4 weeks | Business Requirements (09)<br>Data Assessment (10) |
| **Setup Platform** | ✅ Infrastructure provisioning<br>✅ MLOps pipeline setup<br>✅ Security configuration | 3-6 weeks | Infrastructure (bicep templates) |
| **Build** | ✅ Model development<br>✅ Training & tuning<br>✅ Model documentation | 8-12 weeks | Model Card (17)<br>Dataset Datasheet (18) |
| **Test/Evaluate** | ✅ Model validation<br>✅ UAT<br>✅ Performance testing | 4-6 weeks | Test plan checklist |
| **Integrate** | ✅ API integration<br>✅ UI development<br>✅ End-to-end testing | 4-6 weeks | Integration checklist |
| **Prepare/Deploy** | ✅ Production deployment<br>✅ Monitoring setup<br>✅ User training | 2-4 weeks | Deployment checklist |
| **Operate/Care** | ✅ Hypercare support<br>✅ Performance monitoring<br>✅ Handover to BAU | 4-8 weeks | Success Criteria (07) |

**Total Duration**: 6-9 months (full lifecycle)

**Scenario B: Mid-Cycle Entry (e.g., Build phase only)**

Client already completed discovery/platform setup, engages for model development:

| Phase | Activities | Duration | Key Templates |
|-------|-----------|----------|---------------|
| **Build** | Model development from requirements | 8-12 weeks | Model Card (17) |
| **Test/Evaluate** | Validation & UAT | 4-6 weeks | Test checklist |
| **Integrate** | Production integration | 4-6 weeks | Integration checklist |
| **Prepare/Deploy** | Deployment | 2-4 weeks | Deployment checklist |

**Total Duration**: 4-6 months (build→deploy only)

### Key Characteristics

- **Fixed scope**: Single use case with defined requirements
- **Traditional SDLC**: Waterfall or agile sprints
- **Predictable timeline**: Known milestones and deliverables
- **Team structure**: Delivery team (PM, architects, engineers, data scientists)
- **Governance**: Project-level (not program)

### Success Criteria

✅ **Solution deployed** to production on time/budget  
✅ **Acceptance criteria met** (performance, accuracy, usability)  
✅ **Hypercare completed** and handed to BAU operations  
✅ **Value realization started** (benefits tracking initiated)  

### Transition Path

**After Delivery** → Potential expansion:
- **Sustain phase** continues with BAU team
- **New reactive engagement** for next use case (if portfolio exists)
- **Upgrade to Proactive** if client wants strategic AI program

---

## 4. Mode 3: Proactive Transformation

### When to Use

✅ Client wants **strategic AI adoption** across organization  
✅ **Multiple use cases** in pipeline (portfolio approach)  
✅ Client needs **AI Center of Excellence** (CoE) setup  
✅ **Enterprise-wide transformation** scope  
✅ **Long-term partnership** desired (12-24+ months)  
✅ Client has **executive sponsorship** and budget commitment  

### Typical Entry Points

- **Mobilisation** (program kickoff)
- **Discovery** (portfolio discovery for multiple use cases)
- Business Envisioning Workshop (enterprise-wide)

### Phases & Activities

**Program Structure** (12-24 months):

#### Wave 1: Foundation (Months 1-6)

| Phase | Activities | Duration | Deliverables |
|-------|-----------|----------|--------------|
| **Mobilisation** | Program charter<br>Governance setup<br>AI CoE design<br>Roadmap planning | 4-6 weeks | Project Charter (01)<br>RACI Matrix (03)<br>Roadmap (04)<br>Communication Plan (06) |
| **Discovery (Portfolio)** | Enterprise workshops<br>Multi-use case discovery<br>Portfolio prioritization<br>Wave planning | 6-8 weeks | Use case portfolio (19)<br>Prioritization matrix<br>Business cases (02) |
| **Setup Platform** | Enterprise AI platform<br>MLOps foundation<br>Data governance<br>Security framework | 8-12 weeks | Infrastructure as Code<br>Platform runbook<br>Governance policies |

#### Wave 2: First Use Cases (Months 3-12)

Parallel delivery of **2-3 high-priority use cases** using **Reactive Delivery** approach for each:

| Use Case | Phase Progress | Status |
|----------|---------------|--------|
| Use Case #1 (Quick Win) | Build → Deploy → Operate | Months 3-9 |
| Use Case #2 (Strategic) | Build → Deploy → Operate | Months 4-10 |
| Use Case #3 (Innovation) | Build → Test | Months 6-12 |

#### Wave 3: Scaling (Months 9-18)

| Phase | Activities | Duration | Deliverables |
|-------|-----------|----------|--------------|
| **CoE Operationalization** | Operating model<br>Self-service enablement<br>Citizen AI enablement<br>FinOps framework | 8-12 weeks | CoE Blueprint<br>FinOps guide<br>Training materials |
| **Next Wave Use Cases** | Use cases #4-6 delivery<br>Reuse components<br>Scale patterns | 6-9 months | 3+ additional solutions |

#### Wave 4: Sustain (Months 12-24+)

| Phase | Activities | Duration | Deliverables |
|-------|-----------|----------|--------------|
| **Operate/Care (Portfolio)** | Portfolio value tracking<br>Continuous optimization<br>New use case intake<br>Knowledge management | Ongoing | Value dashboard<br>Benefit realization reports<br>CoE metrics |

### Key Characteristics

- **Portfolio scope**: Multiple use cases delivered in waves
- **Program governance**: Steering committee, PMO, program management
- **CoE establishment**: Build internal AI capability
- **Reusable components**: Shared infrastructure, models, patterns
- **Strategic partnership**: Long-term engagement, continuous value delivery
- **FinOps integration**: Continuous cost optimization
- **Change management**: Enterprise-wide adoption and training

### Success Criteria

✅ **Portfolio value delivered**: Cumulative ROI >30% across use cases  
✅ **CoE operational**: Internal team can deliver use cases independently  
✅ **Platform adoption**: 5+ use cases running on shared platform  
✅ **Reusability**: 40%+ component reuse across use cases  
✅ **Executive satisfaction**: NPS >8, continued funding approved  
✅ **Cultural shift**: AI adoption embedded in business processes  

### Transition Path

**Steady State** → Ongoing relationship:
- **Sustain phase** continues with CoE team + our strategic advisory
- **New waves** planned based on roadmap and business priorities
- **Expansion to new business units** or regions
- **Advanced capabilities** (GenAI, multi-modal, etc.)

---

## 5. Mode Selection Decision Tree

### Step 1: Assess Client Maturity

```
Question 1: Does client have approved AI strategy?
├─ NO → Consider PRE-SALES ADVISORY
└─ YES → Continue to Step 2

Question 2: How many use cases in scope?
├─ 1 use case → Consider REACTIVE DELIVERY
├─ 2-3 use cases → REACTIVE or PROACTIVE (depends on Q3)
└─ 4+ use cases → PROACTIVE TRANSFORMATION

Question 3: Does client want to build internal AI capability?
├─ NO → REACTIVE DELIVERY (we deliver, they operate)
└─ YES → PROACTIVE TRANSFORMATION (build CoE)

Question 4: What is engagement duration commitment?
├─ <6 months → REACTIVE DELIVERY
├─ 6-12 months → REACTIVE or PROACTIVE
└─ 12+ months → PROACTIVE TRANSFORMATION
```

### Step 2: Validate Entry Criteria

#### Pre-Sales Advisory Entry Criteria

| Criteria | Required? | Notes |
|----------|-----------|-------|
| Executive sponsor identified | ✅ Yes | Need decision-maker access |
| Budget authority (for workshops) | ✅ Yes | Typically $50K-$150K |
| Willingness to share data | ✅ Yes | For baseline assessment |
| Strategic AI intent | ✅ Yes | Not just tactical automation |
| Decision timeline | ⚠️ Preferred | Ideally 2-3 month decision cycle |

#### Reactive Delivery Entry Criteria

| Criteria | Required? | Notes |
|----------|-----------|-------|
| Defined use case | ✅ Yes | Clear problem statement |
| Business case (or tactical approval) | ✅ Yes | Funding secured |
| Data availability | ✅ Yes | Training data exists or accessible |
| Acceptance criteria | ✅ Yes | Success metrics defined |
| Project timeline | ✅ Yes | Start/end dates agreed |
| Infrastructure access | ⚠️ Depends | May be in scope to build |

#### Proactive Transformation Entry Criteria

| Criteria | Required? | Notes |
|----------|-----------|-------|
| Executive sponsorship (C-level) | ✅ Yes | CEO, CDO, or CIO commitment |
| Multi-year budget commitment | ✅ Yes | Typically $2M-$10M+ |
| Strategic roadmap | ⚠️ Preferred | We can help build if missing |
| Change management buy-in | ✅ Yes | HR/Org Dev involvement |
| Governance structure | ⚠️ Preferred | We can help establish |
| Dedicated program team | ✅ Yes | Client + our team |

### Step 3: Select Optimal Mode

**Decision Matrix:**

| Client Scenario | Recommended Mode | Entry Point | Duration |
|-----------------|------------------|-------------|----------|
| "We're exploring AI, need help prioritizing" | 🎯 Pre-Sales Advisory | Business Envisioning | 2-6 weeks |
| "We have specific AI project approved" | 🚨 Reactive Delivery | Build or Discovery | 3-9 months |
| "We want to become AI-driven organization" | 🚀 Proactive Transformation | Mobilisation | 12-24 months |
| "Prove value first, then expand" | 🎯 Pre-Sales → 🚨 Reactive | Discovery → Build | 3-12 months |
| "We have budget for strategic initiative" | 🚀 Proactive Transformation | Mobilisation | 12-24 months |

---

## 6. Templates & Tools by Engagement Mode

### Pre-Sales Advisory Template Kit

**Phase 1: Discovery**
- ✅ [Business Envisioning Pre-Work](../templates/13-business-envisioning-pre-work.md) (13)
- ✅ [Use Case Template](../templates/14-business-envisioning-use-case-template.md) (14)
- ✅ [Presales Qualification](../templates/11-presales-qualification.md) (11)
- ✅ [Business Requirements](../templates/09-business-requirements-document.md) (09)

**Phase 2: Prioritization**
- ✅ [Prioritization Matrix](../templates/19-use-case-prioritization-matrix.md) (19) - **NEW**
- ✅ [ROI Calculator](../calculators/roi-calculator.html) (Interactive tool)
- ✅ [ROI Financial Analysis Module](../templates/shared-components/roi-financial-analysis.md) (Shared)
- ✅ [Risk Library](../templates/shared-components/risk-library.md) (Shared)

**Phase 3: Business Case**
- ✅ [Business Case](../templates/02-business-case.md) (02)
- ✅ [Executive Decision Memo](../templates/15-executive-decision-memo.md) (15)
- ✅ [Project Charter](../templates/01-project-charter.md) (01)

**Total Templates**: 10 (3 phases)

### Reactive Delivery Template Kit

**All phases**: Use full template library (18 templates)

**Most Critical**:
- ✅ [Project Charter](../templates/01-project-charter.md) (01)
- ✅ [Business Requirements](../templates/09-business-requirements-document.md) (09)
- ✅ [Data Assessment](../templates/10-data-assessment-report.md) (10)
- ✅ [RACI Matrix](../templates/03-raci-matrix.md) (03)
- ✅ [Risk Register](../templates/05-risk-register.md) (05)
- ✅ [Sprint Planning](../templates/12-sprint-planning-template.md) (12)
- ✅ [Model Card](../templates/17-model-card-template.md) (17)
- ✅ [Success Criteria/KPIs](../templates/07-success-criteria-kpis.md) (07)

**Total Templates**: 18+ (full library)

### Proactive Transformation Template Kit

**All templates** + Program-specific additions:

**Program Management**:
- ✅ [Project Charter](../templates/01-project-charter.md) (01) - Adapted for program
- ✅ [RACI Matrix](../templates/03-raci-matrix.md) (03) - Program-level roles
- ✅ [Project Plan/Roadmap](../templates/04-project-plan-roadmap.md) (04) - Multi-wave
- ✅ [Communication Plan](../templates/06-communication-plan.md) (06) - Stakeholder engagement
- ✅ [Stakeholder Analysis](../templates/08-stakeholder-analysis.md) (08) - Enterprise-wide

**Portfolio Management**:
- ✅ [Prioritization Matrix](../templates/19-use-case-prioritization-matrix.md) (19) - Portfolio view
- ✅ [Business Case](../templates/02-business-case.md) (02) - Per use case
- ✅ [Success Criteria/KPIs](../templates/07-success-criteria-kpis.md) (07) - Portfolio dashboard

**CoE Establishment**:
- ✅ [AI Center of Excellence Framework](../guides/ai-center-of-excellence-framework.md) (Guide)
- ⏳ **AI Governance Blueprint** (20) - **TO BE CREATED**
- ⏳ **Value Tracking Dashboard** - **TO BE CREATED**

**Total Templates**: 25+ (full library + program extensions)

---

## 7. Engagement Mode Transitions

### Pre-Sales → Reactive

**Trigger**: Business case approved, client ready for single use case delivery

**Transition Activities** (1-2 weeks):
1. ✅ **Confirm scope** from pre-sales business case
2. ✅ **Finalize contracts** (SOW, pricing, timeline)
3. ✅ **Mobilize delivery team** (assign PM, architect, engineers)
4. ✅ **Kickoff meeting** with full project team
5. ✅ **Update project charter** (01) with delivery details
6. ✅ **Establish governance** (RACI, communication plan)

**Key Handover Artifacts**:
- Business case (02) → Becomes project baseline
- Use case template (14) → Becomes requirements (09)
- ROI analysis → Becomes success criteria (07)
- Risk assessment → Becomes risk register (05)

### Pre-Sales → Proactive

**Trigger**: Strategic AI initiative approved, client wants portfolio approach

**Transition Activities** (2-4 weeks):
1. ✅ **Expand to program charter** - Multi-use case roadmap
2. ✅ **Establish program governance** - Steering committee, PMO
3. ✅ **Mobilize program team** - Program manager, delivery leads, CoE architects
4. ✅ **Create multi-wave roadmap** (04) - 12-24 month plan
5. ✅ **Detailed discovery** for Wave 1 use cases
6. ✅ **Platform strategy** - Shared infrastructure design

**Key Handover Artifacts**:
- Prioritization matrix (19) → Becomes program roadmap (04)
- Multiple business cases (02) → Wave planning
- ROI portfolio → Program success criteria (07)

### Reactive → Proactive

**Trigger**: After successful first project, client wants to expand to portfolio

**Transition Activities** (2-3 weeks):
1. ✅ **Showcase first project success** - Value realization proof
2. ✅ **Propose program expansion** - Portfolio business case
3. ✅ **Conduct portfolio discovery** - Identify next use cases
4. ✅ **Reposition engagement** - From project to program
5. ✅ **Establish CoE** - Internal capability building
6. ✅ **Platform strategy** - Reuse existing infrastructure

**Key Consideration**: Leverage delivered solution as **proof point** for broader adoption

---

## 8. Best Practices by Mode

### Pre-Sales Advisory Best Practices

✅ **Focus on business value**, not technical details  
✅ **Use interactive ROI calculator** in workshops for immediate impact  
✅ **Bring industry benchmarks** to validate opportunity size  
✅ **Create sense of urgency** - competitive landscape, missed opportunities  
✅ **Executive storytelling** - Use case narratives that resonate  
✅ **Leave artifacts** - Client keeps templates, analysis, tools  
✅ **Clear next steps** - Decision timeline, approval process, transition plan  

### Reactive Delivery Best Practices

✅ **Start with clear requirements** - Ambiguity is the enemy  
✅ **Agile sprints** - 2-week iterations with demos  
✅ **Early PoC** - Validate feasibility in first 4-6 weeks  
✅ **Risk-driven** - Use risk library, weekly risk reviews  
✅ **Stakeholder engagement** - Use persona library for targeted communication  
✅ **Documentation discipline** - Model cards, datasheets, runbooks  
✅ **Hypercare planning** - 4-8 weeks post-deployment support  

### Proactive Transformation Best Practices

✅ **Program governance** - Steering committee, monthly executive reviews  
✅ **Wave-based delivery** - Parallelize use cases, share learnings  
✅ **Quick wins first** - Deliver value in Wave 1 (months 3-9)  
✅ **Reusability focus** - Build once, reuse across use cases (40% target)  
✅ **CoE early** - Start capability building in Wave 1  
✅ **Change management** - Dedicated workstream, communication cadence  
✅ **Portfolio value tracking** - Quarterly value reviews, benefit realization  
✅ **FinOps discipline** - Cost optimization from day 1  
✅ **Knowledge transfer** - Train internal team to self-sustain  

---

## 9. Success Metrics by Mode

### Pre-Sales Advisory Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| **Conversion rate** | 60%+ | Business cases approved → Delivery engagement |
| **Time to decision** | 2-3 months | Workshop → Contract signed |
| **Business case ROI** | 20%+ | NPV positive, payback <18 months |
| **Client satisfaction** | NPS 8+ | Post-workshop survey |
| **Use case quality** | 5+ use cases | Discovery workshops identify portfolio |

### Reactive Delivery Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| **On-time delivery** | 90%+ | Projects delivered within ±10% timeline |
| **On-budget delivery** | 95%+ | Projects within ±5% budget |
| **Acceptance criteria met** | 100% | All success criteria (07) achieved |
| **Client satisfaction** | NPS 8+ | Post-delivery survey |
| **Value realization** | 80%+ | Actual vs projected benefits (12 months) |

### Proactive Transformation Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| **Portfolio ROI** | 30%+ | Cumulative NPV across all use cases |
| **Use cases delivered** | 5+ in 12 months | Wave 1-2 completions |
| **Platform adoption** | 80%+ | Use cases on shared platform |
| **Component reuse** | 40%+ | Infrastructure, models, code reused |
| **CoE maturity** | Level 3+ | Self-sustaining capability |
| **Client satisfaction** | NPS 9+ | Executive sponsor satisfaction |
| **Renewal rate** | 90%+ | Program extended beyond initial term |

---

## 10. Tools & Resources

### Interactive Tools

- 🧮 **[ROI Calculator](../calculators/roi-calculator.html)** - NPV, ROI, payback, 5-year projections
- 📊 **Prioritization Matrix Template** (Excel) - 2×2 Business Value vs Feasibility
- 📈 **Value Tracking Dashboard** (Power BI) - Portfolio value monitoring

#### How to Use the ROI Calculator

The interactive ROI Calculator helps quantify AI project returns with comprehensive financial analysis including **Total Cost of Ownership (TCO)**, **payback period**, **NPV**, and **IRR**.

**📋 Step-by-Step Guide**:

1. **Access the Calculator**
   - Navigate to [ROI Calculator](https://andreaswasita.github.io/AI-Delivery-Methodology/calculators/roi-calculator.html)
   - No login required, all calculations run client-side (data not stored)

2. **Enter Initial Investment Costs**
   - **Initial Development Cost**: Model development, implementation services ($200K-$2M typical)
   - **Data Preparation Cost**: Data cleansing, migration, labeling ($50K-$500K)
   - **Change Management Cost**: Training, communications, adoption programs ($50K-$300K)
   
   *Example*: $800K development + $150K data prep + $100K change management = **$1.05M initial**

3. **Enter Ongoing Annual Costs**
   - **Infrastructure Cost**: Cloud compute, storage, networking ($50K-$500K/year)
   - **Maintenance Cost**: Support, monitoring, operations team ($100K-$500K/year)
   - **License Cost**: Software licenses, AI services, tools ($20K-$200K/year)
   
   *Example*: $180K infra + $250K maintenance + $60K licenses = **$490K annual**

4. **Quantify Annual Benefits**
   - **Cost Savings**: Labor efficiency, process automation, error reduction
     - *Example*: 500 users × 4 hrs/week saved × $50/hr × 52 weeks = **$5.2M/year**
   - **Revenue Increase**: Conversion improvements, new capabilities, faster time-to-market
     - *Example*: 2% conversion lift × 100K leads × $1K value = **$2M/year**
   - **Risk Reduction**: Compliance penalties avoided, fraud prevention, downtime reduction
     - *Example*: 10% risk reduction × $5M potential penalty = **$500K/year**
   
   *Total Annual Benefit Example*: $5.2M + $2M + $500K = **$7.7M/year**

5. **Set Analysis Parameters**
   - **Benefit Growth Rate**: Annual increase in benefits (typically 3-10%)
     - Use 5-8% for mature solutions
     - Use 10-15% for adoption ramp-up scenarios
   - **Discount Rate**: Organizational hurdle rate (typically 8-12%)
     - Use 10% as standard for AI projects (accounts for tech risk)
     - Use 12-15% for conservative analysis
   - **Time Horizon**: Analysis period (typically 3-5 years)
     - Use 5 years as standard
     - Use 3 years for conservative/faster payback scenarios

6. **Review Calculated Results**
   
   The calculator automatically computes:
   
   | Metric | What It Means | Decision Criteria |
   |--------|---------------|-------------------|
   | **ROI %** | Return on Investment percentage | Target: >200% for AI projects |
   | **Payback Period** | Months until investment recovered | Target: <24 months preferred |
   | **NPV (Net Present Value)** | Time-value adjusted returns | Must be positive to approve |
   | **IRR (Internal Rate of Return)** | Effective rate of return | Must exceed hurdle rate (10%) |
   | **Year-by-Year Cash Flow** | Annual net benefit tracking | Shows benefit realization pattern |
   | **Cumulative Cash Flow** | Running total of net benefits | Shows when breakeven occurs |

7. **Run Sensitivity Analysis**
   
   Test multiple scenarios to understand risk:
   
   - **Best Case**: Increase benefits by 20%, decrease costs by 10%
   - **Base Case**: Use realistic estimates (your primary inputs)
   - **Worst Case**: Decrease benefits by 20%, increase costs by 10%
   
   *If worst case still shows positive NPV and acceptable payback, project has **low financial risk***

8. **Export Results**
   - Click "Export to PDF" for executive presentations
   - Click "Export to Excel" for detailed financial modeling
   - Screenshot the results table for PowerPoint slides
   - Copy metrics directly into [Business Case Template](../templates/02-business-case.md) Section 5

**💡 Best Practices**:

- ✅ **Use Conservative Estimates**: Better to under-promise and over-deliver
- ✅ **Include Contingency**: Add 15% to cost estimates for unknowns
- ✅ **Model Ramp-Up**: Year 1 benefits typically 60-70% of full run-rate
- ✅ **Document Assumptions**: Keep notes on how you calculated each input
- ✅ **Validate with Finance**: Review discount rate and benefit calculations with CFO
- ✅ **Update Quarterly**: Track actual vs. projected in [Success Criteria](../templates/07-success-criteria-kpis.md)

**🎯 When to Use**:

| Engagement Mode | Calculator Usage | Purpose |
|----------------|------------------|---------|
| **Pre-Sales Advisory** | During prioritization phase | Compare ROI across multiple use cases |
| **Reactive Delivery** | During discovery/planning | Build business case for single project |
| **Proactive Transformation** | Wave planning | Evaluate portfolio-level returns |
| **Executive Workshops** | Live during sessions | Real-time "what-if" scenario modeling |
| **Business Case Development** | Final financial analysis | Generate numbers for [Business Case](../templates/02-business-case.md) |

**📊 Example Calculation**:

*Customer Service Chatbot Use Case*

**Inputs**:
- Initial: $1.2M (dev) + $150K (data) + $100K (change) = **$1.45M**
- Annual Costs: $180K (infra) + $200K (ops) + $50K (licenses) = **$430K/year**
- Annual Benefits: $2.5M (labor savings) + $800K (revenue) = **$3.3M/year**
- Parameters: 5% growth, 10% discount rate, 5-year horizon

**Results**:
- **ROI**: 285%
- **Payback**: 11 months
- **NPV @ 10%**: $9.8M
- **IRR**: 127%
- **Decision**: ✅ **APPROVE** - All metrics exceed targets

**📖 Additional Resources**:

- Detailed ROI methodology: [ROI & Financial Analysis Module](../templates/shared-components/roi-financial-analysis.md)
- Pre-populated examples: See Section 2.1 and 3.1 of ROI module
- Excel formulas: Section 10 of ROI module for offline calculations
- Benefit quantification guidance: Section 6 of ROI module

### Complete Guides

**Pre-Sales Advisory**:
- 📖 [Business Envisioning Workshop Guide](business-envisioning-workshop-guide.md)
- 📖 [Presales Discovery Activities](presales-discovery-activities-for-presentations.md)
- 📖 [Executive Coaching Guide](executive-coaching-guide.md)

**Reactive Delivery**:
- 📖 [Build Phase Complete Guide](build-phase-complete-guide.md)
- 📖 [Test/Evaluate Phase Complete Guide](test-evaluate-phase-complete-guide.md)
- 📖 [Prepare/Deploy Phase Complete Guide](prepare-deploy-phase-complete-guide.md)
- 📖 [Integrate Phase Complete Guide](integrate-phase-complete-guide.md)
- 📖 [MLOps/DevOps Complete Guide](mlops-devops-complete-guide.md)

**Proactive Transformation**:
- 📖 [Mobilisation Complete Guide](mobilisation-complete-guide.md)
- 📖 [AI Center of Excellence Framework](ai-center-of-excellence-framework.md)
- 📖 [AI Scaling Patterns Guide](ai-scaling-patterns-guide.md)
- 📖 [Operate/Care Phase Complete Guide](operate-care-phase-complete-guide.md)

### Accelerators

- ⚡ **[3-Month Fast Track Guide](3-month-fast-track-guide.md)** - Compressed delivery for quick wins
- ⚡ **[Hackathons Complete Guide](hackathons-complete-guide.md)** - Rapid prototyping approach
- ⚡ **Infrastructure as Code** - [Bicep templates](../infrastructure/bicep/) for Azure deployment

---

## 11. Frequently Asked Questions

### Q1: Can we mix engagement modes within same client?

**A**: Yes, very common pattern:
- Start with **Pre-Sales Advisory** to build business case
- Transition to **Reactive Delivery** for first use case (proof point)
- Expand to **Proactive Transformation** once value demonstrated

### Q2: What if client enters mid-phase (e.g., Build phase)?

**A**: Use **Reactive Delivery** mode:
- Conduct rapid discovery (1-2 weeks) to baseline existing work
- Fill gaps in requirements, data assessment, risk register
- Proceed with Build phase using standard templates

### Q3: How do we price each engagement mode?

**A**: Typical pricing models:

| Mode | Pricing Model | Range |
|------|--------------|-------|
| Pre-Sales Advisory | Fixed fee per workshop | $50K-$150K |
| Reactive Delivery | T&M or Fixed Price | $500K-$2M |
| Proactive Transformation | Program-based (annual) | $2M-$10M+ |

### Q4: What if client wants CoE but only 1 use case budget?

**A**: **Hybrid approach**:
- Use **Reactive Delivery** for first use case
- Include CoE design activities (10-15% of budget)
- Build platform with reusability in mind
- Propose **Proactive Transformation** expansion after delivery

### Q5: Can we do Pre-Sales Advisory for free to win larger deal?

**A**: **Not recommended** - devalues consulting:
- Offer **Executive Briefing** (1-2 hours) for free
- Charge for **Business Envisioning Workshop** (1-2 days)
- Position as "investment in partnership"
- Credit pre-sales fees toward delivery contract

### Q6: How do we track engagement mode metrics?

**A**: Use [Success Criteria/KPIs template](../templates/07-success-criteria-kpis.md) (07):
- Pre-Sales: Track conversion rate, time to decision
- Reactive: Track on-time/budget, acceptance criteria
- Proactive: Track portfolio ROI, CoE maturity, use case velocity

---

## 12. Next Steps

### For Delivery Teams

1. ✅ **Review this framework** - Understand all 3 engagement modes
2. ✅ **Assess current engagements** - Classify into Pre-Sales, Reactive, or Proactive
3. ✅ **Apply decision tree** - For new opportunities, select optimal mode
4. ✅ **Use mode-specific templates** - Follow prescribed template kits
5. ✅ **Track mode metrics** - Measure success by mode-specific KPIs

### For Sales/Pre-Sales Teams

1. ✅ **Qualify opportunities** using decision tree (Section 5)
2. ✅ **Position Pre-Sales Advisory** as value-add (not free consulting)
3. ✅ **Articulate transition paths** - Show progression to larger engagements
4. ✅ **Use ROI calculator** in client conversations
5. ✅ **Share case studies** by engagement mode

### For Leadership

1. ✅ **Communicate framework** to all delivery teams
2. ✅ **Update proposals** to reflect engagement modes
3. ✅ **Track portfolio mix** - Balance across modes
4. ✅ **Refine pricing** by mode and maturity
5. ✅ **Measure effectiveness** - Mode conversion rates, satisfaction

---

## Appendix A: Engagement Mode Examples

### Example 1: Pre-Sales Advisory → Reactive

**Client**: Regional bank exploring AI for fraud detection

**Phase 1: Pre-Sales Advisory** (4 weeks)
- Business Envisioning Workshop identified 8 use cases
- Prioritization matrix ranked fraud detection #1 (High Value + High Feasibility)
- ROI calculator showed $2.5M annual benefit, 14-month payback
- Business case approved by CFO

**Phase 2: Reactive Delivery** (7 months)
- Discovery → Build → Test → Deploy
- Delivered fraud detection model with 92% accuracy
- Deployed to production, processing 50K transactions/day
- Actual benefit: $2.1M (84% of projected)

**Outcome**: ✅ Success - Client requesting engagement for use case #2 (credit risk)

### Example 2: Proactive Transformation

**Client**: Manufacturing company with strategic AI initiative

**Wave 1: Foundation** (Months 1-6)
- Mobilisation: Program charter, governance, CoE design
- Discovery: Identified 12 use cases across quality, supply chain, maintenance
- Platform: Azure ML platform with MLOps pipelines

**Wave 2: First Use Cases** (Months 3-12)
- Use Case #1: Predictive maintenance (delivered Month 9)
- Use Case #2: Quality defect detection (delivered Month 10)
- Use Case #3: Demand forecasting (delivered Month 12)

**Wave 3: Scaling** (Months 9-18)
- CoE operational with 6 internal data scientists
- Use Cases #4-6 delivered by internal team with our coaching
- Platform hosting 8 models, 40% component reuse achieved

**Outcome**: ✅ Success - $8M cumulative value, 35% portfolio ROI, program renewed for Year 2

### Example 3: Reactive → Proactive Transition

**Client**: Retail company with single AI chatbot project

**Phase 1: Reactive Delivery** (6 months)
- Built customer service chatbot (Build → Deploy)
- Delivered 70% automation rate, $500K annual savings
- Exceeded acceptance criteria, high client satisfaction

**Phase 2: Expansion Opportunity** (Month 7)
- Showcased chatbot success to executive team
- Proposed portfolio approach: 4 additional AI use cases
- Client approved $3M program for 18-month transformation

**Phase 3: Proactive Transformation** (Months 8-24)
- Established AI CoE with 4 internal team members
- Delivered use cases #2-5 in Waves 2-3
- Platform now supports 6 solutions, $2.5M cumulative value

**Outcome**: ✅ Success - Single project became strategic partnership, 4× revenue expansion

---

**Document Owner**: Delivery Methodology Team  
**Review Cycle**: Quarterly  
**Last Updated**: January 13, 2026  
**Version**: 1.0
