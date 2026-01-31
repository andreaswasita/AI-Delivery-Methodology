# Discovery Phase Checklist

## Document Information

**Project Name**: [Enter AI Project Name]  
**Phase**: Discovery  
**Owner**: [Business Analyst / Project Manager]  
**Date**: [DD/MM/YYYY]

---

## Phase Overview

**Purpose**: Deeply understand the business problem, assess data availability and quality, validate AI feasibility, and design the solution approach.

**Duration**: Typically 2-4 weeks

**Key Outcome**: Validated understanding of requirements, confirmed data availability, proven AI feasibility, and approved solution design.

---

## PHASE GATE: Mobilisation Complete

**Prerequisites:**
- [x] Project Charter approved
- [x] Business Case approved
- [x] Team mobilised
- [x] Governance established
- [x] Azure environment ready

---

## WEEK 1: BUSINESS REQUIREMENTS & USE CASES

### 1.1 Business Requirements Workshop Preparation

- [ ] **Workshop Planning**
  - [ ] Workshop objectives defined
  - [ ] Participant list confirmed (business stakeholders, SMEs, end users)
  - [ ] Date/time scheduled (minimum 4 hours)
  - [ ] Location/Teams meeting booked
  - [ ] Pre-read materials sent to participants
  - [ ] Whiteboard/collaboration tools prepared (Miro, Mural)

- [ ] **Materials Prepared**
  - [ ] Workshop agenda created
  - [ ] Current state process maps (if available)
  - [ ] Pain points discussion guide
  - [ ] Use case template ready
  - [ ] Recording setup arranged

---

### 1.2 Business Requirements Workshop Execution

- [ ] **Workshop Session 1: Current State (2 hours)**
  - [ ] Welcome and introductions
  - [ ] Project context and objectives reviewed
  - [ ] Current business processes mapped
  - [ ] Pain points identified and prioritized
  - [ ] Quantitative metrics captured (time, cost, volume, errors)
  - [ ] Stakeholder perspectives documented
  - [ ] Constraints and limitations identified

- [ ] **Workshop Session 2: Future State (2 hours)**
  - [ ] Desired future state envisioned
  - [ ] Business objectives clarified
  - [ ] Success criteria discussed
  - [ ] User personas created
  - [ ] Key scenarios identified
  - [ ] Integration points identified
  - [ ] Non-functional requirements gathered (performance, security, compliance)

**Outputs:**
- [ ] Current state process maps
- [ ] Pain points list (prioritized)
- [ ] Business objectives documented
- [ ] User personas
- [ ] Initial requirements list

---

### 1.3 Use Case Definition

- [ ] **Use Case Identification**
  - [ ] All potential AI use cases listed
  - [ ] Each use case described (problem, proposed solution, benefit)
  - [ ] Business value assessed for each
  - [ ] Technical feasibility estimated for each
  - [ ] Implementation complexity assessed
  - [ ] Dependencies identified

- [ ] **Use Case Prioritization**
  - [ ] Prioritization criteria defined (value, feasibility, effort, risk)
  - [ ] Use cases scored against criteria
  - [ ] Priority order established
  - [ ] MVP use cases selected (typically 2-3)
  - [ ] Future phase use cases parked

- [ ] **Detailed Use Case Specifications (for MVP)**
  - [ ] Use case name and ID
  - [ ] Business problem description
  - [ ] Current process description
  - [ ] Proposed AI solution
  - [ ] Expected outcomes and benefits
  - [ ] Success metrics
  - [ ] User stories written (As a [user], I want [action] so that [benefit])
  - [ ] Acceptance criteria defined
  - [ ] Data requirements identified
  - [ ] Integration requirements specified
  - [ ] Constraints and assumptions documented

**Outputs:**
- [ ] Use case inventory
- [ ] Prioritization matrix
- [ ] Detailed use case specifications (MVP)
- [ ] User stories with acceptance criteria

---

### 1.4 Requirements Documentation

- [ ] **Functional Requirements**
  - [ ] Core features listed
  - [ ] User interactions specified
  - [ ] System behaviors defined
  - [ ] Business rules documented
  - [ ] Workflow sequences captured
  - [ ] Integration requirements detailed

- [ ] **Non-Functional Requirements**
  - [ ] Performance requirements (response time, throughput)
  - [ ] Scalability requirements (users, data volume, transactions)
  - [ ] Availability requirements (uptime %)
  - [ ] Security requirements (authentication, authorization, encryption)
  - [ ] Compliance requirements (GDPR, HIPAA, industry standards)
  - [ ] Usability requirements
  - [ ] Accessibility requirements
  - [ ] Maintainability requirements
  - [ ] Disaster recovery requirements

- [ ] **Data Requirements**
  - [ ] Input data requirements
  - [ ] Output data requirements
  - [ ] Data formats and schemas
  - [ ] Data volume estimates
  - [ ] Data freshness requirements
  - [ ] Data retention requirements
  - [ ] Data quality requirements

- [ ] **Requirements Review**
  - [ ] Business Owner review completed
  - [ ] Technical team review completed
  - [ ] Compliance/Legal review completed
  - [ ] Feedback incorporated
  - [ ] Requirements signed off

**Outputs:**
- [ ] Business Requirements Document (BRD)
- [ ] Requirements sign-off

---

## WEEK 2: DATA DISCOVERY & ASSESSMENT

### 2.1 Data Source Identification

- [ ] **Data Inventory**
  - [ ] All potential data sources identified
  - [ ] Data source owners identified
  - [ ] Data locations documented (databases, files, APIs, cloud)
  - [ ] Data formats noted (structured, semi-structured, unstructured)
  - [ ] Data access methods documented
  - [ ] Refresh frequency understood

- [ ] **Data Access Requests**
  - [ ] Data access requests submitted
  - [ ] Data sharing agreements reviewed
  - [ ] NDA requirements checked
  - [ ] Access permissions requested
  - [ ] Sample data requested (anonymized if needed)
  - [ ] Data dictionary requested

**Outputs:**
- [ ] Data source inventory
- [ ] Data access status tracker

---

### 2.2 Data Access & Exploration

- [ ] **Data Access Obtained**
  - [ ] Read access to production data (or copies)
  - [ ] Sample datasets received
  - [ ] Data dictionaries/schemas obtained
  - [ ] Data access credentials configured
  - [ ] Data exploration environment set up

- [ ] **Initial Data Exploration**
  - [ ] Data loaded into exploration environment
  - [ ] Column/field names reviewed
  - [ ] Data types verified
  - [ ] Sample records examined
  - [ ] Data relationships understood
  - [ ] Data lineage documented (where data comes from)
  - [ ] Business logic in data identified

**Outputs:**
- [ ] Data access confirmed
- [ ] Initial data exploration notes

---

### 2.3 Data Quality Assessment

- [ ] **Completeness Analysis**
  - [ ] Missing value analysis per column
  - [ ] Null/empty value counts
  - [ ] Required vs optional fields identified
  - [ ] Data coverage by time period
  - [ ] Data completeness score calculated
  - [ ] Completeness issues documented

- [ ] **Accuracy Analysis**
  - [ ] Data validation rules tested
  - [ ] Range checks performed (min/max, expected ranges)
  - [ ] Format validation (dates, emails, phone numbers)
  - [ ] Cross-field consistency checks
  - [ ] Duplicate records identified
  - [ ] Data accuracy score calculated
  - [ ] Accuracy issues documented

- [ ] **Consistency Analysis**
  - [ ] Data format consistency checked
  - [ ] Naming convention consistency
  - [ ] Code/category consistency
  - [ ] Cross-system consistency (if multiple sources)
  - [ ] Historical consistency
  - [ ] Consistency issues documented

- [ ] **Timeliness Analysis**
  - [ ] Data freshness assessed
  - [ ] Update frequency verified
  - [ ] Lag/latency measured
  - [ ] Historical data availability checked
  - [ ] Timeliness issues documented

- [ ] **Validity Analysis**
  - [ ] Data conforms to business rules
  - [ ] Referential integrity checked
  - [ ] Lookup values validated
  - [ ] Data type appropriateness
  - [ ] Validity issues documented

- [ ] **Uniqueness Analysis**
  - [ ] Duplicate detection
  - [ ] Primary key validation
  - [ ] Uniqueness violations identified
  - [ ] Uniqueness issues documented

**Outputs:**
- [ ] Data quality assessment report
- [ ] Data quality scores by dimension
- [ ] Data quality issues log
- [ ] Data quality improvement recommendations

---

### 2.4 Data Volume & Distribution Analysis

- [ ] **Volume Analysis**
  - [ ] Total record counts
  - [ ] Growth trends analyzed
  - [ ] Data volume by category/class
  - [ ] Historical data availability (years/months)
  - [ ] Projected future volumes

- [ ] **Distribution Analysis**
  - [ ] Feature distributions plotted
  - [ ] Class balance analyzed (for classification)
  - [ ] Outlier detection
  - [ ] Skewness identified
  - [ ] Statistical summaries created (mean, median, std dev)

- [ ] **Sufficiency Assessment**
  - [ ] Minimum data requirements for ML defined
  - [ ] Current data compared to minimum
  - [ ] Data gaps identified
  - [ ] Sufficiency by use case assessed
  - [ ] Data augmentation needs identified

**Outputs:**
- [ ] Data volume report
- [ ] Distribution analysis charts
- [ ] Data sufficiency assessment

---

### 2.5 Data Privacy & Compliance Assessment

- [ ] **Data Classification**
  - [ ] Personal data (PII) identified
  - [ ] Sensitive data identified
  - [ ] Confidential data identified
  - [ ] Public data identified
  - [ ] Data classification labels applied

- [ ] **Privacy Requirements**
  - [ ] GDPR applicability assessed (if EU data)
  - [ ] CCPA applicability assessed (if CA data)
  - [ ] Industry-specific regulations identified (HIPAA, FERPA, etc.)
  - [ ] Data residency requirements identified
  - [ ] Consent requirements understood
  - [ ] Right to deletion requirements

- [ ] **Privacy Impact Assessment**
  - [ ] DPIA (Data Privacy Impact Assessment) initiated
  - [ ] Privacy risks identified
  - [ ] Privacy controls designed
  - [ ] Anonymization/pseudonymization needs determined
  - [ ] Data masking requirements identified

- [ ] **Compliance Review**
  - [ ] Legal/Compliance team consulted
  - [ ] Regulatory requirements documented
  - [ ] Compliance gaps identified
  - [ ] Remediation plans created
  - [ ] Compliance sign-off obtained (or conditions noted)

**Outputs:**
- [ ] Data classification register
- [ ] Privacy Impact Assessment
- [ ] Compliance requirements document
- [ ] Privacy/compliance sign-off

---

## WEEK 3: AI/ML APPROACH DESIGN

### 3.1 Problem Framing

- [ ] **ML Problem Type Identification**
  - [ ] Problem framed as ML problem type:
    - [ ] Classification (binary, multi-class, multi-label)
    - [ ] Regression
    - [ ] Clustering
    - [ ] Forecasting/Time Series
    - [ ] Anomaly Detection
    - [ ] NLP (sentiment, NER, summarization, etc.)
    - [ ] Computer Vision (object detection, classification, etc.)
    - [ ] Recommendation
    - [ ] Reinforcement Learning
  - [ ] Problem complexity assessed
  - [ ] Success metrics defined (accuracy, precision, recall, F1, RMSE, etc.)

- [ ] **Input/Output Definition**
  - [ ] Model inputs (features) identified
  - [ ] Model outputs (predictions) defined
  - [ ] Feature engineering opportunities identified
  - [ ] Output format specified

- [ ] **Baseline Definition**
  - [ ] Current baseline approach documented (rules-based, manual, etc.)
  - [ ] Baseline performance measured
  - [ ] Minimum acceptable improvement over baseline defined

**Outputs:**
- [ ] ML problem definition document
- [ ] Baseline performance metrics

---

### 3.2 ML Approach Selection

- [ ] **Algorithm Candidates Identified**
  - [ ] Traditional ML algorithms considered:
    - [ ] Decision Trees / Random Forests
    - [ ] Gradient Boosting (XGBoost, LightGBM)
    - [ ] Linear/Logistic Regression
    - [ ] SVM
    - [ ] K-Nearest Neighbors
  - [ ] Deep Learning approaches considered:
    - [ ] Neural Networks
    - [ ] CNNs (for images)
    - [ ] RNNs/LSTMs (for sequences)
    - [ ] Transformers (for NLP)
  - [ ] Pre-trained models / Transfer Learning:
    - [ ] Azure Cognitive Services
    - [ ] Azure OpenAI
    - [ ] Hugging Face models
    - [ ] Custom pre-trained models

- [ ] **Approach Comparison**
  - [ ] Each approach evaluated on:
    - Accuracy potential
    - Training data requirements
    - Training time/cost
    - Inference speed
    - Interpretability
    - Complexity
  - [ ] Trade-offs documented
  - [ ] Recommendation made

- [ ] **Azure Services Selection**
  - [ ] Azure services identified:
    - [ ] Azure Machine Learning
    - [ ] Azure Cognitive Services
    - [ ] Azure OpenAI Service
    - [ ] Azure Databricks
    - [ ] Custom approach
  - [ ] Service pros/cons assessed
  - [ ] Cost estimates for each
  - [ ] Recommendation made

**Outputs:**
- [ ] Algorithm evaluation matrix
- [ ] Recommended ML approach
- [ ] Azure services selection

---

### 3.3 Feature Engineering Strategy

- [ ] **Feature Identification**
  - [ ] Raw features from data sources listed
  - [ ] Derived features identified
  - [ ] Engineered features planned:
    - [ ] Aggregations (sum, avg, count, etc.)
    - [ ] Ratios and proportions
    - [ ] Date/time features (day of week, hour, season)
    - [ ] Text features (length, word count, TF-IDF)
    - [ ] Categorical encodings (one-hot, label, target)
    - [ ] Interaction features
    - [ ] Domain-specific features

- [ ] **Feature Selection Plan**
  - [ ] Feature importance analysis planned
  - [ ] Dimensionality reduction considered (PCA, etc.)
  - [ ] Feature selection criteria defined

- [ ] **Feature Store Strategy**
  - [ ] Need for feature store assessed
  - [ ] Feature store approach defined (if needed)
  - [ ] Feature versioning strategy

**Outputs:**
- [ ] Feature engineering plan
- [ ] Feature list (raw + engineered)

---

### 3.4 Model Training Strategy

- [ ] **Training Approach**
  - [ ] Training/validation/test split strategy (e.g., 70/15/15)
  - [ ] Cross-validation strategy (k-fold, time-based)
  - [ ] Hyperparameter tuning approach
  - [ ] Model ensembling strategy (if applicable)

- [ ] **Training Infrastructure**
  - [ ] Compute requirements estimated
  - [ ] Azure ML compute clusters sized
  - [ ] Training time estimated
  - [ ] Training cost estimated

- [ ] **Experiment Tracking**
  - [ ] Experiment tracking approach defined (Azure ML, MLflow)
  - [ ] Metrics to track identified
  - [ ] Model versioning strategy

**Outputs:**
- [ ] Model training plan
- [ ] Compute requirements document

---

### 3.5 Model Evaluation Strategy

- [ ] **Evaluation Metrics**
  - [ ] Primary metric defined
  - [ ] Secondary metrics defined
  - [ ] Business metrics mapped to technical metrics
  - [ ] Minimum acceptable thresholds set

- [ ] **Evaluation Approach**
  - [ ] Hold-out test set approach
  - [ ] Cross-validation approach
  - [ ] Temporal validation (for time series)
  - [ ] A/B testing strategy (for production)

- [ ] **Fairness & Bias Assessment**
  - [ ] Protected attributes identified
  - [ ] Fairness metrics defined
  - [ ] Bias detection approach planned
  - [ ] Mitigation strategies identified

- [ ] **Interpretability Requirements**
  - [ ] Interpretability needs assessed
  - [ ] Explainability techniques identified (SHAP, LIME, etc.)
  - [ ] Model transparency requirements

**Outputs:**
- [ ] Model evaluation plan
- [ ] Success criteria document

---

## WEEK 3-4: SOLUTION ARCHITECTURE

### 4.1 High-Level Architecture Design

- [ ] **Architecture Components**
  - [ ] Data ingestion layer designed
  - [ ] Data processing/transformation layer
  - [ ] Feature engineering layer
  - [ ] Model training layer
  - [ ] Model serving/inference layer
  - [ ] Application layer
  - [ ] Integration layer
  - [ ] Monitoring layer

- [ ] **Azure Services Mapping**
  - [ ] Each component mapped to Azure services
  - [ ] Service tiers selected
  - [ ] Redundancy/HA approach defined
  - [ ] Disaster recovery approach

- [ ] **Architecture Diagram**
  - [ ] High-level architecture diagram created
  - [ ] Data flow diagram created
  - [ ] Component relationships shown
  - [ ] External systems shown

**Outputs:**
- [ ] Solution architecture document
- [ ] Architecture diagrams

---

### 4.2 Data Architecture

- [ ] **Data Pipeline Design**
  - [ ] Data sources and ingestion methods
  - [ ] Data transformation logic
  - [ ] Data validation rules
  - [ ] Data quality checks
  - [ ] Error handling approach
  - [ ] Data pipeline orchestration (Azure Data Factory, Synapse)

- [ ] **Data Storage Design**
  - [ ] Raw data storage (Data Lake)
  - [ ] Processed data storage
  - [ ] Feature store (if applicable)
  - [ ] Model artifacts storage
  - [ ] Metadata storage
  - [ ] Data retention policies
  - [ ] Data archival strategy

- [ ] **Data Governance**
  - [ ] Data lineage tracking
  - [ ] Data cataloging (Azure Purview)
  - [ ] Data access controls
  - [ ] Data encryption (at rest, in transit)
  - [ ] Data masking/anonymization

**Outputs:**
- [ ] Data architecture document
- [ ] Data pipeline design
- [ ] Data governance plan

---

### 4.3 ML Architecture

- [ ] **Training Architecture**
  - [ ] Training pipeline design
  - [ ] Experiment tracking setup
  - [ ] Hyperparameter tuning approach
  - [ ] Distributed training (if needed)
  - [ ] Model registration process

- [ ] **Serving Architecture**
  - [ ] Inference approach (real-time, batch, streaming)
  - [ ] Model deployment approach (AKS, ACI, Azure Functions)
  - [ ] Scaling strategy
  - [ ] Model versioning strategy
  - [ ] A/B testing setup (if needed)
  - [ ] Model rollback strategy

- [ ] **MLOps Architecture**
  - [ ] CI/CD pipeline design
  - [ ] Automated testing strategy
  - [ ] Model retraining triggers
  - [ ] Model monitoring approach
  - [ ] Alert configuration

**Outputs:**
- [ ] ML architecture document
- [ ] MLOps design

---

### 4.4 Application & Integration Architecture

- [ ] **Application Architecture**
  - [ ] User interface design approach
  - [ ] Backend services design
  - [ ] API design
  - [ ] Authentication/authorization approach
  - [ ] Session management

- [ ] **Integration Architecture**
  - [ ] Integration patterns defined (REST API, messaging, events)
  - [ ] External system integrations designed
  - [ ] API specifications
  - [ ] Data synchronization approach
  - [ ] Error handling and retries

- [ ] **Deployment Architecture**
  - [ ] Environment strategy (dev, test, prod)
  - [ ] Infrastructure as Code approach
  - [ ] Deployment automation
  - [ ] Blue-green or canary deployment

**Outputs:**
- [ ] Application architecture document
- [ ] Integration specifications
- [ ] API documentation

---

### 4.5 Security Architecture

- [ ] **Security Requirements**
  - [ ] Authentication requirements (Azure AD, OAuth)
  - [ ] Authorization requirements (RBAC)
  - [ ] Encryption requirements
  - [ ] Network security requirements
  - [ ] API security requirements

- [ ] **Security Controls**
  - [ ] Identity and access management design
  - [ ] Network security design (NSGs, firewalls)
  - [ ] Encryption design (at rest, in transit)
  - [ ] Key management (Azure Key Vault)
  - [ ] Threat protection (Defender for Cloud)
  - [ ] Security monitoring and logging

- [ ] **Compliance Controls**
  - [ ] Compliance requirements mapped to controls
  - [ ] Audit logging design
  - [ ] Compliance reporting approach

**Outputs:**
- [ ] Security architecture document
- [ ] Security controls matrix

---

### 4.6 Monitoring & Observability

- [ ] **Monitoring Strategy**
  - [ ] Application monitoring (Application Insights)
  - [ ] Infrastructure monitoring (Azure Monitor)
  - [ ] Model performance monitoring
  - [ ] Data quality monitoring
  - [ ] Business metrics monitoring

- [ ] **Alerting Strategy**
  - [ ] Alert definitions
  - [ ] Alert thresholds
  - [ ] Alert routing
  - [ ] Escalation procedures

- [ ] **Logging Strategy**
  - [ ] Log aggregation (Log Analytics)
  - [ ] Log retention policies
  - [ ] Log analysis approach

- [ ] **Dashboards**
  - [ ] Dashboard requirements
  - [ ] Dashboard design (Power BI, Azure Dashboard)
  - [ ] Dashboard audiences

**Outputs:**
- [ ] Monitoring and observability plan
- [ ] Alert definitions
- [ ] Dashboard designs

---

## WEEK 4: VALIDATION & PLANNING

### 5.1 Technical Feasibility Validation

- [ ] **Proof of Concept (Optional but Recommended)**
  - [ ] POC objectives defined
  - [ ] Sample data prepared
  - [ ] Quick model built
  - [ ] Baseline performance achieved
  - [ ] Technical risks validated/mitigated
  - [ ] POC results documented

- [ ] **Feasibility Assessment**
  - [ ] Data sufficiency confirmed
  - [ ] Model accuracy achievable
  - [ ] Performance requirements achievable
  - [ ] Integration complexity manageable
  - [ ] Cost reasonable
  - [ ] Timeline realistic

- [ ] **Risk Assessment**
  - [ ] Technical risks updated
  - [ ] Data risks updated
  - [ ] Mitigation plans updated
  - [ ] No blocking risks

**Outputs:**
- [ ] POC results (if conducted)
- [ ] Feasibility assessment report
- [ ] Updated risk register

---

### 5.2 Solution Design Review

- [ ] **Internal Review**
  - [ ] Technical team review
  - [ ] Architecture review
  - [ ] Security review
  - [ ] Data team review
  - [ ] Feedback incorporated

- [ ] **Stakeholder Review**
  - [ ] Business Owner review
  - [ ] Executive Sponsor briefing
  - [ ] CIO/CTO review
  - [ ] Compliance/Legal review
  - [ ] Feedback incorporated

- [ ] **Design Sign-off**
  - [ ] Business requirements approved
  - [ ] Solution architecture approved
  - [ ] Data architecture approved
  - [ ] Security architecture approved
  - [ ] ML approach approved

**Outputs:**
- [ ] Review feedback log
- [ ] Updated architecture documents
- [ ] Design sign-offs

---

### 5.3 Prototype Phase Planning

- [ ] **Prototype Scope Definition**
  - [ ] MVP features identified
  - [ ] Out of scope clarified
  - [ ] Prototype success criteria defined
  - [ ] Demo scenarios planned

- [ ] **Prototype Sprint Planning**
  - [ ] Number of sprints determined (typically 3-4)
  - [ ] Sprint goals defined
  - [ ] Sprint backlog created
  - [ ] Story pointing completed
  - [ ] Team velocity estimated

- [ ] **Resource Planning**
  - [ ] Team members confirmed
  - [ ] Allocation percentages confirmed
  - [ ] Any skill gaps identified
  - [ ] Training needs identified

- [ ] **Environment Planning**
  - [ ] Prototype environment requirements
  - [ ] Azure resource provisioning plan
  - [ ] Tool setup requirements

**Outputs:**
- [ ] Prototype scope document
- [ ] Sprint plan
- [ ] Resource plan
- [ ] Environment plan

---

### 5.4 Discovery Documentation

- [ ] **Discovery Report**
  - [ ] Executive summary
  - [ ] Business requirements summary
  - [ ] Use cases documented
  - [ ] Data assessment summary
  - [ ] Solution architecture summary
  - [ ] ML approach summary
  - [ ] Feasibility conclusion
  - [ ] Risks and mitigation
  - [ ] Recommendation (proceed/adjust/stop)

- [ ] **Supporting Documentation**
  - [ ] Business Requirements Document
  - [ ] Data Assessment Report
  - [ ] Solution Architecture Document
  - [ ] ML Approach Document
  - [ ] Risk Register (updated)
  - [ ] Prototype Plan

- [ ] **Artifacts**
  - [ ] Architecture diagrams
  - [ ] Data flow diagrams
  - [ ] ER diagrams
  - [ ] Wireframes/mockups (if created)
  - [ ] POC code/models (if created)

**Outputs:**
- [ ] Discovery Report
- [ ] All supporting documents
- [ ] All artifacts

---

## DISCOVERY PHASE GATE REVIEW

### 6.1 Phase Gate Preparation

- [ ] **Readiness Assessment**
  - [ ] All deliverables complete
  - [ ] All reviews and sign-offs obtained
  - [ ] No blocking issues
  - [ ] Team ready for prototype

- [ ] **Phase Gate Presentation**
  - [ ] Executive summary slide
  - [ ] Business requirements summary
  - [ ] Data assessment results
  - [ ] Solution architecture overview
  - [ ] ML approach
  - [ ] Feasibility conclusion
  - [ ] Risks and mitigation
  - [ ] Prototype plan
  - [ ] Budget and timeline
  - [ ] Go/No-Go recommendation

- [ ] **Phase Gate Meeting Scheduled**
  - [ ] Date: ___________
  - [ ] Attendees confirmed (Steering Committee)
  - [ ] Materials distributed in advance

---

### 6.2 Exit Criteria Assessment

**Mandatory Criteria:**

- [ ] **Business requirements documented and approved**
  - Clear use cases defined
  - User stories with acceptance criteria
  - Business Owner sign-off

- [ ] **Data assessment complete**
  - Data sources identified and accessed
  - Data quality assessed (>80% completeness, <5% error rate)
  - Data volume sufficient for ML
  - Data privacy/compliance approved

- [ ] **AI/ML approach defined**
  - ML problem type identified
  - Algorithm approach selected
  - Feature engineering strategy defined
  - Success metrics defined

- [ ] **Solution architecture approved**
  - High-level architecture designed
  - Azure services selected
  - Integration approach defined
  - Security architecture approved
  - CIO/CTO sign-off

- [ ] **Technical feasibility confirmed**
  - Data sufficiency validated
  - Model performance achievable
  - Integration complexity understood
  - No blocking technical risks

- [ ] **Prototype plan created**
  - Scope defined
  - Sprint plan ready
  - Resources confirmed
  - Environment plan ready

- [ ] **Risks assessed and manageable**
  - All significant risks identified
  - Mitigation plans in place
  - No critical unmitigated risks

- [ ] **Stakeholder alignment**
  - Business Owner aligned
  - Executive Sponsor supportive
  - Technical team confident

---

### 6.3 Go/No-Go Decision

**Decision Options:**

**GO:**
- All mandatory criteria met
- Feasibility confirmed
- Team ready
- Proceed to Prototype phase

**CONDITIONAL GO:**
- Most criteria met
- Some concerns to address
- Specific conditions to meet
- May proceed with adjustments

**NO-GO:**
- Critical criteria not met
- Feasibility concerns
- Data not available/insufficient
- Better to stop or pivot

**Decision Documented:**
- [ ] Decision: GO / CONDITIONAL GO / NO-GO
- [ ] Conditions (if any): ___________
- [ ] Decision maker: ___________
- [ ] Date: ___________
- [ ] Communicated to stakeholders

---

## MILESTONE: M2 - DISCOVERY COMPLETE ✓

**Achievement Date:** ___________

**Sign-off:**
- Project Manager: ___________ Date: ___________
- Business Analyst: ___________ Date: ___________
- AI/ML Lead: ___________ Date: ___________
- Business Owner: ___________ Date: ___________
- Executive Sponsor: ___________ Date: ___________

---

## Transition to Prototype

- [ ] **Prototype Kickoff Scheduled**
  - Date: ___________
  - Team confirmed

- [ ] **Prototype Sprint 1 Planned**
  - Sprint goal defined
  - Backlog prioritized
  - Team ready

- [ ] **Discovery Lessons Learned**
  - Retrospective held: ___________
  - Lessons documented
  - Process improvements identified

- [ ] **Discovery Phase Closed**
  - Final status report issued
  - Deliverables archived
  - Knowledge transferred
  - Success celebrated! 🎉

---

## Issues & Blockers Log

| # | Issue | Impact | Owner | Status | Resolution Date |
|---|-------|--------|-------|--------|----------------|
| 1 | | | | Open/Resolved | |
| 2 | | | | Open/Resolved | |

---

## Notes & Key Decisions

[Space for additional notes, decisions, or context]

---

**Document Control**
- **Version**: 1.0
- **Last Updated**: [Date]
- **Owner**: [Business Analyst / Project Manager]
- **Next Review**: Weekly during discovery phase

---

## Appendix: Key Contacts

| Role | Name | Email | Phone |
|------|------|-------|-------|
| Business Owner | | | |
| Business Analyst | | | |
| AI/ML Lead | | | |
| Data Engineer | | | |
| Solution Architect | | | |

---

**Ready to proceed to Prototype Phase!** 🚀
