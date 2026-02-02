# Benefits Dependency Network (BDN) Template

## Overview

The Benefits Dependency Network is a critical tool for identifying and mapping the business changes required to realize benefits from AI investments. It ensures that we don't just focus on technology enablers, but explicitly plan for the organizational and process changes needed to achieve business objectives.

**Key Principle:** Technology alone doesn't deliver value - business change delivers value.

---

## Benefits Dependency Network Framework

```
IT Enablers → Enabling Changes → Business Changes → Benefits → Investment Objectives → Business Drivers
```

### Framework Components

1. **Business Drivers**: Strategic imperatives driving the initiative (e.g., ageing population, cost pressures, competition)
2. **Investment Objectives**: Specific goals this investment must achieve (e.g., SO1: Deliver timely response, SO2: Provide quality care)
3. **Benefits**: Measurable outcomes (e.g., saving lives, responsive service, operational efficiencies)
4. **Business Changes**: How people work differently (e.g., effective communication, improved access to information, innovation/faster adoption)
5. **Enabling Changes**: Supporting organizational changes (e.g., smarter meetings, communication & engagement, work from anywhere)
6. **IT Enablers/Technology**: Technology components (e.g., Exchange Online, SharePoint, Skype, Yammer, PowerBI)

---

## Use Case BDN Template

### Use Case: [Use Case Title]

**Use Case ID:** [UC-XXX]  
**Date:** [DD/MM/YYYY]  
**Owner:** [Name]

---

### 1. Business Drivers

*What strategic forces are driving this initiative?*

| Driver ID | Business Driver | Description | Impact Level |
|-----------|----------------|-------------|--------------|
| BD-01 | [e.g., Ageing Population] | [Growing elderly population requiring more healthcare services] | High |
| BD-02 | [e.g., Cost Efficiency Pressures] | [Government/board pressure to reduce operational costs] | High |
| BD-03 | [e.g., Competition/Market Forces] | [Competitors adopting AI, risk of losing market share] | Medium |
| BD-04 | [e.g., Regulatory Requirements] | [New regulations requiring faster response times] | High |
| BD-05 | [e.g., Customer Expectations] | [Rising customer demand for 24/7 service] | Medium |

---

### 2. Investment Objectives

*What specific objectives must this AI investment achieve?*

| Objective ID | Investment Objective | Success Criteria | Owner |
|--------------|---------------------|------------------|-------|
| SO1 | [e.g., Deliver timely response to patients] | [<2 hour response time, 95% on-time] | [Name] |
| SO2 | [e.g., Provide quality patient care] | [Patient satisfaction >90%, error rate <2%] | [Name] |
| SO3 | [e.g., Deliver effective and efficient ambulance services] | [10% cost reduction, 15% productivity increase] | [Name] |
| SO4 | [e.g., Adapt models of service to future needs] | [System can scale 2x without rearchitecture] | [Name] |
| SO5 | [e.g., Build strong stakeholder partnerships] | [>80% stakeholder satisfaction, active engagement] | [Name] |

---

### 3. Benefits

*What measurable benefits will be realized?*

| Benefit ID | Benefit | Measurement | Baseline | Target | Investment Objective Link |
|------------|---------|-------------|----------|--------|--------------------------|
| B-01 | [e.g., Saving Lives] | [Mortality rate reduction] | [5%] | [2%] | SO1, SO2 |
| B-02 | [e.g., Responsive Service] | [Average response time] | [4 hours] | [30 min] | SO1 |
| B-03 | [e.g., Quality Service] | [Service quality score] | [75%] | [95%] | SO2 |
| B-04 | [e.g., Operational Efficiencies] | [Cost per transaction] | [$50] | [$30] | SO3 |
| B-05 | [e.g., Patient Satisfaction] | [NPS score] | [45] | [75] | SO2 |
| B-06 | [e.g., Safe and Engaged Workforce] | [Employee engagement score] | [65%] | [85%] | SO5 |
| B-07 | [e.g., Better Decisions] | [Decision accuracy improvement] | [80%] | [95%] | SO4 |

---

### 4. Business Changes

*What must change in how people work to realize the benefits?*

**Critical Success Factor:** These are NOT technology changes - these are changes in behaviors, processes, and ways of working.

| Change ID | Business Change | Description | Impacted Stakeholders | Benefit Link | Change Readiness |
|-----------|----------------|-------------|----------------------|--------------|------------------|
| BC-01 | [e.g., Effective Communication and Engagement Capability] | [Staff adopts collaborative tools for real-time communication across departments] | [All staff - 500 people] | B-02, B-06 | Medium |
| BC-02 | [e.g., Improved Access to Information] | [Clinicians access patient data instantly via mobile, no paper lookup] | [Clinical staff - 200 people] | B-01, B-02, B-03 | Low |
| BC-03 | [e.g., Innovation/Faster Adoption of Technology] | [Teams experiment with AI features, 80% adoption within 6 months] | [All staff] | B-04, B-07 | High |
| BC-04 | [e.g., Timely, Evidence-Based Decision Making] | [Managers use AI insights for daily decisions, not gut feel] | [Management - 50 people] | B-07 | Medium |
| BC-05 | [e.g., Leverage ICT Investment / Cost Effective IT] | [Decommission 3 legacy systems, consolidate to cloud platform] | [IT team - 20 people] | B-04 | High |

---

### 5. Enabling Changes

*What organizational changes enable the business changes?*

| Enabler ID | Enabling Change | Description | Business Change Link | Owner | Status |
|------------|----------------|-------------|---------------------|-------|--------|
| EC-01 | [e.g., Smarter Meetings] | [Adopt virtual meeting culture, reduce travel time 60%] | BC-01, BC-03 | [Name] | Not Started |
| EC-02 | [e.g., Communication & Engagement] | [Deploy internal comms platform, weekly AI tips, champions network] | BC-01, BC-03 | [Name] | Not Started |
| EC-03 | [e.g., Work from Anywhere] | [Remote work policy, secure mobile access to all systems] | BC-02, BC-01 | [Name] | Not Started |
| EC-04 | [e.g., Capability Development] | [AI literacy program: 40 hours training per person] | BC-03, BC-04 | [Name] | Not Started |
| EC-05 | [e.g., Business Intelligence & Decision Making] | [Deploy BI dashboards, train managers on data-driven decisions] | BC-04, BC-05 | [Name] | Not Started |
| EC-06 | [e.g., Forms & Workflow] | [Digitize 15 paper forms, implement digital approval workflows] | BC-02, BC-05 | [Name] | Not Started |
| EC-07 | [e.g., Administration Blueprint] | [Define new roles: AI Steward, Data Analyst, Process Owner] | BC-03, BC-04, BC-05 | [Name] | Not Started |

---

### 6. IT Enablers / Enabling Technology

*What technology components enable the organizational changes?*

| Technology ID | Enabling Technology | Purpose | Enabling Change Link | Azure Service | Cost Estimate |
|---------------|-------------------|---------|---------------------|---------------|---------------|
| TE-01 | [e.g., Exchange Online] | [Email, calendar, secure communication] | EC-01, EC-02 | [Microsoft 365] | [$5/user/month] |
| TE-02 | [e.g., SharePoint Online] | [Document management, collaboration, knowledge base] | EC-02, EC-03, EC-06 | [Microsoft 365] | [Included] |
| TE-03 | [e.g., OneDrive for Business] | [File storage, sync, mobile access] | EC-03 | [Microsoft 365] | [Included] |
| TE-04 | [e.g., Skype for Business / Teams] | [Video meetings, instant messaging, screen sharing] | EC-01, EC-02, EC-03 | [Microsoft 365] | [Included] |
| TE-05 | [e.g., Yammer] | [Enterprise social network, communities, engagement] | EC-02 | [Microsoft 365] | [Included] |
| TE-06 | [e.g., OneNote] | [Digital notebooks, meeting notes, collaboration] | EC-01, EC-02 | [Microsoft 365] | [Included] |
| TE-07 | [e.g., PowerBI] | [Business intelligence, dashboards, data visualization] | EC-05 | [Power BI Premium] | [$20/user/month] |
| TE-08 | [e.g., Office Mix] | [Training content creation, e-learning] | EC-04 | [Microsoft 365] | [Included] |
| TE-09 | [e.g., Sway] | [Digital storytelling, reports, presentations] | EC-02 | [Microsoft 365] | [Included] |
| TE-10 | [e.g., Office 365 Video] | [Video hosting, streaming, knowledge sharing] | EC-02, EC-04 | [Stream] | [Included] |
| TE-11 | [e.g., Outlook] | [Email client, task management, calendar] | EC-01, EC-06 | [Microsoft 365] | [Included] |
| TE-12 | [e.g., InfoPath / Power Apps] | [Digital forms, workflows, approvals] | EC-06 | [Power Apps] | [$10/user/month] |
| TE-13 | [e.g., Word / Excel / PowerPoint] | [Document creation, analysis, presentations] | EC-02, EC-05, EC-06 | [Microsoft 365] | [Included] |
| TE-14 | [e.g., Azure OpenAI Service] | [Generative AI, document processing, chatbots] | EC-02, EC-04, EC-06 | [Azure OpenAI] | [Usage-based] |
| TE-15 | [e.g., Azure Cognitive Search] | [Intelligent search across all documents and data] | EC-02 | [Azure Cognitive Search] | [$250/month] |
| TE-16 | [e.g., Office Online] | [Browser-based Office apps, no local install] | EC-03 | [Microsoft 365] | [Included] |

---

## BDN Dependency Mapping

### Visual Representation

```
Business Drivers (External Forces)
         ↓
Investment Objectives (What we must achieve)
         ↓
Benefits (Measurable outcomes)
         ↓
Business Changes (How people work differently) ← The KEY to value realization
         ↑
Enabling Changes (Organizational support)
         ↑
IT Enablers (Technology components)
```

### Dependency Rules

1. **Each Benefit** must link to at least one **Investment Objective**
2. **Each Benefit** must be enabled by at least one **Business Change**
3. **Each Business Change** must be supported by at least one **Enabling Change**
4. **Each Enabling Change** must be supported by at least one **IT Enabler**
5. **No orphaned items** - every element must connect to the chain

---

## Critical Analysis Questions

### For Each Use Case, Ask:

#### 1. Business Change Identification
- ✅ **Have we identified ALL required business process changes?**
  - What processes must change?
  - How will people work differently?
  - What behaviors must change?

- ✅ **Are business changes realistic and achievable?**
  - Do people have capacity for change?
  - Is change readiness assessed?
  - Are there too many simultaneous changes?

#### 2. Enabling Change Sufficiency
- ✅ **Are enabling changes sufficient to support business changes?**
  - Is training adequate?
  - Are new roles and responsibilities defined?
  - Is governance in place?

- ✅ **Have we planned for change resistance?**
  - Who will resist and why?
  - What's our mitigation strategy?
  - Do we have executive sponsorship?

#### 3. Technology Alignment
- ✅ **Does technology enable (not dictate) business change?**
  - Are we starting with business need, not technology?
  - Can technology support required business changes?
  - Are there technology gaps?

#### 4. Benefits Realization
- ✅ **Can we realize benefits without business change?**
  - Answer should be NO
  - If YES, you haven't identified real business changes

- ✅ **Are benefits measurable and owned?**
  - Who owns each benefit?
  - How will we measure?
  - When will benefits be realized?

---

## BDN Workshop Facilitation Guide

### Workshop Agenda (3 hours)

#### Part 1: Understanding (30 min)
- Explain BDN concept and framework
- Show examples from similar projects
- Emphasize: "Technology enables, but business change delivers value"

#### Part 2: Working Backwards (60 min)
Start from the top and work down:
1. **Business Drivers** (10 min) - What forces are driving this?
2. **Investment Objectives** (15 min) - What must we achieve?
3. **Benefits** (20 min) - What measurable outcomes?
4. **Business Changes** (15 min) - How must people work differently?

#### Part 3: Working Forwards (60 min)
Start from the bottom and work up:
1. **IT Enablers** (15 min) - What technology do we need?
2. **Enabling Changes** (20 min) - What organizational changes support business change?
3. **Link Business Changes to Benefits** (15 min) - Validate dependencies
4. **Link Benefits to Objectives** (10 min) - Validate alignment

#### Part 4: Validation (30 min)
- Check all dependencies
- Identify gaps and orphans
- Validate change readiness
- Assign ownership for each element

---

## Example: Healthcare Patient Record System

### Business Drivers
- BD-01: Ageing population (65+ growing 5% annually)
- BD-02: Cost pressures (budget cuts, efficiency mandates)
- BD-03: Patient safety regulations (faster diagnosis requirements)

### Investment Objectives
- SO1: Deliver timely response to patients (<2 hour triage)
- SO2: Provide quality patient care (>95% accuracy)
- SO3: Reduce operational costs (20% efficiency gain)

### Benefits
- B-01: Saving Lives (30% reduction in critical delays)
- B-02: Responsive Service (average wait time: 4 hours → 30 min)
- B-03: Operational Efficiencies ($5M annual cost savings)

### Business Changes
- BC-01: **Effective Communication** - Clinicians use mobile app for real-time patient data access (not phone calls)
- BC-02: **Improved Access to Information** - Nurses access full patient history instantly (not paper charts)
- BC-03: **Timely, Evidence-Based Decision Making** - Doctors use AI-generated differential diagnosis (not only experience)

### Enabling Changes
- EC-01: **Smarter Meetings** - Daily huddles via Teams (not in-person)
- EC-02: **Capability Development** - 40-hour AI literacy program for 200 clinical staff
- EC-03: **Work from Anywhere** - Secure mobile access to patient records
- EC-04: **Administration Blueprint** - New role: Clinical AI Steward (oversee AI recommendations)

### IT Enablers
- TE-01: Azure OpenAI Service (AI-powered differential diagnosis)
- TE-02: Power Apps (mobile patient record app)
- TE-03: Microsoft Teams (communication platform)
- TE-04: Azure API Management (integrate 7 legacy systems)
- TE-05: Azure Cognitive Search (search patient history)

### Dependency Flow
```
Ageing Population (BD-01) 
  → Deliver timely response (SO1) 
    → Responsive Service (B-02) 
      → Improved Access to Information (BC-02) 
        → Work from Anywhere (EC-03) 
          → Power Apps mobile app (TE-02)
```

---

## Risk Assessment: Business Change Readiness

For each Business Change, assess:

| Risk Factor | Score (1-5) | Comments | Mitigation |
|-------------|-------------|----------|------------|
| **Change Complexity** | [3] | [Multiple systems affected] | [Phased rollout] |
| **Stakeholder Resistance** | [4] | [Clinical staff skeptical of AI] | [Clinical champions, pilot program] |
| **Organizational Capacity** | [2] | [Already undergoing ERP change] | [Delay 3 months, avoid overlap] |
| **Leadership Support** | [5] | [Strong CEO and CMO sponsorship] | [Maintain visibility] |
| **Resource Availability** | [3] | [Limited training capacity] | [External training partner] |

**Overall Change Risk:** [High / Medium / Low]  
**Go/No-Go Recommendation:** [Proceed with mitigations / Delay / Cancel]

---

## Benefits Dependency Network Checklist

Use this checklist to validate your BDN is complete:

### Completeness Check
- [ ] All 6 layers populated (Business Drivers → IT Enablers)
- [ ] Each layer has at least 3-5 items
- [ ] All dependencies mapped and validated
- [ ] No orphaned items (everything links to something)

### Business Change Check
- [ ] Business changes focus on "how people work differently" (not technology)
- [ ] Each business change has assigned owner
- [ ] Change readiness assessed for each business change
- [ ] Change resistance and mitigation planned

### Enabling Change Check
- [ ] Training and capability development planned
- [ ] New roles and responsibilities defined
- [ ] Governance and decision rights established
- [ ] Communication and engagement plan created

### Technology Check
- [ ] Technology enables business change (not drives it)
- [ ] Technology choices validated against business changes
- [ ] Integration requirements identified
- [ ] Cost estimates provided

### Benefits Check
- [ ] Benefits are measurable (not vague)
- [ ] Baseline and target metrics defined
- [ ] Benefits owner assigned
- [ ] Benefits realization timeline established
- [ ] Benefits tracking approach defined

### Alignment Check
- [ ] Investment objectives align to business drivers
- [ ] Benefits support investment objectives
- [ ] Business changes enable benefits
- [ ] Technology enables business changes

---

## Benefits Realization Plan

### Timeline and Ownership

| Benefit ID | Benefit | Owner | Measurement Frequency | Realization Timeline | Tracking Method |
|------------|---------|-------|----------------------|---------------------|-----------------|
| B-01 | [Saving Lives] | [CMO] | [Monthly] | [6 months post-deployment] | [Mortality rate dashboard] |
| B-02 | [Responsive Service] | [COO] | [Weekly] | [3 months post-deployment] | [Response time metrics] |
| B-03 | [Operational Efficiencies] | [CFO] | [Monthly] | [9 months post-deployment] | [Cost per transaction report] |

---

## Integration with AI Delivery Methodology

### When to Use BDN

1. **Business Envisioning Phase** - Create initial BDN for each use case during ideation
2. **Mobilisation Phase** - Validate and refine BDN with stakeholders
3. **Design Phase** - Update BDN with detailed business process changes
4. **Integration Phase** - Execute enabling changes and business changes
5. **Operate & Care Phase** - Track benefits realization, measure business change adoption

### BDN Artifacts

- **BDN Diagram** - Visual representation of dependencies
- **BDN Matrix** - Tabular view of all elements and links
- **Change Readiness Assessment** - Risk analysis for each business change
- **Benefits Realization Plan** - Timeline and ownership for benefits tracking

---

## Tools and Templates

### Recommended Tools
- **Visio**: Create BDN diagrams
- **Excel**: BDN matrix and dependency tracking
- **Miro**: Collaborative BDN workshop boards
- **Microsoft Whiteboard**: Virtual BDN facilitation

### Template Files
- BDN Workshop Slide Deck
- BDN Excel Template
- BDN Visio Stencils
- Change Readiness Assessment Template

---

## Related Resources

- [Change Management for AI Adoption Guide](../guides/change-management-ai-adoption.md)
- [AI Literacy Program Framework](../guides/ai-literacy-program-framework.md)
- [Business Envisioning Workshop Guide](../guides/01-business-envisioning-workshop-guide.md)
- [Use Case Template](./14-business-envisioning-use-case-template.md)
- [Integration Phase Guide](../guides/phases/05-integrate-phase-complete-guide.md)

---

## Document Control

**Version:** 1.0  
**Date:** February 2, 2026  
**Owner:** [Your Name]  
**Status:** Active  
**Next Review:** [Date]
