# Risk Register

## Document Information

| Field | Details |
|-------|---------|
| **Project Name** | [Enter AI Project Name] |
| **Version** | 1.0 |
| **Date** | [DD/MM/YYYY] |
| **Risk Manager** | [Project Manager Name] |
| **Review Frequency** | Weekly |

---

## Risk Management Overview

### Risk Assessment Criteria

#### Probability Scale
| Rating | Description | Likelihood |
|--------|-------------|------------|
| **5 - Very High** | Almost certain to occur | > 80% |
| **4 - High** | Likely to occur | 60-80% |
| **3 - Medium** | Possible | 40-60% |
| **2 - Low** | Unlikely | 20-40% |
| **1 - Very Low** | Rare | < 20% |

#### Impact Scale
| Rating | Description | Cost Impact | Schedule Impact | Quality Impact |
|--------|-------------|-------------|-----------------|----------------|
| **5 - Critical** | Project failure | > $500K | > 3 months | Mission-critical failure |
| **4 - High** | Major disruption | $200K-$500K | 1-3 months | Significant quality issues |
| **3 - Medium** | Moderate impact | $50K-$200K | 2-4 weeks | Moderate quality degradation |
| **2 - Low** | Minor impact | $10K-$50K | < 2 weeks | Minor quality issues |
| **1 - Very Low** | Negligible | < $10K | < 1 week | Negligible impact |

#### Risk Score Matrix
**Risk Score = Probability × Impact**

| Score | Priority | Response |
|-------|----------|----------|
| 20-25 | **Critical** | Immediate action required |
| 15-19 | **High** | Urgent attention needed |
| 10-14 | **Medium** | Monitor closely |
| 5-9 | **Low** | Monitor |
| 1-4 | **Very Low** | Accept |

---

## Risk Library Reference

> 📚 **18 Pre-Defined AI Project Risks Available**: This project uses the standard risk library containing 18 common AI project risks with detailed mitigation strategies. See [**Risk Library Shared Module**](shared-components/risk-library.md) for complete risk definitions, mitigation strategies, and best practices.
> 
> **How to Use**: 
> 1. Review the [Risk Library](shared-components/risk-library.md) and select relevant risks (typically 8-12 risks per project)
> 2. Import selected risks into this register below
> 3. Customize probability, impact, and mitigation plans for your specific project context
> 4. Add 3-5 project-specific risks not covered in the library

### Quick Reference: Standard Risk Categories
- **Technical Risks (5)**: Data quality, model performance, integration, scalability, security
- **Data Risks (3)**: Insufficient training data, access/privacy constraints, data drift
- **Business Risks (4)**: Unclear requirements, lack of sponsorship, user adoption, unrealistic ROI
- **Organizational Risks (3)**: Resource availability, lack of AI expertise, vendor dependency
- **Project Management Risks (3)**: Scope creep, inadequate testing, communication breakdown

---

## Active Risks

> **Instructions**: Import relevant risks from the [Risk Library](shared-components/risk-library.md) by copying risk templates below. Update the **Status**, **Current Probability**, **Current Impact**, **Owner**, **Mitigation Strategy** (customize), and **Next Review** fields for your project.

### Summary Dashboard

| Risk ID | Risk Name | Category | Score | Priority | Status | Owner |
|---------|-----------|----------|-------|----------|--------|-------|
| R001 | [Import from library or add custom] | [Category] | [P×I] | [H/M/L] | [Status] | [Owner] |
| R002 | [Import from library or add custom] | [Category] | [P×I] | [H/M/L] | [Status] | [Owner] |
| R003 | [Import from library or add custom] | [Category] | [P×I] | [H/M/L] | [Status] | [Owner] |
| R004 | [Import from library or add custom] | [Category] | [P×I] | [H/M/L] | [Status] | [Owner] |
| R005 | [Import from library or add custom] | [Category] | [P×I] | [H/M/L] | [Status] | [Owner] |
| ... | ... | ... | ... | ... | ... | ... |

**Current Risk Profile:** 
- Critical (20-25): [Count] 
- High (15-19): [Count]  
- Medium (10-14): [Count]  
- Low (1-9): [Count]

---

### CATEGORY 1: TECHNICAL RISKS

> 💡 **Tip**: Review [Risk Library - Technical Risks](shared-components/risk-library.md#category-1-technical-risks-5-risks) for R001-R005 definitions and standard mitigation strategies.

#### R001: [Inadequate Data Quality - Import from Risk Library]
| Field | Details |
|-------|---------|
| **Risk ID** | R001 |
| **Category** | Technical - Data |
| **Description** | Available data may have poor quality, missing values, or inconsistencies that prevent effective model training |
| **Standard Definition** | See [Risk Library R001](shared-components/risk-library.md#r001-inadequate-data-quality) for complete risk profile |
| **Cause** | [Customize for your project - e.g., "Legacy CRM system, inconsistent data entry"]
| **Impact** | Model accuracy below acceptable thresholds, project delays, additional data cleansing effort required |
| **Probability** | 4 - High |
| **Impact** | 4 - High |
| **Risk Score** | 16 (High) |
| **Status** | Active |
| **Owner** | Data Engineer |
| **Mitigation Strategy** | - Conduct comprehensive data quality assessment early in discovery<br>- Implement data validation rules<br>- Set up automated data quality monitoring<br>- Allocate additional time for data preparation |
| **Contingency Plan** | - Engage data stewards to improve source data<br>- Consider synthetic data generation<br>- Adjust model approach to handle data limitations |
| **Trigger Indicators** | - Data completeness < 80%<br>- High error rates in validation<br>- Significant outliers |
| **Response Actions** | □ Data quality assessment complete<br>□ Validation rules implemented<br>□ Monitoring dashboard set up |
| **Last Updated** | [Date] |
| **Next Review** | [Date] |

> 📖 **Full Risk Details**: See [Risk Library R001](shared-components/risk-library.md#r001-inadequate-data-quality) for complete mitigation strategies, best practices, and contingency plans.

---

#### R002: [Model Performance Below Expectations - Import from Risk Library]
| Field | Details |
|-------|---------|
| **Risk ID** | R002 |
| **Category** | Technical - AI/ML |
| **Description** | ML model fails to achieve target accuracy, precision, or recall metrics defined in success criteria |
| **Standard Definition** | See [Risk Library R002](shared-components/risk-library.md#r002-model-performance-below-expectations) |
| **Cause** | [Customize - e.g., "Limited historical data, complex business rules"] |
| **Impact** | Business value not realized, stakeholder confidence lost, project may be cancelled |
| **Probability** | [1-5] |
| **Impact** | [1-5] |
| **Risk Score** | [P×I] |
| **Status** | [Active/Mitigated/Closed] |
| **Owner** | [AI/ML Lead] |
| **Mitigation Strategy** | [Customize standard strategies from Risk Library] |
| **Contingency Plan** | [Customize from Risk Library] |
| **Trigger Indicators** | [Select relevant triggers from Risk Library] |
| **Response Actions** | □ [Action 1]<br>□ [Action 2]<br>□ [Action 3] |
| **Last Updated** | [Date] |
| **Next Review** | [Date] |

> 📖 **Full Risk Details**: See [Risk Library R002](shared-components/risk-library.md#r002-model-performance-below-expectations)

---

#### R003-R018: [Additional Risks - Import from Risk Library as Needed]

> 💡 **Import Additional Risks**: Review the [Risk Library](shared-components/risk-library.md) and import other relevant risks:
> - **R003**: Integration Complexity
> - **R004**: Scalability & Performance Issues
> - **R005**: Security & Compliance Violation
> - **R006**: Insufficient Training Data
> - **R007**: Data Access & Privacy Constraints
> - **R008**: Data Drift & Model Degradation
> - **R009**: Unclear or Changing Requirements
> - **R010**: Lack of Executive Sponsorship
> - **R011**: User Adoption Resistance
> - **R012**: Unrealistic ROI Expectations
> - **R013**: Resource Availability
> - **R014**: Lack of AI/ML Expertise
> - **R015**: Vendor/Third-Party Dependency
> - **R016**: Scope Creep
> - **R017**: Inadequate Testing
> - **R018**: Communication Breakdown
>
> **Template for Importing Risks:**
> ```markdown
> #### R0XX: [Risk Name from Library]
> | Field | Details |
> |-------|---------|
> | **Risk ID** | R0XX |
> | **Category** | [Category from Library] |
> | **Description** | [Copy from Library] |
> | **Standard Definition** | See [Risk Library R0XX](shared-components/risk-library.md#r0XX-risk-name) |
> | **Cause** | [Customize for your project context] |
> | **Impact** | [Expected impact on your project] |
> | **Probability** | [Your assessment: 1-5] |
> | **Impact** | [Your assessment: 1-5] |
> | **Risk Score** | [P×I] |
> | **Status** | [Active/Monitoring/Mitigated/Closed] |
> | **Owner** | [Assign owner from your team] |
> | **Mitigation Strategy** | [Customize strategies from Risk Library] |
> | **Contingency Plan** | [Customize from Risk Library] |
> | **Trigger Indicators** | [Select relevant triggers] |
> | **Response Actions** | □ [Action 1]<br>□ [Action 2] |
> | **Last Updated** | [Date] |
> | **Next Review** | [Date] |
> ```

---

### PROJECT-SPECIFIC RISKS

> **Add Custom Risks**: Add 3-5 risks specific to your project that are not covered in the standard risk library.

#### R101: [Project-Specific Risk 1]
| Field | Details |
|-------|---------|
| **Risk ID** | R003 |
| **Category** | Technical - Integration |
| **Description** | Complexity of integrating AI solution with existing enterprise systems exceeds initial estimates |
| **Cause** | Legacy systems, undocumented APIs, security constraints, data format incompatibilities |
| **Impact** | Project delays, increased costs, reduced functionality, technical debt |
| **Probability** | 3 - Medium |
| **Impact** | 3 - Medium |
| **Risk Score** | 9 (Low) |
| **Status** | Active |
| **Owner** | Solution Architect |
| **Mitigation Strategy** | - Conduct detailed integration analysis early<br>- Engage system owners in discovery<br>- Use middleware/integration platforms<br>- Build integration spikes during prototype<br>- Allocate buffer time for integration |
| **Contingency Plan** | - Simplify integration scope<br>- Use batch processing instead of real-time<br>- Build temporary manual processes |
| **Trigger Indicators** | - API documentation missing<br>- Test integrations failing<br>- System owner unresponsive |
| **Response Actions** | □ Integration inventory complete<br>□ Spike solutions tested<br>□ System owners engaged |
| **Last Updated** | [Date] |
| **Next Review** | [Date] |

---

#### R004: Scalability & Performance Issues
| Field | Details |
|-------|---------|
| **Risk ID** | R004 |
| **Category** | Technical - Infrastructure |
| **Description** | Solution cannot handle expected production load or response time requirements |
| **Cause** | Underestimated load, inefficient code, resource constraints, architectural limitations |
| **Impact** | Poor user experience, system downtime, additional infrastructure costs |
| **Probability** | 3 - Medium |
| **Impact** | 4 - High |
| **Risk Score** | 12 (Medium) |
| **Status** | Active |
| **Owner** | Solution Architect |
| **Mitigation Strategy** | - Define clear performance requirements<br>- Conduct load testing early and often<br>- Design for horizontal scalability<br>- Use Azure autoscaling capabilities<br>- Implement caching strategies |
| **Contingency Plan** | - Scale up infrastructure (additional cost)<br>- Implement queueing for batch processing<br>- Reduce feature scope temporarily |
| **Trigger Indicators** | - Response time > 3 seconds<br>- CPU/Memory > 80%<br>- Failed load tests |
| **Response Actions** | □ Performance requirements defined<br>□ Load testing plan created<br>□ Scalability design reviewed |
| **Last Updated** | [Date] |
| **Next Review** | [Date] |

---

#### R005: Security & Compliance Violation
| Field | Details |
|-------|---------|
| **Risk ID** | R005 |
| **Category** | Technical - Security |
| **Description** | Solution fails to meet security standards or regulatory compliance requirements (GDPR, HIPAA, etc.) |
| **Cause** | Incomplete requirements, lack of security expertise, complex regulations, late security review |
| **Impact** | Legal liability, fines, project shutdown, reputational damage |
| **Probability** | 2 - Low |
| **Impact** | 5 - Critical |
| **Risk Score** | 10 (Medium) |
| **Status** | Active |
| **Owner** | Security Manager |
| **Mitigation Strategy** | - Engage security team from day 1<br>- Conduct privacy impact assessment<br>- Implement security by design<br>- Regular security reviews and audits<br>- Use Azure security best practices |
| **Contingency Plan** | - Rapid security remediation sprint<br>- Delay go-live until compliant<br>- Engage external security auditors |
| **Trigger Indicators** | - Security scan failures<br>- Compliance gaps identified<br>- PII exposure detected |
| **Response Actions** | □ Security requirements documented<br>□ Privacy assessment complete<br>□ Security review scheduled |
| **Last Updated** | [Date] |
| **Next Review** | [Date] |

---

### CATEGORY 2: DATA RISKS

#### R006: Insufficient Training Data
| Field | Details |
|-------|---------|
| **Risk ID** | R006 |
| **Category** | Data |
| **Description** | Insufficient volume of labeled data to train effective ML models |
| **Cause** | Limited historical data, manual labeling required, edge cases rare |
| **Impact** | Model overfitting, poor generalization, unable to achieve targets |
| **Probability** | 3 - Medium |
| **Impact** | 4 - High |
| **Risk Score** | 12 (Medium) |
| **Status** | Active |
| **Owner** | Data Scientist |
| **Mitigation Strategy** | - Assess data availability early<br>- Use transfer learning/pre-trained models<br>- Implement data augmentation<br>- Consider active learning approach<br>- Budget for data labeling services |
| **Contingency Plan** | - Use semi-supervised learning<br>- Synthetic data generation<br>- Reduce model scope to data-rich areas |
| **Trigger Indicators** | - Training set < 1000 samples<br>- Class imbalance > 90/10<br>- Validation curve not converging |
| **Response Actions** | □ Data volume assessment done<br>□ Labeling strategy defined<br>□ Augmentation approaches tested |
| **Last Updated** | [Date] |
| **Next Review** | [Date] |

---

#### R007: Data Access & Privacy Constraints
| Field | Details |
|-------|---------|
| **Risk ID** | R007 |
| **Category** | Data - Privacy |
| **Description** | Privacy regulations or data access restrictions prevent use of required data |
| **Cause** | GDPR, data residency requirements, internal data policies, consent issues |
| **Impact** | Project delays, reduced model scope, need for alternative data sources |
| **Probability** | 3 - Medium |
| **Impact** | 3 - Medium |
| **Risk Score** | 9 (Low) |
| **Status** | Active |
| **Owner** | Security Manager / BA |
| **Mitigation Strategy** | - Early engagement with legal/compliance<br>- Conduct data privacy impact assessment<br>- Implement data anonymization/pseudonymization<br>- Use differential privacy techniques<br>- Obtain proper data access approvals |
| **Contingency Plan** | - Use aggregated/anonymized data only<br>- Implement federated learning<br>- Redesign approach to avoid sensitive data |
| **Trigger Indicators** | - Data access request denied<br>- Privacy officer raises concerns<br>- Cannot obtain consent |
| **Response Actions** | □ Privacy assessment complete<br>□ Data access requests submitted<br>□ Anonymization approach defined |
| **Last Updated** | [Date] |
| **Next Review** | [Date] |

---

#### R008: Data Drift & Model Degradation
| Field | Details |
|-------|---------|
| **Risk ID** | R008 |
| **Category** | Data - Ongoing |
| **Description** | Production data distribution changes over time, causing model performance to degrade |
| **Cause** | Business changes, seasonal patterns, market shifts, user behavior changes |
| **Impact** | Declining accuracy, business value erosion, user trust loss |
| **Probability** | 4 - High |
| **Impact** | 3 - Medium |
| **Risk Score** | 12 (Medium) |
| **Status** | Active |
| **Owner** | AI/ML Lead |
| **Mitigation Strategy** | - Implement data drift monitoring<br>- Set up automated model retraining pipeline<br>- Define model performance thresholds<br>- Create alerting for drift detection<br>- Plan regular model refresh cycles |
| **Contingency Plan** | - Emergency model retraining<br>- Rollback to previous model version<br>- Temporary manual review process |
| **Trigger Indicators** | - Accuracy drops > 5%<br>- Prediction distribution shifts<br>- Business metrics decline |
| **Response Actions** | □ Drift monitoring implemented<br>□ Retraining pipeline built<br>□ Alert thresholds set |
| **Last Updated** | [Date] |
| **Next Review** | [Date] |

---

### CATEGORY 3: BUSINESS RISKS

#### R009: Unclear or Changing Requirements
| Field | Details |
|-------|---------|
| **Risk ID** | R009 |
| **Category** | Business - Requirements |
| **Description** | Business requirements unclear, incomplete, or frequently changing |
| **Cause** | Stakeholder misalignment, unclear vision, evolving understanding, competing priorities |
| **Impact** | Rework, scope creep, budget overrun, delays, stakeholder dissatisfaction |
| **Probability** | 4 - High |
| **Impact** | 3 - Medium |
| **Risk Score** | 12 (Medium) |
| **Status** | Active |
| **Owner** | Business Analyst |
| **Mitigation Strategy** | - Invest time in thorough discovery<br>- Use prototypes to clarify requirements<br>- Implement formal change control<br>- Regular stakeholder reviews<br>- Document all requirements formally |
| **Contingency Plan** | - Freeze scope after discovery<br>- Push changes to future phases<br>- Escalate to executive sponsor |
| **Trigger Indicators** | - Multiple change requests<br>- Stakeholder disagreements<br>- Prototype feedback contradictory |
| **Response Actions** | □ Requirements workshop held<br>□ Prototype demos scheduled<br>□ Change control process active |
| **Last Updated** | [Date] |
| **Next Review** | [Date] |

---

#### R010: Lack of Executive Sponsorship
| Field | Details |
|-------|---------|
| **Risk ID** | R010 |
| **Category** | Business - Governance |
| **Description** | Insufficient executive support and engagement throughout project lifecycle |
| **Cause** | Competing priorities, sponsor turnover, lack of AI understanding, political issues |
| **Impact** | Blocked decisions, resource constraints, budget cuts, project cancellation |
| **Probability** | 2 - Low |
| **Impact** | 5 - Critical |
| **Risk Score** | 10 (Medium) |
| **Status** | Active |
| **Owner** | Project Manager |
| **Mitigation Strategy** | - Secure strong sponsor commitment upfront<br>- Regular executive communications<br>- Demonstrate quick wins and value<br>- Keep sponsor informed of risks<br>- Build steering committee support |
| **Contingency Plan** | - Escalate to higher executive<br>- Seek alternative sponsor<br>- Document business case again |
| **Trigger Indicators** | - Sponsor missing meetings<br>- Decisions delayed > 2 weeks<br>- Budget approvals stalled |
| **Response Actions** | □ Sponsor commitment obtained<br>□ Communication plan active<br>□ Quick wins identified |
| **Last Updated** | [Date] |
| **Next Review** | [Date] |

---

#### R011: User Adoption Resistance
| Field | Details |
|-------|---------|
| **Risk ID** | R011 |
| **Category** | Business - Change Management |
| **Description** | End users resist adopting the AI solution due to fear, skepticism, or workflow disruption |
| **Cause** | Fear of job loss, lack of trust in AI, poor user experience, inadequate training |
| **Impact** | Low usage rates, business benefits not realized, project deemed failure |
| **Probability** | 4 - High |
| **Impact** | 4 - High |
| **Risk Score** | 16 (High) |
| **Status** | Active |
| **Owner** | Change Manager |
| **Mitigation Strategy** | - Invest in change management from start<br>- Involve users early in design<br>- Comprehensive training program<br>- Emphasize augmentation not replacement<br>- Ensure excellent UX<br>- Create champions/advocates |
| **Contingency Plan** | - Intensive coaching and support<br>- Adjust workflow integration<br>- Make adoption gradual/optional initially |
| **Trigger Indicators** | - Negative feedback in UAT<br>- Low training attendance<br>- Rumors/concerns raised |
| **Response Actions** | □ Change impact assessment done<br>□ Training plan created<br>□ Champions identified |
| **Last Updated** | [Date] |
| **Next Review** | [Date] |

---

#### R012: Unrealistic ROI Expectations
| Field | Details |
|-------|---------|
| **Risk ID** | R012 |
| **Category** | Business - Value |
| **Description** | Stakeholders have unrealistic expectations about AI capabilities and ROI timeline |
| **Cause** | AI hype, misunderstanding of limitations, aggressive business case, lack of AI literacy |
| **Impact** | Perceived project failure even if successful, budget cuts, loss of trust in AI |
| **Probability** | 3 - Medium |
| **Impact** | 3 - Medium |
| **Risk Score** | 9 (Low) |
| **Status** | Active |
| **Owner** | Project Manager / Business Owner |
| **Mitigation Strategy** | - Set realistic expectations early<br>- Educate stakeholders on AI capabilities/limits<br>- Build conservative business case<br>- Define clear success criteria<br>- Demonstrate value incrementally |
| **Contingency Plan** | - Re-baseline expectations<br>- Showcase achieved benefits<br>- Extend benefit realization timeline |
| **Trigger Indicators** | - Stakeholder comments suggesting unrealistic expectations<br>- Business case overly optimistic<br>- Lack of understanding of AI limitations |
| **Response Actions** | □ Stakeholder education sessions<br>□ Realistic success criteria set<br>□ Benefit tracking plan defined |
| **Last Updated** | [Date] |
| **Next Review** | [Date] |

---

### CATEGORY 4: ORGANIZATIONAL RISKS

#### R013: Resource Availability
| Field | Details |
|-------|---------|
| **Risk ID** | R013 |
| **Category** | Organizational - Resources |
| **Description** | Key resources (AI experts, data scientists, SMEs) not available when needed |
| **Cause** | Competing projects, resource turnover, limited AI talent pool, budget constraints |
| **Impact** | Project delays, quality issues, increased costs from contractors |
| **Probability** | 3 - Medium |
| **Impact** | 4 - High |
| **Risk Score** | 12 (Medium) |
| **Status** | Active |
| **Owner** | Project Manager |
| **Mitigation Strategy** | - Secure resource commitments early<br>- Cross-train team members<br>- Budget for contractors/consultants<br>- Build resource buffer into schedule<br>- Create resource escalation process |
| **Contingency Plan** | - Engage external contractors<br>- Adjust timeline<br>- Reduce scope temporarily |
| **Trigger Indicators** | - Resources allocated < 50% promised<br>- Key resource resignation<br>- Competing project taking resources |
| **Response Actions** | □ Resource commitments documented<br>□ Backup resources identified<br>□ Contractor budget allocated |
| **Last Updated** | [Date] |
| **Next Review** | [Date] |

---

#### R014: Lack of AI/ML Expertise
| Field | Details |
|-------|---------|
| **Risk ID** | R014 |
| **Category** | Organizational - Skills |
| **Description** | Team lacks necessary AI/ML expertise to deliver successfully |
| **Cause** | Limited internal AI capability, knowledge gaps, emerging technology |
| **Impact** | Poor technical decisions, suboptimal solutions, extended timeline, quality issues |
| **Probability** | 3 - Medium |
| **Impact** | 4 - High |
| **Risk Score** | 12 (Medium) |
| **Status** | Active |
| **Owner** | AI/ML Lead |
| **Mitigation Strategy** | - Assess skill gaps early<br>- Provide training and upskilling<br>- Engage external AI consultants<br>- Partner with Microsoft AI specialists<br>- Use proven frameworks and patterns |
| **Contingency Plan** | - Increase external consultant engagement<br>- Simplify technical approach<br>- Use more Azure managed services |
| **Trigger Indicators** | - Team struggling with ML concepts<br>- Multiple technical pivots<br>- External expert recommendations ignored |
| **Response Actions** | □ Skills assessment complete<br>□ Training plan created<br>□ External experts engaged |
| **Last Updated** | [Date] |
| **Next Review** | [Date] |

---

#### R015: Vendor/Third-Party Dependency
| Field | Details |
|-------|---------|
| **Risk ID** | R015 |
| **Category** | Organizational - External |
| **Description** | Dependency on external vendors or partners (Microsoft, data providers, etc.) causes delays |
| **Cause** | Vendor delays, service outages, contract issues, vendor prioritization |
| **Impact** | Project delays, blocked work, potential cost increases |
| **Probability** | 2 - Low |
| **Impact** | 3 - Medium |
| **Risk Score** | 6 (Low) |
| **Status** | Active |
| **Owner** | Project Manager |
| **Mitigation Strategy** | - Identify all vendor dependencies early<br>- Build relationships with vendor teams<br>- Include vendors in project planning<br>- Have contractual SLAs<br>- Build schedule buffers |
| **Contingency Plan** | - Escalate to vendor management<br>- Use alternative vendors if possible<br>- Adjust schedule |
| **Trigger Indicators** | - Vendor missing commitments<br>- Azure service issues<br>- Contract negotiations stalled |
| **Response Actions** | □ Vendor dependencies mapped<br>□ Vendor contacts established<br>□ SLAs reviewed |
| **Last Updated** | [Date] |
| **Next Review** | [Date] |

---

### CATEGORY 5: PROJECT MANAGEMENT RISKS

#### R016: Scope Creep
| Field | Details |
|-------|---------|
| **Risk ID** | R016 |
| **Category** | Project Management - Scope |
| **Description** | Uncontrolled expansion of project scope without corresponding adjustments to time, cost, and resources |
| **Cause** | Weak change control, stakeholder pressure, unclear initial scope, "while we're at it" syndrome |
| **Impact** | Budget overrun, schedule delays, team burnout, quality degradation |
| **Probability** | 4 - High |
| **Impact** | 3 - Medium |
| **Risk Score** | 12 (Medium) |
| **Status** | Active |
| **Owner** | Project Manager |
| **Mitigation Strategy** | - Define clear scope baseline<br>- Implement formal change control<br>- Regular scope reviews<br>- Manage stakeholder expectations<br>- Document all changes and impacts |
| **Contingency Plan** | - Freeze scope temporarily<br>- Defer new requests to Phase 2<br>- Executive escalation for approval |
| **Trigger Indicators** | - Frequent "small" additions<br>- Schedule slipping<br>- Team working overtime regularly |
| **Response Actions** | □ Scope baseline approved<br>□ Change control process active<br>□ Backlog for Phase 2 created |
| **Last Updated** | [Date] |
| **Next Review** | [Date] |

---

#### R017: Inadequate Testing
| Field | Details |
|-------|---------|
| **Risk ID** | R017 |
| **Category** | Project Management - Quality |
| **Description** | Insufficient testing time or coverage leads to production issues |
| **Cause** | Schedule pressure, underestimating testing effort, lack of test resources |
| **Impact** | Production defects, poor user experience, emergency fixes, reputation damage |
| **Probability** | 3 - Medium |
| **Impact** | 4 - High |
| **Risk Score** | 12 (Medium) |
| **Status** | Active |
| **Owner** | QA Lead |
| **Mitigation Strategy** | - Allocate adequate testing time (20% of build)<br>- Define comprehensive test strategy<br>- Automate testing where possible<br>- Involve users in UAT early<br>- Don't compress testing to meet dates |
| **Contingency Plan** | - Delay go-live to complete testing<br>- Phased rollout to limit blast radius<br>- Enhanced hypercare support |
| **Trigger Indicators** | - Test coverage < 70%<br>- UAT feedback rate declining<br>- Pressure to skip test phases |
| **Response Actions** | □ Test strategy approved<br>□ Test resources secured<br>□ Automation framework set up |
| **Last Updated** | [Date] |
| **Next Review** | [Date] |

---

#### R018: Communication Breakdown
| Field | Details |
|-------|---------|
| **Risk ID** | R018 |
| **Category** | Project Management - Communication |
| **Description** | Poor communication leading to misunderstandings, misalignment, and errors |
| **Cause** | Distributed teams, unclear communication channels, information overload, cultural differences |
| **Impact** | Rework, confusion, delays, stakeholder dissatisfaction, team conflict |
| **Probability** | 3 - Medium |
| **Impact** | 2 - Low |
| **Risk Score** | 6 (Low) |
| **Status** | Active |
| **Owner** | Project Manager |
| **Mitigation Strategy** | - Establish clear communication plan<br>- Regular standsouts and status meetings<br>- Use collaboration tools effectively<br>- Document key decisions<br>- Create feedback loops |
| **Contingency Plan** | - Increase meeting frequency<br>- One-on-one stakeholder meetings<br>- Communication audit and reset |
| **Trigger Indicators** | - Team members saying "I didn't know"<br>- Duplicate work<br>- Stakeholder surprises |
| **Response Actions** | □ Communication plan active<br>□ Team collaboration tools set up<br>□ Decision log maintained |
| **Last Updated** | [Date] |
| **Next Review** | [Date] |

---

## Risk Summary Dashboard

### Risk Distribution by Category
| Category | Critical | High | Medium | Low | Total |
|----------|----------|------|--------|-----|-------|
| Technical | 0 | 2 | 3 | 0 | 5 |
| Data | 0 | 0 | 3 | 0 | 3 |
| Business | 0 | 1 | 3 | 0 | 4 |
| Organizational | 0 | 0 | 2 | 1 | 3 |
| Project Management | 0 | 0 | 2 | 1 | 3 |
| **Total** | **0** | **3** | **13** | **2** | **18** |

### Top 5 Risks by Score
1. **R002** - Model Performance Below Expectations (Score: 15)
2. **R001** - Inadequate Data Quality (Score: 16)
3. **R011** - User Adoption Resistance (Score: 16)
4. **R004** - Scalability & Performance Issues (Score: 12)
5. **R006** - Insufficient Training Data (Score: 12)

### Risk Trend
[Track risk scores over time to show if risks are increasing or decreasing]

---

## Risk Response Actions

### Actions Due This Week
| Risk ID | Action | Owner | Due Date | Status |
|---------|--------|-------|----------|--------|
| R001 | Complete data quality assessment | Data Engineer | [Date] | In Progress |
| R011 | Conduct change impact workshop | Change Manager | [Date] | Not Started |
| R013 | Finalize resource commitments | Project Manager | [Date] | In Progress |

### Overdue Actions
| Risk ID | Action | Owner | Original Due | Days Overdue |
|---------|--------|-------|--------------|--------------|
| - | - | - | - | - |

---

## Closed Risks / Risk Retirement

| Risk ID | Risk | Closure Date | Reason |
|---------|------|--------------|--------|
| R099 | [Example Closed Risk] | [Date] | Mitigation successful, no longer applicable |

---

## Escalated Risks

| Risk ID | Risk | Escalated To | Date | Status |
|---------|------|--------------|------|--------|
| - | - | - | - | - |

---

## Notes for Risk Management

### Weekly Risk Review Checklist
- [ ] Review all active risks
- [ ] Update probability/impact if changed
- [ ] Check mitigation action status
- [ ] Identify any new risks
- [ ] Close risks that are no longer applicable
- [ ] Escalate high risks to steering committee
- [ ] Update risk dashboard

### Risk Review Meeting Agenda
1. New risks identified
2. Top 5 risks status update
3. Risks requiring escalation
4. Mitigation actions overdue
5. Risks ready for closure
6. Risk trends discussion

---

## Appendix: Risk Templates

### New Risk Template
```
Risk ID: [Auto-assigned]
Category: [Technical/Data/Business/Organizational/PM]
Description: [Clear description of the risk]
Cause: [Root cause]
Impact: [What happens if it occurs]
Probability: [1-5]
Impact: [1-5]
Risk Score: [P × I]
Owner: [Name]
Mitigation Strategy: [How to prevent]
Contingency Plan: [What to do if it occurs]
Trigger Indicators: [Warning signs]
```

---

**Document Control**
- **Version**: 1.0
- **Last Updated**: [Date]
- **Next Review**: [Date]
- **Owner**: [Project Manager]

---

## Version History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | [Date] | [Name] | Initial risk register created |
