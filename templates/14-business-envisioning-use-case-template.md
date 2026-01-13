# AI Use Case Template

## Use Case Identification

**Use Case ID:** [UC-XXX]  
**Title:** [Concise, descriptive name]  
**Version:** [1.0]  
**Date:** [DD/MM/YYYY]  
**Owner:** [Name, Title]  
**Status:** [Ideation / Analysis / Approved / In Development / Deployed]

---

## Executive Summary

**One-Sentence Description:**
```
[Summarize the use case in one compelling sentence]
```

**Strategic Alignment:**
```
[Which strategic priority does this support?]
```

**Expected Value:**
- **Business Impact:** [High / Medium / Low]
- **Estimated Annual Value:** $[Amount]
- **Time to Value:** [X months]

---

## Business Context

### Business Problem Statement

**Current Challenge:**
```
[Describe the specific business problem this use case addresses. What's broken, slow, expensive, or creating risk?]
```

**Impact Quantification:**
| Impact Category | Current State | Cost/Impact |
|----------------|---------------|-------------|
| Financial | [e.g., $500K lost annually] | $[Amount]/year |
| Time | [e.g., 200 hours/month wasted] | [X hours/month] |
| Quality | [e.g., 15% error rate] | [X% errors] |
| Customer | [e.g., 40% dissatisfaction] | [X% impact] |
| Risk | [e.g., regulatory violations] | [Describe risk] |

**Who Is Affected:**
- **Primary Stakeholders:** [e.g., Customer service team - 50 people]
- **Secondary Stakeholders:** [e.g., Customers - 100K annually]
- **Frequency:** [How often does this problem occur?]

### Root Cause Analysis

**Five Whys Analysis:**

Use the Five Whys technique to understand the fundamental cause of this problem:

1. **Why does this problem exist?**
   ```
   [Your answer - be specific and fact-based]
   ```

2. **Why [answer from question 1]?**
   ```
   [Your answer]
   ```

3. **Why [answer from question 2]?**
   ```
   [Your answer]
   ```

4. **Why [answer from question 3]?**
   ```
   [Your answer]
   ```

5. **Why [answer from question 4]?**
   ```
   [Your answer]
   ```

**Root Cause Identified:**
```
[Based on the Five Whys analysis above, state the fundamental root cause that must be addressed]
```

**Root Cause Validation:**
- [ ] This root cause is based on facts and data, not assumptions
- [ ] Addressing this root cause will resolve the problem
- [ ] This root cause is within our ability to influence or change
- [ ] The AI solution proposed directly addresses this root cause

**What Have You Tried Before?**
```
[Describe previous attempts to solve this problem and why they fell short]
```

---

## Proposed Solution

### Solution Overview

**High-Level Description:**
```
[Describe how AI will solve the problem. What will the solution do? How will it work from a user's perspective?]

Example: "An AI-powered document processing system will automatically extract, classify, and route customer documents, eliminating 90% of manual data entry and reducing processing time from 48 hours to 2 hours."
```

**How This Solution Addresses the Root Cause:**
```
[Explicitly explain how this AI solution addresses the root cause identified in the Five Whys analysis. This is critical for ensuring the solution creates lasting value.]

Example: "By implementing an AI-powered integration layer that intelligently aggregates data across all legacy systems, we address the root cause of system fragmentation without requiring expensive system replacements."
```

**AI Capability Type:**
- [ ] Predictive Analytics (forecast, recommend, detect)
- [ ] Generative AI (create, summarize, transform)
- [ ] Computer Vision (inspect, classify, monitor)
- [ ] Natural Language Processing (understand, extract, respond)
- [ ] Other: [Specify]

**Technology Approach:**
- **AI/ML Model Type:** [e.g., Transformer, CNN, Random Forest, LLM]
- **Azure Services:** [e.g., Azure AI Foundry, Azure OpenAI, Copilot Studio, Azure Machine Learning, Cognitive Services]
- **Development Approach:** [Pre-built / Customized / Built from scratch]

### User Experience

**Current Process (As-Is):**
1. [Step 1: e.g., User receives email with document attachment]
2. [Step 2: e.g., User manually downloads and opens document]
3. [Step 3: e.g., User reads and extracts key information]
4. [Step 4: e.g., User enters data into system A, then system B]
5. [Step 5: e.g., User routes document to appropriate team]
6. [Continue...]

**Total Time:** [X hours/minutes per transaction]  
**Error Rate:** [X%]

**Future Process (To-Be):**
1. [Step 1: e.g., User receives email; AI automatically processes attachment]
2. [Step 2: e.g., AI extracts and validates key information with 98% accuracy]
3. [Step 3: e.g., AI populates data in all connected systems]
4. [Step 4: e.g., AI routes document based on content classification]
5. [Step 5: e.g., User reviews AI summary and approves (2 minutes)]

**Total Time:** [X hours/minutes per transaction]  
**Expected Error Rate:** [X%]

**Reduction:** [X% time saved, Y% error reduction]

### Target Users

**Primary Users:**
- **Role:** [e.g., Customer Service Representative]
- **Count:** [Number of users]
- **Current Pain Points:** [What frustrates them?]
- **Expected Benefits:** [How will this help them?]

**Secondary Users:**
- **Role:** [e.g., Manager/Supervisor]
- **Count:** [Number of users]
- **Current Pain Points:**
- **Expected Benefits:**

**Usage Patterns:**
- **Frequency:** [e.g., 500 transactions per day]
- **Peak Times:** [e.g., Month-end, weekday mornings]
- **Volume Trends:** [Growing / Stable / Declining]

---

## Technical Requirements

### Data Requirements

**Input Data:**
| Data Type | Source System | Volume | Quality | Availability |
|-----------|---------------|---------|---------|-------------|
| [e.g., Customer emails] | [Outlook/Exchange] | [10K/month] | [Fair - unstructured] | [Available] |
| [e.g., Document scans] | [SharePoint] | [50K documents] | [Good] | [Available] |
| [e.g., Transaction history] | [CRM] | [5M records] | [Excellent] | [Available with API] |

**Training Data Needs:**
- **Volume Required:** [e.g., 10,000 labeled examples]
- **Current Availability:** [e.g., 2,000 labeled, 50,000 unlabeled]
- **Labeling Strategy:** [e.g., Manual labeling by SMEs, active learning]
- **Data Quality Assessment:** [Excellent / Good / Fair / Poor]
- **Privacy/Security Considerations:** [e.g., PII data requires anonymization]

**Output Data:**
- **What will be produced:** [e.g., Structured JSON with extracted fields]
- **Where will it go:** [e.g., CRM system, Data warehouse]
- **Format:** [e.g., API, File, Database]

### Integration Requirements

**Systems to Integrate:**
| System | Purpose | Integration Type | Complexity | Owner |
|--------|---------|------------------|------------|-------|
| [System A] | [Data source] | [API / File / Database] | [High/Med/Low] | [Team/Person] |
| [System B] | [Data destination] | [API / File / Database] | [High/Med/Low] | [Team/Person] |
| [System C] | [Authentication] | [SSO / OAuth] | [High/Med/Low] | [Team/Person] |

**API Requirements:**
- **Real-time or Batch:** [Real-time / Batch / Hybrid]
- **Expected Latency:** [e.g., <2 seconds response time]
- **Throughput:** [e.g., 100 requests per second]
- **Authentication:** [e.g., OAuth 2.0, Service Principal]

### Infrastructure Requirements

**Compute:**
- **Model Training:** [e.g., GPU cluster, 100 compute hours]
- **Inference:** [e.g., Serverless functions, 1000 requests/day]
- **Scalability:** [Can it scale to 10x volume?]

**Storage:**
- **Training Data:** [e.g., 500 GB]
- **Model Artifacts:** [e.g., 10 GB]
- **Logs/Monitoring:** [e.g., 100 GB/year]

**Security & Compliance:**
- **Data Classification:** [Public / Internal / Confidential / Restricted]
- **Compliance Requirements:** [e.g., GDPR, HIPAA, SOX, none]
- **Access Controls:** [RBAC required, MFA, etc.]
- **Audit Requirements:** [Full logging, retention period]

---

## Success Criteria & Metrics

### Business Outcome Metrics

**Primary Success Metric:**
- **Metric:** [e.g., Cost reduction]
- **Baseline:** [Current: $500K/year]
- **Target:** [Goal: $350K/year (30% reduction)]
- **Measurement Method:** [Monthly cost reports from Finance]
- **Timeline:** [Achieve within 6 months of deployment]

**Secondary Success Metrics:**
- **Metric:** [e.g., Customer satisfaction (CSAT)]
- **Baseline:** [Current: 65%]
- **Target:** [Goal: 80%]
- **Measurement Method:** [Quarterly customer surveys]
- **Timeline:** [Achieve within 9 months]

### Operational Metrics

**Efficiency Metrics:**
| Metric | Baseline | Target | Measurement |
|--------|----------|--------|-------------|
| Processing time | [48 hours] | [2 hours] | [System logs] |
| Manual effort | [200 hrs/month] | [20 hrs/month] | [Time tracking] |
| Throughput | [500/day] | [2000/day] | [System metrics] |

**Quality Metrics:**
| Metric | Baseline | Target | Measurement |
|--------|----------|--------|-------------|
| Error rate | [15%] | [2%] | [QA audits] |
| Accuracy | [85%] | [98%] | [Validation tests] |
| Rework rate | [30%] | [5%] | [Workflow tracking] |

### Adoption Metrics

**User Adoption:**
- **Target:** [80% of users actively using within 3 months]
- **Measurement:** [Daily active users from application logs]

**Task Completion:**
- **Target:** [90% of tasks completed successfully without manual intervention]
- **Measurement:** [Success rate tracking in application]

**User Satisfaction:**
- **Target:** [4.0+ satisfaction score (out of 5)]
- **Measurement:** [Monthly user surveys]

### Technical Metrics

**Model Performance:**
- **Accuracy:** [Target: >95%]
- **Precision:** [Target: >90%]
- **Recall:** [Target: >85%]
- **F1 Score:** [Target: >90%]

**System Performance:**
- **Availability:** [Target: 99.5% uptime]
- **Response Time:** [Target: <2 seconds for 95th percentile]
- **Throughput:** [Target: 100 requests/second]

**MLOps Metrics:**
- **Model Drift:** [Alert if drift >5%]
- **Data Quality:** [Alert if quality score <80%]
- **Retraining Frequency:** [Monthly or as needed]

---

## Value Realization

### Financial Benefits

**Cost Savings:**
| Cost Category | Annual Baseline | Annual Target | Annual Savings |
|---------------|----------------|---------------|----------------|
| Labor | $[Amount] | $[Amount] | $[Amount] |
| Technology | $[Amount] | $[Amount] | $[Amount] |
| Operations | $[Amount] | $[Amount] | $[Amount] |
| Rework/Errors | $[Amount] | $[Amount] | $[Amount] |
| **Total** | **$[Amount]** | **$[Amount]** | **$[Amount]** |

**Revenue Benefits:**
| Revenue Category | Annual Baseline | Annual Target | Annual Gain |
|------------------|----------------|---------------|-------------|
| [e.g., New sales] | $[Amount] | $[Amount] | $[Amount] |
| [e.g., Upsell/Cross-sell] | $[Amount] | $[Amount] | $[Amount] |
| [e.g., Retention] | $[Amount] | $[Amount] | $[Amount] |
| **Total** | **$[Amount]** | **$[Amount]** | **$[Amount]** |

**Total Annual Value:** $[Cost Savings + Revenue Gains]

**3-Year NPV:** $[Calculate net present value]

**ROI:** [X%]

**Payback Period:** [X months]

### Non-Financial Benefits

**Qualitative Benefits:**
- [e.g., Improved employee satisfaction and retention]
- [e.g., Enhanced brand reputation]
- [e.g., Better customer experience]
- [e.g., Risk mitigation]
- [e.g., Competitive advantage]

**Strategic Benefits:**
- [e.g., Foundation for future AI initiatives]
- [e.g., Data infrastructure improvements]
- [e.g., Skill development for team]
- [e.g., Organizational change capability]

---

## Feasibility Assessment

### Technical Feasibility: [HIGH / MEDIUM / LOW]

**Strengths:**
- ✅ [e.g., Required data is available and accessible]
- ✅ [e.g., AI technology is mature and proven]
- ✅ [e.g., Team has relevant skills]

**Constraints:**
- ⚠️ [e.g., Complex integration with 5 legacy systems]
- ⚠️ [e.g., Data quality requires significant cleanup]

**Mitigations:**
- [e.g., Phased approach starting with one system integration]
- [e.g., Allocate 3 months for data preparation]

**Technical Risk Level:** [HIGH / MEDIUM / LOW]

### Data Feasibility: [HIGH / MEDIUM / LOW]

**Data Strengths:**
- ✅ [e.g., 5 years of historical data available]
- ✅ [e.g., High volume supports model training]

**Data Gaps:**
- ❌ [e.g., Only 10% of data is labeled]
- ⚠️ [e.g., Data from System A has 20% missing values]

**Data Strategy:**
- [e.g., Implement labeling process with SMEs]
- [e.g., Data imputation strategy for missing values]
- [e.g., Collect additional data sources]

**Data Risk Level:** [HIGH / MEDIUM / LOW]

### Organizational Feasibility: [HIGH / MEDIUM / LOW]

**Enablers:**
- ✅ [e.g., Strong executive sponsorship]
- ✅ [e.g., Users are eager for automation]
- ✅ [e.g., Budget approved]

**Barriers:**
- ⚠️ [e.g., Concerns about job displacement]
- ⚠️ [e.g., Multiple stakeholder groups with competing priorities]
- ⚠️ [e.g., Limited change management resources]

**Change Strategy:**
- [e.g., Communicate focus on "augmentation not replacement"]
- [e.g., Establish steering committee for alignment]
- [e.g., Dedicate change management resource]

**Organizational Risk Level:** [HIGH / MEDIUM / LOW]

### Overall Feasibility: [GO / CONDITIONAL GO / NO-GO]

**Decision Rationale:**
```
[Explain the overall feasibility assessment and recommendation]
```

---

## Risks and Mitigations

### Technical Risks

**Risk 1:**
- **Description:** [e.g., Model may not achieve target accuracy with available data]
- **Impact:** [HIGH / MEDIUM / LOW]
- **Probability:** [HIGH / MEDIUM / LOW]
- **Mitigation:** [e.g., Conduct POC with data sample; plan for data augmentation]
- **Contingency:** [e.g., Fallback to rule-based approach for initial deployment]

**Risk 2:**
- **Description:**
- **Impact:**
- **Probability:**
- **Mitigation:**
- **Contingency:**

### Business Risks

**Risk 1:**
- **Description:** [e.g., User adoption may be slow due to change resistance]
- **Impact:** [HIGH / MEDIUM / LOW]
- **Probability:** [HIGH / MEDIUM / LOW]
- **Mitigation:** [e.g., Comprehensive training and change management program]
- **Contingency:** [e.g., Phased rollout with early adopters]

**Risk 2:**
- **Description:**
- **Impact:**
- **Probability:**
- **Mitigation:**
- **Contingency:**

### Data & Privacy Risks

**Risk 1:**
- **Description:** [e.g., PII data in training set may violate privacy policies]
- **Impact:** [HIGH / MEDIUM / LOW]
- **Probability:** [HIGH / MEDIUM / LOW]
- **Mitigation:** [e.g., Implement data anonymization pipeline]
- **Contingency:** [e.g., Use synthetic data for model training]

**Risk 2:**
- **Description:**
- **Impact:**
- **Probability:**
- **Mitigation:**
- **Contingency:**

---

## Implementation Approach

### Phases and Timeline

**Phase 1: Discovery & POC (Months 1-3)**
- Data assessment and preparation
- POC development with limited scope
- Technical feasibility validation
- **Milestone:** POC demonstrates >85% accuracy

**Phase 2: Pilot Development (Months 4-6)**
- Build production-ready solution
- Integration with core systems
- User acceptance testing
- **Milestone:** Pilot ready for limited user group

**Phase 3: Pilot Deployment (Months 7-9)**
- Deploy to pilot user group (20% of users)
- Monitor performance and gather feedback
- Iterative improvements
- **Milestone:** Achieve success metrics with pilot group

**Phase 4: Full Deployment (Months 10-12)**
- Roll out to all users
- Training and enablement
- Continuous monitoring
- **Milestone:** Full deployment complete, success metrics achieved

### Resource Requirements

**Team Composition:**
| Role | Count | Duration | Cost |
|------|-------|----------|------|
| Project Manager | 1 | 12 months | $[Amount] |
| Data Scientist | 2 | 9 months | $[Amount] |
| ML Engineer | 2 | 12 months | $[Amount] |
| Data Engineer | 1 | 6 months | $[Amount] |
| Software Engineer | 2 | 10 months | $[Amount] |
| UX Designer | 1 | 3 months | $[Amount] |
| Business Analyst | 1 | 6 months | $[Amount] |
| Change Manager | 1 | 8 months | $[Amount] |
| **Total Labor Cost** | | | **$[Amount]** |

**Technology & Infrastructure:**
| Item | Purpose | Cost |
|------|---------|------|
| Azure ML Compute | Model training | $[Amount] |
| Azure OpenAI API | Inference | $[Amount] |
| Storage | Data & models | $[Amount] |
| Integration tools | System connectivity | $[Amount] |
| Monitoring tools | MLOps | $[Amount] |
| **Total Technology Cost** | | **$[Amount]** |

**Other Costs:**
| Item | Cost |
|------|------|
| Training & enablement | $[Amount] |
| External consultants | $[Amount] |
| Licenses | $[Amount] |
| Contingency (20%) | $[Amount] |
| **Total Other Costs** | **$[Amount]** |

**Total Implementation Cost:** $[Labor + Technology + Other]

### Dependencies

**Internal Dependencies:**
- [e.g., Data warehouse modernization project must complete first]
- [e.g., API gateway deployment required]
- [e.g., SSO implementation needed]

**External Dependencies:**
- [e.g., Vendor API upgrades]
- [e.g., Third-party data provider contract]
- [e.g., Cloud infrastructure provisioning]

---

## Governance and Decision-Making

### Stakeholders and RACI

| Stakeholder | Role | RACI |
|-------------|------|------|
| [Name, Title] | Executive Sponsor | Accountable |
| [Name, Title] | Product Owner | Responsible |
| [Name, Title] | Project Manager | Responsible |
| [Name, Title] | Technical Lead | Consulted |
| [Name, Title] | Business Lead | Consulted |
| [Name, Title] | End Users | Informed |

### Decision Points and Approvals

**Phase Gate Approvals:**
| Gate | Criteria | Approver | Date |
|------|----------|----------|------|
| Discovery Complete | POC validates feasibility | [Executive Sponsor] | [Date] |
| Pilot Go-Live | UAT passed, success metrics defined | [Steering Committee] | [Date] |
| Full Deployment | Pilot meets success criteria | [Executive Sponsor] | [Date] |

### Monitoring and Reporting

**Reporting Frequency:** [Weekly / Bi-weekly / Monthly]

**KPI Dashboard:** [Link to dashboard or description]

**Steering Committee:** 
- **Members:** [List members]
- **Frequency:** [Monthly]
- **Purpose:** [Strategic oversight, issue escalation, resource allocation]

---

## Appendices

### Appendix A: Related Documents

- [Business Requirements Document](./09-business-requirements-document.md)
- [Data Assessment Report](./10-data-assessment-report.md)
- [Project Charter](./01-project-charter.md)
- [Risk Register](./05-risk-register.md)

### Appendix B: Glossary

| Term | Definition |
|------|------------|
| [Term 1] | [Definition] |
| [Term 2] | [Definition] |
| [Term 3] | [Definition] |

### Appendix C: Assumptions

1. [e.g., User workload remains stable over implementation period]
2. [e.g., Budget approved will be allocated on time]
3. [e.g., Integration APIs are well-documented and supported]
4. [e.g., Regulatory environment remains unchanged]

### Appendix D: Open Questions

1. [e.g., What is the preferred model retraining frequency?]
2. [e.g., Who will own model maintenance long-term?]
3. [e.g., Should we build or buy the solution?]

---

## Approval and Sign-Off

**Use Case Approved By:**

| Name | Title | Signature | Date |
|------|-------|-----------|------|
| [Name] | Executive Sponsor | | [Date] |
| [Name] | Business Owner | | [Date] |
| [Name] | IT/Technology Lead | | [Date] |
| [Name] | Finance (Budget Approval) | | [Date] |

---

**Document Version:** 1.0  
**Last Updated:** [DD/MM/YYYY]  
**Owner:** [Name, Title]  
**Next Review:** [Date]

---

*This template is part of the AI Delivery Methodology. For related materials, see:*
- *[Business Envisioning Workshop Guide](../guides/business-envisioning-workshop-guide.md)*
- *[Discovery Phase Checklist](../checklists/discovery-checklist.md)*
