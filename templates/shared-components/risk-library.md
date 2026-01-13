# Risk Library for AI Projects
## Shared Component: 18 Pre-Defined Risk Templates

**Purpose**: Central library of common AI project risks with detailed mitigation strategies  
**Use In**: Risk registers, business cases, phase planning, executive briefings  
**Version**: 1.0  
**Last Updated**: January 13, 2026

---

## Quick Links

- 📊 **Use This In**: [Risk Register Template](../05-risk-register.md)
- 📖 **Related**: [ROI Analysis](./roi-financial-analysis.md) | [Stakeholder Personas](./stakeholder-personas.md)
- 🎯 **Quick Reference**: [Risk Quick Reference (1-page)](./risk-quick-reference.md)

---

## How to Use This Library

### For New Projects:
1. Review all 18 pre-defined risks
2. Select relevant risks for your project context
3. Copy selected risks into your [Risk Register](../05-risk-register.md)
4. Customize probability, impact, and mitigation plans
5. Add project-specific risks

### Risk Scoring:
- **Probability**: 1 (Very Low) to 5 (Very High)
- **Impact**: 1 (Very Low) to 5 (Critical)
- **Risk Score**: Probability × Impact
- **Priority**: 15-25 (Critical), 10-14 (High), 5-9 (Medium), 1-4 (Low)

---

## CATEGORY 1: TECHNICAL RISKS (5 risks)

### R001: Inadequate Data Quality

| Field | Details |
|-------|---------|
| **Risk ID** | R001 |
| **Category** | Technical - Data |
| **Description** | Available data may have poor quality, missing values, or inconsistencies that prevent effective model training |
| **Typical Causes** | Legacy systems, data entry errors, incomplete data collection processes, poor data governance |
| **Typical Impact** | Model accuracy below acceptable thresholds, project delays, additional data cleansing effort required |
| **Typical Probability** | 4 - High (occurs in 60-80% of AI projects) |
| **Typical Impact** | 4 - High |
| **Typical Risk Score** | 16 (High Priority) |
| **Mitigation Strategy** | • Conduct comprehensive data quality assessment early in discovery phase<br>• Implement automated data validation rules<br>• Set up continuous data quality monitoring<br>• Allocate 30-40% of project time for data preparation<br>• Engage data stewards from source systems<br>• Create data quality SLAs with data owners |
| **Contingency Plan** | • Engage data stewards to improve source data quality<br>• Consider synthetic data generation techniques<br>• Adjust model approach to handle data limitations<br>• Use data imputation and cleaning algorithms<br>• Scope model to high-quality data subset |
| **Trigger Indicators** | • Data completeness < 80%<br>• High error rates in validation (>10%)<br>• Significant outliers (>3 standard deviations)<br>• Inconsistent data formats across sources<br>• Missing critical fields |
| **Best Practices** | • Use 6-dimension data quality framework (Accuracy, Completeness, Consistency, Timeliness, Validity, Uniqueness)<br>• Create data quality dashboards<br>• Implement data lineage tracking |

---

### R002: Model Performance Below Expectations

| Field | Details |
|-------|---------|
| **Risk ID** | R002 |
| **Category** | Technical - AI/ML |
| **Description** | ML model fails to achieve target accuracy, precision, or recall metrics defined in success criteria |
| **Typical Causes** | Insufficient training data, poor feature selection, algorithm limitations, concept drift, unrealistic expectations |
| **Typical Impact** | Business value not realized, stakeholder confidence lost, project cancellation risk |
| **Typical Probability** | 3 - Medium (30-40% of AI projects) |
| **Typical Impact** | 5 - Critical |
| **Typical Risk Score** | 15 (High Priority) |
| **Mitigation Strategy** | • Set realistic performance targets based on baseline and industry benchmarks<br>• Use ensemble methods and state-of-the-art algorithms<br>• Implement comprehensive feature engineering<br>• Plan for 3-5 modeling iterations<br>• Engage external ML experts for review<br>• Use transfer learning from pre-trained models<br>• Conduct thorough exploratory data analysis |
| **Contingency Plan** | • Adjust success criteria if business value still achieved<br>• Pivot to hybrid approach (rules + AI)<br>• Implement human-in-the-loop workflow<br>• Scope model to high-confidence predictions only<br>• Use explainable AI to identify failure modes |
| **Trigger Indicators** | • Prototype model < 70% of target performance<br>• No improvement after 3 modeling iterations<br>• Cross-validation results declining<br>• Validation loss increasing<br>• Model cannot beat simple baseline |
| **Best Practices** | • Establish baseline model performance first<br>• Test multiple algorithms<br>• Implement rigorous cross-validation<br>• Track model performance metrics continuously |

---

### R003: Integration Complexity

| Field | Details |
|-------|---------|
| **Risk ID** | R003 |
| **Category** | Technical - Integration |
| **Description** | Complexity of integrating AI solution with existing enterprise systems exceeds initial estimates |
| **Typical Causes** | Legacy systems, undocumented APIs, security constraints, data format incompatibilities, organizational silos |
| **Typical Impact** | Project delays, increased costs, reduced functionality, technical debt accumulation |
| **Typical Probability** | 3 - Medium (40-50% of enterprise projects) |
| **Typical Impact** | 3 - Medium |
| **Typical Risk Score** | 9 (Medium Priority) |
| **Mitigation Strategy** | • Conduct detailed integration analysis during discovery<br>• Engage all system owners early in planning<br>• Use enterprise service bus or API gateway<br>• Build integration spike solutions during prototype<br>• Allocate 20-30% schedule buffer for integration<br>• Document all integration points with sequence diagrams<br>• Use Azure Logic Apps or Data Factory for complex integrations |
| **Contingency Plan** | • Simplify integration scope (defer non-critical)<br>• Use batch processing instead of real-time<br>• Build temporary manual processes as bridge<br>• Implement facade pattern to isolate complexity<br>• Engage integration specialists/contractors |
| **Trigger Indicators** | • API documentation missing or outdated<br>• Test integrations failing repeatedly<br>• System owners unresponsive<br>• Authentication/authorization issues<br>• Data transformation taking longer than expected |
| **Best Practices** | • Create integration inventory early<br>• Use contract-first API design<br>• Implement comprehensive integration testing<br>• Build monitoring for all integration points |

---

### R004: Scalability & Performance Issues

| Field | Details |
|-------|---------|
| **Risk ID** | R004 |
| **Category** | Technical - Infrastructure |
| **Description** | Solution cannot handle expected production load or meet response time requirements |
| **Typical Causes** | Underestimated load volumes, inefficient code, resource constraints, architectural limitations, database bottlenecks |
| **Typical Impact** | Poor user experience, system downtime, additional unplanned infrastructure costs, user abandonment |
| **Typical Probability** | 3 - Medium (30-40% of projects) |
| **Typical Impact** | 4 - High |
| **Typical Risk Score** | 12 (High Priority) |
| **Mitigation Strategy** | • Define clear performance requirements (response time, throughput, concurrency)<br>• Conduct load testing early and continuously<br>• Design for horizontal scalability from start<br>• Use Azure autoscaling and load balancers<br>• Implement caching strategies (Redis, CDN)<br>• Optimize database queries and indexing<br>• Use asynchronous processing for heavy workloads<br>• Plan for 3x expected peak load |
| **Contingency Plan** | • Scale up infrastructure (vertical scaling)<br>• Implement request throttling and queueing<br>• Reduce feature scope temporarily<br>• Implement graceful degradation<br>• Add read replicas for database |
| **Trigger Indicators** | • Response time > 3 seconds in tests<br>• CPU/Memory utilization > 80%<br>• Failed load tests<br>• Timeout errors increasing<br>• Database query time > 1 second |
| **Best Practices** | • Performance test with 2-3x expected load<br>• Monitor performance continuously<br>• Use application performance monitoring (APM) tools<br>• Implement circuit breakers for resilience |

---

### R005: Security & Compliance Violation

| Field | Details |
|-------|---------|
| **Risk ID** | R005 |
| **Category** | Technical - Security |
| **Description** | Solution fails to meet security standards or regulatory compliance requirements (GDPR, HIPAA, SOC 2, etc.) |
| **Typical Causes** | Incomplete requirements, lack of security expertise, complex regulations, late security reviews, vendor dependencies |
| **Typical Impact** | Legal liability, regulatory fines, project shutdown, reputational damage, data breaches |
| **Typical Probability** | 2 - Low (10-20% if properly managed) |
| **Typical Impact** | 5 - Critical |
| **Typical Risk Score** | 10 (High Priority) |
| **Mitigation Strategy** | • Engage security and compliance teams from day 1<br>• Conduct Data Privacy Impact Assessment (DPIA)<br>• Implement security-by-design principles<br>• Regular security reviews and penetration testing<br>• Use Azure Security Center and Defender<br>• Follow OWASP Top 10 guidelines<br>• Implement encryption at rest and in transit<br>• Use Azure Key Vault for secrets management<br>• Document all compliance requirements |
| **Contingency Plan** | • Rapid security remediation sprint<br>• Delay go-live until fully compliant<br>• Engage external security auditors<br>• Implement additional controls/compensating controls<br>• Purchase cybersecurity insurance |
| **Trigger Indicators** | • Security scan failures<br>• Compliance gaps identified in audit<br>• PII exposure detected<br>• Failed penetration tests<br>• Regulatory inquiry received |
| **Best Practices** | • Build security into CI/CD pipeline<br>• Use infrastructure-as-code with security baselines<br>• Implement zero-trust architecture<br>• Regular compliance audits |

---

## CATEGORY 2: DATA RISKS (3 risks)

### R006: Insufficient Training Data

| Field | Details |
|-------|---------|
| **Risk ID** | R006 |
| **Category** | Data - Volume |
| **Description** | Insufficient volume or variety of labeled data to train effective ML models that generalize well |
| **Typical Causes** | Limited historical data, manual labeling required, rare edge cases, imbalanced classes, new use case |
| **Typical Impact** | Model overfitting, poor generalization to production, inability to achieve performance targets |
| **Typical Probability** | 3 - Medium (40-50% of AI projects) |
| **Typical Impact** | 4 - High |
| **Typical Risk Score** | 12 (High Priority) |
| **Mitigation Strategy** | • Assess data availability during discovery (need 1000+ samples minimum)<br>• Use transfer learning from pre-trained models<br>• Implement data augmentation techniques<br>• Consider active learning approach<br>• Budget $50K-$200K for data labeling services<br>• Explore synthetic data generation<br>• Partner with data providers if needed<br>• Use semi-supervised learning techniques |
| **Contingency Plan** | • Use semi-supervised or self-supervised learning<br>• Generate synthetic data using GANs<br>• Reduce model scope to data-rich subset<br>• Implement few-shot learning techniques<br>• Collect more data (extend timeline) |
| **Trigger Indicators** | • Training set < 1000 samples per class<br>• Class imbalance > 90/10 ratio<br>• Validation curve not converging<br>• High variance between train and test performance<br>• Expert assessment deems data insufficient |
| **Best Practices** | • Calculate required sample size early (statistical power analysis)<br>• Track data collection progress<br>• Prioritize high-quality labels over quantity<br>• Use cross-validation to maximize data usage |

---

### R007: Data Access & Privacy Constraints

| Field | Details |
|-------|---------|
| **Risk ID** | R007 |
| **Category** | Data - Privacy & Access |
| **Description** | Privacy regulations or data access restrictions prevent use of required data for training or inference |
| **Typical Causes** | GDPR/CCPA requirements, data residency rules, internal data policies, lack of consent, cross-border restrictions |
| **Typical Impact** | Project delays, reduced model scope, need for alternative data sources, compliance violations |
| **Typical Probability** | 3 - Medium (40% of projects) |
| **Typical Impact** | 3 - Medium |
| **Typical Risk Score** | 9 (Medium Priority) |
| **Mitigation Strategy** | • Engage legal/compliance team in discovery phase<br>• Conduct Data Privacy Impact Assessment (DPIA)<br>• Implement data anonymization/pseudonymization<br>• Use differential privacy techniques<br>• Obtain proper data access approvals with documented justification<br>• Implement data minimization principles<br>• Use federated learning if data cannot be centralized<br>• Ensure audit trail for all data access |
| **Contingency Plan** | • Use aggregated or anonymized data only<br>• Implement federated learning architecture<br>• Redesign approach to avoid sensitive data<br>• Use synthetic data that preserves statistical properties<br>• Obtain explicit user consent programs |
| **Trigger Indicators** | • Data access request denied by data owners<br>• Privacy officer raises compliance concerns<br>• Cannot obtain required user consent<br>• Cross-border data transfer blocked<br>• Legal review identifies GDPR/CCPA issues |
| **Best Practices** | • Complete DPIA before data access<br>• Document data usage justification<br>• Implement data retention policies<br>• Use privacy-preserving ML techniques |

---

### R008: Data Drift & Model Degradation

| Field | Details |
|-------|---------|
| **Risk ID** | R008 |
| **Category** | Data - Ongoing Operations |
| **Description** | Production data distribution changes over time (concept drift), causing model performance to degrade post-deployment |
| **Typical Causes** | Business environment changes, seasonal patterns, market shifts, user behavior evolution, external events |
| **Typical Impact** | Declining accuracy over time, business value erosion, user trust loss, incorrect predictions |
| **Typical Probability** | 4 - High (60-70% of deployed models) |
| **Typical Impact** | 3 - Medium |
| **Typical Risk Score** | 12 (High Priority) |
| **Mitigation Strategy** | • Implement automated data drift monitoring (statistical tests)<br>• Set up ML pipeline for automated model retraining<br>• Define model performance thresholds and alerts<br>• Create alerting system for drift detection<br>• Plan regular model refresh cycles (quarterly minimum)<br>• Use Azure Machine Learning monitoring<br>• Implement A/B testing for model versions<br>• Log all predictions for retrospective analysis |
| **Contingency Plan** | • Trigger emergency model retraining<br>• Rollback to previous stable model version<br>• Implement temporary manual review process<br>• Increase prediction confidence thresholds<br>• Route uncertain cases to human experts |
| **Trigger Indicators** | • Model accuracy drops > 5% from baseline<br>• Prediction distribution shifts significantly<br>• Business KPIs decline unexpectedly<br>• Feature distributions change (detected by monitoring)<br>• User complaints about prediction quality |
| **Best Practices** | • Monitor model performance daily in production<br>• Compare current vs. training data distributions<br>• Set up automated retraining pipeline<br>• Version all models with rollback capability |

---

## CATEGORY 3: BUSINESS RISKS (4 risks)

### R009: Unclear or Changing Requirements

| Field | Details |
|-------|---------|
| **Risk ID** | R009 |
| **Category** | Business - Requirements |
| **Description** | Business requirements are unclear, incomplete, conflicting, or frequently changing throughout the project |
| **Typical Causes** | Stakeholder misalignment, unclear vision, evolving business understanding, competing priorities, politics |
| **Typical Impact** | Extensive rework, scope creep, budget overruns, timeline delays, stakeholder dissatisfaction, team frustration |
| **Typical Probability** | 4 - High (50-60% of projects) |
| **Typical Impact** | 3 - Medium |
| **Typical Risk Score** | 12 (High Priority) |
| **Mitigation Strategy** | • Invest 3-4 weeks in thorough discovery with workshops<br>• Use interactive prototypes to clarify requirements early<br>• Implement formal change control process<br>• Conduct bi-weekly stakeholder reviews<br>• Document all requirements in BRD with approval<br>• Use user stories and acceptance criteria<br>• Apply Five Whys to understand root problems<br>• Create requirements traceability matrix |
| **Contingency Plan** | • Freeze scope after discovery phase<br>• Push all changes to Phase 2 backlog<br>• Escalate conflicts to executive sponsor<br>• Conduct emergency requirements workshop<br>• Implement agile approach with shorter sprints |
| **Trigger Indicators** | • Multiple change requests per week<br>• Stakeholders disagreeing on priorities<br>• Prototype feedback contradictory<br>• Requirements document has >10 revisions<br>• Team confused about objectives |
| **Best Practices** | • Get written approval for requirements<br>• Use prototypes to validate understanding<br>• Document assumptions explicitly<br>• Manage scope with change control board |

---

### R010: Lack of Executive Sponsorship

| Field | Details |
|-------|---------|
| **Risk ID** | R010 |
| **Category** | Business - Governance |
| **Description** | Insufficient or declining executive support and engagement throughout project lifecycle |
| **Typical Causes** | Competing priorities, executive turnover, lack of AI understanding, political resistance, budget pressures |
| **Typical Impact** | Blocked decisions, resource constraints, budget cuts, project cancellation, lack of organizational support |
| **Typical Probability** | 2 - Low (15-20% if managed well) |
| **Typical Impact** | 5 - Critical |
| **Typical Risk Score** | 10 (High Priority) |
| **Mitigation Strategy** | • Secure strong, committed sponsor before project start<br>• Monthly executive steering committee meetings<br>• Weekly executive dashboard/status updates<br>• Demonstrate quick wins and tangible value early<br>• Keep sponsor informed of all major risks<br>• Build steering committee with multiple executives<br>• Use executive coaching guide for engagement<br>• Align project to executive's strategic objectives |
| **Contingency Plan** | • Escalate to higher-level executive (CEO/Board)<br>• Seek alternative sponsor in organization<br>• Re-present business case with updated ROI<br>• Demonstrate competitor risk if not proceeding<br>• Pause project until sponsorship secured |
| **Trigger Indicators** | • Sponsor missing >2 consecutive meetings<br>• Decisions delayed > 2 weeks consistently<br>• Budget approvals stalled<br>• Sponsor not responding to communications<br>• Sponsor announces departure/role change |
| **Best Practices** | • Get written sponsor commitment upfront<br>• Keep sponsor engaged with monthly touchpoints<br>• Celebrate wins publicly<br>• Use sponsor to remove organizational blockers |

---

### R011: User Adoption Resistance

| Field | Details |
|-------|---------|
| **Risk ID** | R011 |
| **Category** | Business - Change Management |
| **Description** | End users resist adopting the AI solution due to fear, skepticism, workflow disruption, or poor user experience |
| **Typical Causes** | Fear of job loss, lack of trust in AI, poor UX, inadequate training, "not invented here" syndrome, change fatigue |
| **Typical Impact** | Low usage rates, business benefits not realized, project deemed failure, negative ROI, user workarounds |
| **Typical Probability** | 4 - High (60% of AI projects face some resistance) |
| **Typical Impact** | 4 - High |
| **Typical Risk Score** | 16 (Critical Priority) |
| **Mitigation Strategy** | • Invest in comprehensive change management from project start<br>• Involve users early in design (co-creation workshops)<br>• Build comprehensive training program (hands-on, role-based)<br>• Emphasize augmentation not replacement messaging<br>• Ensure excellent, intuitive user experience<br>• Create champions/advocate network (10% of users)<br>• Provide ongoing support (help desk, office hours)<br>• Celebrate user success stories<br>• Make adoption gradual with opt-in period |
| **Contingency Plan** | • Intensive one-on-one coaching and support<br>• Adjust workflow integration based on feedback<br>• Make adoption gradual or optional initially<br>• Implement incentive programs for early adopters<br>• Address job security concerns directly with leadership |
| **Trigger Indicators** | • Negative feedback in UAT sessions<br>• Low training attendance (<70%)<br>• Rumors or concerns raised in town halls<br>• Usage metrics below 50% in pilot<br>• Complaints to management about "being forced" |
| **Best Practices** | • Start change management in mobilization phase<br>• Conduct change impact assessment<br>• Track adoption metrics daily post-launch<br>• Provide multiple training modalities |

---

### R012: Unrealistic ROI Expectations

| Field | Details |
|-------|---------|
| **Risk ID** | R012 |
| **Category** | Business - Value Realization |
| **Description** | Stakeholders have unrealistic expectations about AI capabilities, timeline to value, or ROI magnitude |
| **Typical Causes** | AI hype in media, misunderstanding of limitations, overly optimistic business case, lack of AI literacy |
| **Typical Impact** | Project perceived as failure even if technically successful, budget cuts, loss of trust in AI initiatives |
| **Typical Probability** | 3 - Medium (30-40% of projects) |
| **Typical Impact** | 3 - Medium |
| **Typical Risk Score** | 9 (Medium Priority) |
| **Mitigation Strategy** | • Set realistic expectations early with education sessions<br>• Educate stakeholders on AI capabilities AND limitations<br>• Build conservative business case (70-80% of theoretical max)<br>• Define clear, measurable success criteria<br>• Demonstrate value incrementally with quick wins<br>• Show industry benchmarks and case studies<br>• Use AI Readiness Assessment to calibrate expectations<br>• Document assumptions transparently |
| **Contingency Plan** | • Re-baseline expectations with revised business case<br>• Showcase achieved benefits even if below original target<br>• Extend benefit realization timeline<br>• Pivot messaging to qualitative benefits<br>• Conduct AI education workshops |
| **Trigger Indicators** | • Stakeholder comments suggesting 100% automation<br>• Business case shows >500% ROI in Year 1<br>• Expectations of immediate accuracy improvement<br>• Lack of understanding that AI requires training data<br>• Comparing to consumer AI (ChatGPT) expectations |
| **Best Practices** | • Use ROI calculator with conservative assumptions<br>• Show ramp-up period (60% in Y1, 90% in Y2)<br>• Set success criteria collaboratively<br>• Track and report benefits monthly |

---

## CATEGORY 4: ORGANIZATIONAL RISKS (3 risks)

### R013: Resource Availability

| Field | Details |
|-------|---------|
| **Risk ID** | R013 |
| **Category** | Organizational - Resources |
| **Description** | Key resources (AI experts, data scientists, SMEs, business owners) not available when needed |
| **Typical Causes** | Competing projects, resource turnover, limited AI talent pool, budget constraints, poor resource planning |
| **Typical Impact** | Project delays, quality issues, increased costs from contractors, knowledge gaps, team burnout |
| **Typical Probability** | 3 - Medium (40% of projects) |
| **Typical Impact** | 4 - High |
| **Typical Risk Score** | 12 (High Priority) |
| **Mitigation Strategy** | • Secure written resource commitments before project start<br>• Cross-train team members on critical skills<br>• Budget for contractors/consultants (15-20% of budget)<br>• Build 20% resource buffer into schedule<br>• Create resource escalation process to leadership<br>• Use RACI matrix to clarify commitments<br>• Identify backup resources for key roles<br>• Conduct capacity planning with resource managers |
| **Contingency Plan** | • Engage external contractors immediately<br>• Adjust timeline to match resource availability<br>• Reduce scope to match available resources<br>• Escalate to executive sponsor for resource prioritization<br>• Reallocate resources from lower priority work |
| **Trigger Indicators** | • Resources allocated < 50% of promised time<br>• Key resource announces resignation<br>• Competing project pulling resources<br>• Team members working >50 hours/week<br>• Resource manager not responding to requests |
| **Best Practices** | • Get resource commitments in writing (RACI)<br>• Track actual vs. planned resource allocation<br>• Identify resource risks early<br>• Build bench of pre-approved contractors |

---

### R014: Lack of AI/ML Expertise

| Field | Details |
|-------|---------|
| **Risk ID** | R014 |
| **Category** | Organizational - Skills |
| **Description** | Team lacks necessary AI/ML expertise, best practices knowledge, or domain experience to deliver successfully |
| **Typical Causes** | Limited internal AI capability, emerging technology, skill gaps in team, underestimating complexity |
| **Typical Impact** | Poor technical decisions, suboptimal solutions, extended timeline, quality issues, technical debt |
| **Typical Probability** | 3 - Medium (40-50% of first AI projects) |
| **Typical Impact** | 4 - High |
| **Typical Risk Score** | 12 (High Priority) |
| **Mitigation Strategy** | • Assess skill gaps during project planning (skills matrix)<br>• Provide comprehensive training and upskilling ($10K-$30K)<br>• Engage external AI consultants for critical phases<br>• Partner with Microsoft AI specialists<br>• Use proven ML frameworks and Azure managed services<br>• Implement peer code reviews and architecture reviews<br>• Bring in industry experts for workshops<br>• Consider AI Center of Excellence model |
| **Contingency Plan** | • Increase external consultant engagement (add budget)<br>• Simplify technical approach to match team skills<br>• Use more Azure managed services (less custom code)<br>• Hire experienced AI/ML engineer<br>• Partner with SI firm for delivery |
| **Trigger Indicators** | • Team struggling with basic ML concepts<br>• Multiple technical pivots without clear rationale<br>• External expert recommendations consistently ignored<br>• Code quality issues in reviews<br>• Unable to explain model decisions |
| **Best Practices** | • Complete skills assessment before project<br>• Create training plan for identified gaps<br>• Pair junior team members with experts<br>• Budget for external expertise from start |

---

### R015: Vendor/Third-Party Dependency

| Field | Details |
|-------|---------|
| **Risk ID** | R015 |
| **Category** | Organizational - External Dependencies |
| **Description** | Critical dependency on external vendors or partners (Microsoft, data providers, SI partners) causes delays or issues |
| **Typical Causes** | Vendor delays, service outages, contract issues, vendor prioritization, lack of vendor responsiveness |
| **Typical Impact** | Project delays, blocked workstreams, potential cost increases, reduced functionality |
| **Typical Probability** | 2 - Low (15-20% with good vendor management) |
| **Typical Impact** | 3 - Medium |
| **Typical Risk Score** | 6 (Low Priority) |
| **Mitigation Strategy** | • Identify all vendor dependencies in discovery phase<br>• Build relationships with vendor account teams early<br>• Include vendors in project planning and timelines<br>• Ensure contractual SLAs for critical dependencies<br>• Build 2-week schedule buffers around vendor dependencies<br>• Have backup vendors identified where possible<br>• Regular check-ins with vendor teams<br>• Escalation paths to vendor management documented |
| **Contingency Plan** | • Escalate to vendor account manager/partner manager<br>• Use alternative vendors if available<br>• Adjust project schedule around vendor delays<br>• Build temporary workaround solutions<br>• Negotiate penalty clauses for missed commitments |
| **Trigger Indicators** | • Vendor missing agreed commitments or deadlines<br>• Azure service issues impacting development<br>• Contract negotiations stalled<br>• Vendor unresponsive to inquiries<br>• Vendor announces product discontinuation |
| **Best Practices** | • Map all vendor dependencies in project plan<br>• Establish vendor contacts before project start<br>• Review SLAs and support tier<br>• Monitor vendor health/stability |

---

## CATEGORY 5: PROJECT MANAGEMENT RISKS (3 risks)

### R016: Scope Creep

| Field | Details |
|-------|---------|
| **Risk ID** | R016 |
| **Category** | Project Management - Scope Control |
| **Description** | Uncontrolled expansion of project scope without corresponding adjustments to time, cost, and resources |
| **Typical Causes** | Weak change control, stakeholder pressure, unclear initial scope, "while we're at it" syndrome, gold plating |
| **Typical Impact** | Budget overruns, schedule delays, team burnout, quality degradation, missed deadlines |
| **Typical Probability** | 4 - High (60% of projects) |
| **Typical Impact** | 3 - Medium |
| **Typical Risk Score** | 12 (High Priority) |
| **Mitigation Strategy** | • Define clear scope baseline with in/out of scope lists<br>• Implement formal change control board (CCB)<br>• Bi-weekly scope reviews with stakeholders<br>• Manage stakeholder expectations proactively<br>• Document all changes with impact analysis (time, cost, risk)<br>• Require executive approval for scope changes<br>• Create Phase 2 backlog for new requests<br>• Use agile methodology with time-boxed sprints |
| **Contingency Plan** | • Freeze scope temporarily (no new changes)<br>• Defer all new requests to Phase 2<br>• Escalate to executive sponsor for prioritization<br>• Re-baseline project plan with new scope<br>• Negotiate timeline or resource increase |
| **Trigger Indicators** | • Frequent "small" additions that accumulate<br>• Schedule slipping consistently<br>• Team working overtime regularly<br>• Change requests > 5 per sprint<br>• Scope baseline document outdated |
| **Best Practices** | • Get formal scope approval in charter<br>• Use change request template for all changes<br>• Track cumulative impact of changes<br>• Say "yes, in Phase 2" to new requests |

---

### R017: Inadequate Testing

| Field | Details |
|-------|---------|
| **Risk ID** | R017 |
| **Category** | Project Management - Quality Assurance |
| **Description** | Insufficient testing time, coverage, or rigor leads to production defects and quality issues |
| **Typical Causes** | Schedule pressure, underestimating testing effort, lack of test resources, compressing QA to meet dates |
| **Typical Impact** | Production defects, poor user experience, emergency fixes, reputation damage, user trust loss |
| **Typical Probability** | 3 - Medium (30-40% of projects) |
| **Typical Impact** | 4 - High |
| **Typical Risk Score** | 12 (High Priority) |
| **Mitigation Strategy** | • Allocate adequate testing time (20-25% of build phase)<br>• Define comprehensive test strategy covering all levels<br>• Automate regression testing (save 50% effort)<br>• Involve users in UAT early and extensively<br>• Never compress testing to meet arbitrary dates<br>• Implement continuous testing in CI/CD pipeline<br>• Test with production-like data volumes<br>• Include bias and fairness testing for AI models |
| **Contingency Plan** | • Delay go-live to complete adequate testing<br>• Implement phased rollout to limit blast radius<br>• Enhanced hypercare support (24/7 for 2 weeks)<br>• Increase test resources (add contractors)<br>• Focus on critical path testing only |
| **Trigger Indicators** | • Test coverage < 70% of requirements<br>• UAT feedback rate declining<br>• Pressure from leadership to skip test phases<br>• Defects found in production not caught in testing<br>• Test team working excessive overtime |
| **Best Practices** | • Create comprehensive test strategy early<br>• Use test-driven development (TDD)<br>• Automate everything that can be automated<br>• Track test coverage and defect metrics |

---

### R018: Communication Breakdown

| Field | Details |
|-------|---------|
| **Risk ID** | R018 |
| **Category** | Project Management - Communication |
| **Description** | Poor communication leading to misunderstandings, misalignment, duplicated effort, and errors |
| **Typical Causes** | Distributed teams, unclear communication channels, information overload, cultural differences, silos |
| **Typical Impact** | Rework, confusion, delays, stakeholder dissatisfaction, team conflict, missed requirements |
| **Typical Probability** | 3 - Medium (30-40% of distributed projects) |
| **Typical Impact** | 2 - Low |
| **Typical Risk Score** | 6 (Low Priority) |
| **Mitigation Strategy** | • Establish clear communication plan with RACI<br>• Daily standups for core team (15 min max)<br>• Weekly status meetings with extended team<br>• Use Microsoft Teams/SharePoint for collaboration<br>• Document all key decisions in decision log<br>• Create feedback loops and check-in points<br>• Use visual management (dashboards, Kanban boards)<br>• Establish "single source of truth" for project docs |
| **Contingency Plan** | • Increase meeting frequency temporarily<br>• Conduct one-on-one stakeholder meetings<br>• Communication audit and reset<br>• Bring distributed team together for in-person workshop<br>• Clarify communication protocols |
| **Trigger Indicators** | • Team members working on conflicting solutions<br>• Stakeholders surprised by project status<br>• Requirements misunderstood<br>• Decisions being questioned or re-litigated<br>• Email threads >10 people with confusion |
| **Best Practices** | • Create communication plan in mobilization<br>• Use standard meeting agendas<br>• Send meeting notes within 24 hours<br>• Over-communicate in distributed teams |

---

## Quick Reference Matrix

### Risk Priority Summary

| Risk ID | Risk Name | Category | Typical Score | Frequency |
|---------|-----------|----------|---------------|-----------|
| **R011** | User Adoption Resistance | Business | 16 (Critical) | 60% |
| **R001** | Inadequate Data Quality | Technical | 16 (High) | 70% |
| **R002** | Model Performance Issues | Technical | 15 (High) | 40% |
| **R016** | Scope Creep | PM | 12 (High) | 60% |
| **R004** | Scalability Issues | Technical | 12 (High) | 35% |
| **R006** | Insufficient Training Data | Data | 12 (High) | 45% |
| **R008** | Data Drift | Data | 12 (High) | 65% |
| **R009** | Unclear Requirements | Business | 12 (High) | 55% |
| **R013** | Resource Availability | Organizational | 12 (High) | 40% |
| **R014** | Lack of AI Expertise | Organizational | 12 (High) | 50% |
| **R017** | Inadequate Testing | PM | 12 (High) | 35% |
| **R005** | Security/Compliance | Technical | 10 (High) | 15% |
| **R010** | Lack of Sponsorship | Business | 10 (High) | 20% |
| **R003** | Integration Complexity | Technical | 9 (Medium) | 45% |
| **R007** | Data Access Constraints | Data | 9 (Medium) | 40% |
| **R012** | Unrealistic ROI | Business | 9 (Medium) | 35% |
| **R015** | Vendor Dependency | Organizational | 6 (Low) | 20% |
| **R018** | Communication Breakdown | PM | 6 (Low) | 35% |

---

## Risk Categories Summary

| Category | # of Risks | Avg Priority | Top Risk |
|----------|-----------|--------------|----------|
| **Technical** | 5 | High | R001 - Data Quality (16) |
| **Data** | 3 | High | R006 - Insufficient Data (12) |
| **Business** | 4 | High | R011 - User Adoption (16) |
| **Organizational** | 3 | High | R013/R014 - Resources/Skills (12) |
| **Project Management** | 3 | High | R016 - Scope Creep (12) |

---

## How to Customize for Your Project

### Step 1: Select Relevant Risks
Review all 18 risks and select those applicable to your project context. Not all risks apply to all projects.

### Step 2: Adjust Probability & Impact
Update probability and impact based on:
- Your organization's maturity
- Project complexity
- Team experience
- Risk appetite

### Step 3: Customize Mitigation
Tailor mitigation strategies to:
- Your available resources
- Your organizational processes
- Your risk tolerance
- Your timeline constraints

### Step 4: Add Project-Specific Risks
Add 3-5 risks unique to your project:
- Industry-specific regulations
- Legacy system constraints
- Organizational politics
- Market timing

### Step 5: Assign Owners
Assign a risk owner for each risk who:
- Monitors trigger indicators
- Executes mitigation strategies
- Reports status weekly
- Escalates when needed

---

## Related Resources

### Internal
- **[Risk Register Template](../05-risk-register.md)** - Project-specific risk tracking
- **[Business Case Template](../02-business-case.md)** - Includes risk section
- **[ROI Analysis](./roi-financial-analysis.md)** - Financial risk assessment

### External
- [Project Management Institute - Risk Management](https://www.pmi.org/learning/library/risk-analysis-project-management-7070)
- [AI Risk Management Framework](https://www.nist.gov/itl/ai-risk-management-framework)

---

## Version History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-13 | PM | Initial risk library created with 18 pre-defined risks |

---

**Questions or Improvements?**  
Open an issue or submit a PR to add more risks or improve mitigation strategies!

**Last Updated**: January 13, 2026
