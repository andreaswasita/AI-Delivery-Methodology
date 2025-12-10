# RACI Matrix - AI Project

## Document Information

| Field | Details |
|-------|---------|
| **Project Name** | [Enter AI Project Name] |
| **Version** | 1.0 |
| **Date** | [DD/MM/YYYY] |
| **Owner** | [Project Manager Name] |

---

## RACI Legend

- **R - Responsible**: Person(s) who perform the work to complete the task
- **A - Accountable**: Person who is ultimately answerable for the activity (only ONE per activity)
- **C - Consulted**: People whose opinions are sought (two-way communication)
- **I - Informed**: People who are kept up-to-date on progress (one-way communication)

---

## Stakeholder Roles

| Abbreviation | Role | Name |
|--------------|------|------|
| **ES** | Executive Sponsor | [Name] |
| **PM** | Project Manager | [Name] |
| **BA** | Business Analyst | [Name] |
| **BO** | Business Owner | [Name] |
| **AI** | AI/ML Lead | [Name] |
| **DS** | Data Scientist | [Name] |
| **SA** | Solution Architect | [Name] |
| **DE** | Data Engineer | [Name] |
| **DA** | DevOps/MLOps Engineer | [Name] |
| **SE** | Software Engineer | [Name] |
| **QA** | QA/Test Lead | [Name] |
| **SM** | Security Manager | [Name] |
| **CM** | Change Manager | [Name] |
| **UXD** | UX Designer | [Name] |
| **TO** | Technical Operations | [Name] |

---

## RACI Matrix by Phase

### 1. MOBILISATION & INITIATION

| Activity | ES | PM | BA | BO | AI | DS | SA | DE | DA | SE | QA | SM | CM | UXD | TO |
|----------|----|----|----|----|----|----|----|----|----|----|----|----|----|----|-----|
| **Project Charter Development** | A | R | C | C | C | | C | | | | | C | C | | |
| **Business Case Creation** | A | R | R | R | C | | C | | | | | | C | | |
| **Budget Approval** | A | C | | R | | | | | | | | | | | |
| **Team Mobilisation** | C | A/R | | C | R | R | R | C | C | C | C | C | R | C | C |
| **Kickoff Meeting** | A | R | I | R | I | I | I | I | I | I | I | I | I | I | I |
| **Governance Setup** | A | R | | R | C | | C | | | | | C | C | | |
| **Risk Register Creation** | C | A/R | C | C | R | C | R | C | C | C | C | R | C | | C |
| **Communication Plan** | C | A/R | | C | C | | | | | | | | R | | |
| **Stakeholder Analysis** | C | A/R | R | R | C | | | | | | | | R | | |

### 2. DISCOVERY & REQUIREMENTS

| Activity | ES | PM | BA | BO | AI | DS | SA | DE | DA | SE | QA | SM | CM | UXD | TO |
|----------|----|----|----|----|----|----|----|----|----|----|----|----|----|----|-----|
| **Business Requirements** | C | A | R | R | C | C | C | | | | C | | C | C | |
| **Use Case Definition** | C | C | R | R | R | R | C | | | | C | | C | R | |
| **Data Assessment** | C | C | C | R | R | A/R | C | R | | | | C | | | C |
| **Data Quality Analysis** | | C | C | R | C | R | | A/R | | | | C | | | C |
| **Technical Feasibility** | | C | | C | A/R | R | R | C | C | | | C | | | C |
| **AI/ML Approach Design** | | C | | C | A/R | R | C | | | | | | | | |
| **Architecture Design** | | C | C | C | R | C | A/R | C | R | C | | R | | C | R |
| **Success Criteria Definition** | C | A | R | R | R | C | C | | | | R | | C | C | |
| **Data Privacy Assessment** | C | C | | R | C | | C | C | | | | A/R | | | |
| **Regulatory Compliance** | A | C | | R | C | | C | | | | | R | | | |

### 3. PLATFORM SETUP

| Activity | ES | PM | BA | BO | AI | DS | SA | DE | DA | SE | QA | SM | CM | UXD | TO |
|----------|----|----|----|----|----|----|----|----|----|----|----|----|----|----|-----|
| **Azure Environment Setup** | | C | | | C | | R | R | A/R | | | R | | | R |
| **DevOps Pipeline Setup** | | C | | | C | | C | C | A/R | R | | C | | | C |
| **Security Configuration** | C | C | | | C | | C | C | R | | | A/R | | | C |
| **Access Control Setup** | | C | | C | C | | C | C | R | | | A/R | | | C |
| **Data Platform Setup** | | C | | C | C | | R | A/R | C | | | C | | | R |
| **ML Workspace Setup** | | C | | | R | R | C | C | A | | | C | | | |
| **Version Control Setup** | | C | | | R | R | C | C | A/R | R | | | | | |
| **Monitoring Setup** | | C | | | C | | C | C | A/R | C | | C | | | R |

### 4. PROTOTYPE & BUILD

| Activity | ES | PM | BA | BO | AI | DS | SA | DE | DA | SE | QA | SM | CM | UXD | TO |
|----------|----|----|----|----|----|----|----|----|----|----|----|----|----|----|-----|
| **Data Collection** | | C | C | C | C | C | C | A/R | | | | C | | | C |
| **Data Preparation** | | C | | C | C | R | | A/R | | | | C | | | |
| **Feature Engineering** | | C | | C | R | A/R | | C | | | | | | | |
| **Model Development** | | C | | C | A/R | R | | | | | | | | | |
| **Model Training** | | C | | C | R | A/R | | C | C | | | | | | |
| **Model Evaluation** | | C | C | R | A/R | R | | | | | R | | | | |
| **UI/UX Design** | | C | R | R | C | | C | | | C | | | C | A/R | |
| **Application Development** | | C | C | C | C | | R | C | C | A/R | C | | | R | |
| **Integration Development** | | C | C | C | C | | R | C | C | A/R | | C | | | C |
| **API Development** | | C | | C | C | | R | | C | A/R | C | C | | | |

### 5. TEST & EVALUATE

| Activity | ES | PM | BA | BO | AI | DS | SA | DE | DA | SE | QA | SM | CM | UXD | TO |
|----------|----|----|----|----|----|----|----|----|----|----|----|----|----|----|-----|
| **Test Strategy** | | A | C | C | C | C | C | | C | C | R | C | | C | |
| **Test Case Development** | | C | R | R | C | C | C | | | C | A/R | | | C | |
| **Unit Testing** | | C | | | R | R | | | | R | A | | | | |
| **Integration Testing** | | C | | C | R | C | C | C | C | R | A/R | C | | | C |
| **Model Performance Testing** | | C | | R | A/R | R | | | | | R | | | | |
| **UAT Planning** | | A/R | R | R | C | | | | | | C | | R | C | |
| **UAT Execution** | | C | R | A/R | C | C | | | | | R | | C | C | |
| **Security Testing** | | C | | | C | | C | | C | | C | A/R | | | C |
| **Performance Testing** | | C | | C | C | | R | | R | R | A/R | | | | R |
| **Bug Fixing** | | C | C | C | R | R | | | | A/R | C | | | C | |

### 6. DEPLOYMENT & SCALE

| Activity | ES | PM | BA | BO | AI | DS | SA | DE | DA | SE | QA | SM | CM | UXD | TO |
|----------|----|----|----|----|----|----|----|----|----|----|----|----|----|----|-----|
| **Deployment Planning** | C | A/R | | C | R | | R | C | R | C | C | C | C | | R |
| **Infrastructure Provisioning** | | C | | | C | | R | C | A/R | | | C | | | R |
| **Production Deployment** | | C | | C | C | | R | C | A/R | R | | C | C | | R |
| **Smoke Testing** | | C | | C | R | R | | | C | C | A/R | | | | R |
| **Go-Live Approval** | A | C | | R | C | | C | | C | | R | C | C | | C |
| **Production Monitoring** | | C | | C | C | | C | | A/R | C | | | | | R |
| **Training Delivery** | | C | C | R | C | | | | | | | | A/R | | |
| **Documentation** | | A | R | C | R | R | R | C | C | R | C | | R | C | C |
| **Handover to Operations** | | A/R | | C | C | | C | | R | | | | C | | R |

### 7. OPERATE & CARE

| Activity | ES | PM | BA | BO | AI | DS | SA | DE | DA | SE | QA | SM | CM | UXD | TO |
|----------|----|----|----|----|----|----|----|----|----|----|----|----|----|----|-----|
| **Production Support** | | I | | C | C | C | C | | C | C | | | | | A/R |
| **Incident Management** | | I | | I | C | C | C | | R | C | | C | | | A/R |
| **Model Monitoring** | | I | | C | R | A/R | | | C | | | | | | R |
| **Model Retraining** | | C | | C | A/R | R | | C | C | | | | | | C |
| **Performance Optimization** | | C | | C | A/R | R | C | C | R | R | | | | | C |
| **Enhancement Requests** | | C | R | A/R | C | C | C | | | | | | C | C | |
| **Benefits Realization** | C | A/R | R | R | C | | | | | | | | C | | |
| **Continuous Improvement** | | A | C | R | R | R | C | | C | | | | C | | C |

---

## Governance & Decision Making

| Decision Type | ES | PM | BA | BO | AI | DS | SA | DE | DA | SE | QA | SM | CM | UXD | TO |
|---------------|----|----|----|----|----|----|----|----|----|----|----|----|----|----|-----|
| **Budget Changes** | A | R | | C | | | | | | | | | | | |
| **Scope Changes** | A | R | C | R | C | | C | | | | | | C | | |
| **Timeline Changes** | A | R | | R | C | | | | | | | | | | |
| **Technical Decisions** | I | C | | C | A | R | R | C | C | C | | C | | | C |
| **Architecture Decisions** | I | C | | C | R | C | A | C | C | C | | R | | | C |
| **Go/No-Go Decisions** | A | R | | R | C | | C | | C | | R | C | C | | C |

---

## Communication Matrix

| Communication | ES | PM | BA | BO | AI | DS | SA | DE | DA | SE | QA | SM | CM | UXD | TO |
|---------------|----|----|----|----|----|----|----|----|----|----|----|----|----|----|-----|
| **Steering Committee** | A | R | | R | I | | I | | | | | | I | | |
| **Weekly Status** | I | A/R | C | I | R | R | C | C | C | C | C | C | C | C | C |
| **Sprint Reviews** | I | R | I | I | A | R | R | R | R | R | R | | | R | |
| **Risk Reviews** | C | A/R | C | C | R | | R | | | | | R | | | |
| **Change Requests** | C | A | C | R | C | | C | | | | | | R | | |

---

## Notes

1. **One Accountable per Activity**: Each activity should have only ONE person accountable (A)
2. **Escalation**: If the Accountable person cannot resolve an issue, they escalate to the Executive Sponsor
3. **Updates**: This RACI matrix should be reviewed and updated at each project phase
4. **Conflicts**: Any conflicts in responsibilities should be escalated to the Project Manager
5. **Resource Changes**: If team members change, update this matrix immediately

---

## Approval

| Name | Role | Signature | Date |
|------|------|-----------|------|
| [Name] | Executive Sponsor | | |
| [Name] | Project Manager | | |
| [Name] | Business Owner | | |

---

**Document Control**
- **Version**: 1.0
- **Last Updated**: [Date]
- **Next Review**: [Date]
- **Owner**: [Project Manager]
