# Model Card Template
## Transparent ML Model Documentation for Responsible AI

**Model Name**: [Insert Model Name]  
**Model Version**: [e.g., 1.0.0]  
**Last Updated**: [Date]  
**Model Owner**: [Team/Individual]  
**Model Status**: [Development / Staging / Production / Deprecated]

---

## Table of Contents

1. [Model Overview](#model-overview)
2. [Intended Use](#intended-use)
3. [Training Data](#training-data)
4. [Model Architecture](#model-architecture)
5. [Performance Metrics](#performance-metrics)
6. [Fairness & Bias Assessment](#fairness--bias-assessment)
7. [Explainability](#explainability)
8. [Limitations & Risks](#limitations--risks)
9. [Ethical Considerations](#ethical-considerations)
10. [Deployment Details](#deployment-details)
11. [Monitoring & Maintenance](#monitoring--maintenance)
12. [Version History](#version-history)
13. [Approvals & Sign-offs](#approvals--sign-offs)

---

## Model Overview

### Purpose

**Business Problem**:  
[Describe the business problem this model solves]

Example:
> This model predicts customer churn risk to enable proactive retention efforts, reducing customer attrition by 15-20% and saving an estimated $2M annually.

**Model Type**:  
[Classification / Regression / Clustering / Recommendation / NLP / Computer Vision / Other]

**Primary Use Case**:  
[Describe the primary use case]

Example:
> Identify customers with high churn probability (>70%) in the next 90 days, enabling the customer success team to initiate targeted retention campaigns.

---

### Quick Facts

| Attribute | Value |
|-----------|-------|
| **Model Family** | [e.g., Random Forest, Neural Network, Transformer] |
| **Algorithm** | [Specific algorithm used] |
| **Framework** | [e.g., scikit-learn, PyTorch, TensorFlow, Spark MLlib] |
| **Language** | [e.g., Python 3.9] |
| **Input Features** | [Number of features] |
| **Output** | [Description of model output] |
| **Training Time** | [Time to train] |
| **Inference Latency** | [Average prediction time] |
| **Model Size** | [File size in MB/GB] |
| **Deployment Environment** | [Azure ML, AKS, ACI, Edge, etc.] |

---

## Intended Use

### Primary Intended Use

**Who should use this model?**  
[Describe target users]

Example:
> Customer Success Managers, Retention Marketing Team, Sales Operations

**What should it be used for?**  
[Describe intended use cases]

Example:
> - Identifying at-risk customers for proactive outreach
> - Prioritizing retention efforts based on churn risk score
> - Segmenting customers for targeted campaigns

**How should it be used?**  
[Describe how to use the model properly]

Example:
> The model should be run weekly on the active customer base. Customers with churn scores >70% should be escalated to the Customer Success team for personalized outreach within 48 hours.

---

### Out-of-Scope Uses

**This model should NOT be used for:**

- ❌ [List prohibited uses]

Example:
> - Making final decisions on contract renewals without human review
> - Punitive actions against customers (e.g., reducing service levels)
> - Predicting churn for customers outside the trained demographic segments
> - Real-time decision-making (model designed for batch predictions)

**Limitations:**

[Describe specific limitations]

Example:
> - Model trained on B2B SaaS customers only; not validated for B2C or other industries
> - Performance degrades for new products (<6 months in market)
> - Requires minimum 3 months of customer interaction history

---

## Training Data

### Data Sources

| Data Source | Description | Date Range | Records |
|------------|-------------|------------|---------|
| [Source 1] | [Description] | [Start - End] | [N] |
| [Source 2] | [Description] | [Start - End] | [N] |

Example:
| Data Source | Description | Date Range | Records |
|------------|-------------|------------|---------|
| CRM Database | Customer account info, usage metrics | Jan 2023 - Dec 2024 | 45,000 |
| Support Tickets | Customer support interactions | Jan 2023 - Dec 2024 | 120,000 |
| Product Telemetry | Usage patterns, feature adoption | Jan 2023 - Dec 2024 | 2M+ events |

---

### Data Characteristics

**Total Training Samples**: [N]  
**Training Set**: [N samples, X%]  
**Validation Set**: [N samples, X%]  
**Test Set**: [N samples, X%]  

**Data Split Method**: [Random / Temporal / Stratified / Other]

**Class Distribution** (for classification):

| Class | Training | Validation | Test |
|-------|----------|------------|------|
| [Class 1] | [N, %] | [N, %] | [N, %] |
| [Class 2] | [N, %] | [N, %] | [N, %] |

Example:
| Class | Training | Validation | Test |
|-------|----------|------------|------|
| Churned (1) | 3,200 (10%) | 800 (10%) | 1,000 (10%) |
| Retained (0) | 28,800 (90%) | 7,200 (90%) | 9,000 (90%) |

---

### Feature Engineering

**Input Features** ([N] total):

| Feature Name | Type | Description | Importance |
|-------------|------|-------------|------------|
| [Feature 1] | [Numeric/Categorical/Text] | [Description] | [High/Medium/Low] |

Example:
| Feature Name | Type | Description | Importance |
|-------------|------|-------------|------------|
| account_age_months | Numeric | Months since account creation | High |
| monthly_active_users | Numeric | Average MAU over last 3 months | High |
| support_tickets_90d | Numeric | Support tickets in last 90 days | Medium |
| plan_tier | Categorical | Subscription plan (Basic/Pro/Enterprise) | Medium |
| nps_score | Numeric | Most recent NPS score (-100 to 100) | High |

**Feature Transformations**:
- [List any transformations applied]

Example:
- Log transformation on monetary features (contract_value, spending)
- One-hot encoding for categorical features (plan_tier, industry)
- Min-max normalization for numeric features
- Missing value imputation using median for numeric, mode for categorical

---

### Data Quality

**Data Quality Score**: [X/10]

**Quality Checks Performed**:
- [x] Missing value analysis
- [x] Outlier detection and handling
- [x] Duplicate record removal
- [x] Data type validation
- [x] Consistency checks across sources

**Data Issues Identified**:

| Issue | Impact | Resolution |
|-------|--------|------------|
| [Issue] | [High/Medium/Low] | [How resolved] |

Example:
| Issue | Impact | Resolution |
|-------|--------|------------|
| 15% missing NPS scores | Medium | Imputed using account-level median |
| Outliers in usage metrics (>99th percentile) | Low | Capped at 99th percentile |
| 200 duplicate customer records | High | Deduped using customer_id + date |

---

## Model Architecture

### Algorithm Details

**Algorithm**: [Full algorithm name and version]

Example:
> Random Forest Classifier (scikit-learn 1.2.2)

**Hyperparameters**:

```python
{
    'n_estimators': 200,
    'max_depth': 15,
    'min_samples_split': 50,
    'min_samples_leaf': 20,
    'max_features': 'sqrt',
    'bootstrap': True,
    'class_weight': 'balanced',
    'random_state': 42
}
```

**Model Selection Process**:

[Describe how this model was selected]

Example:
> Evaluated 5 algorithms (Logistic Regression, Random Forest, XGBoost, Neural Network, LightGBM) using 5-fold cross-validation. Random Forest selected based on best F1-score (0.82) and explainability requirements.

| Algorithm | Accuracy | Precision | Recall | F1-Score | Training Time |
|-----------|----------|-----------|--------|----------|---------------|
| Logistic Regression | 0.78 | 0.65 | 0.72 | 0.68 | 2 min |
| Random Forest | 0.85 | 0.78 | 0.86 | 0.82 | 15 min |
| XGBoost | 0.86 | 0.80 | 0.84 | 0.82 | 20 min |
| Neural Network | 0.84 | 0.76 | 0.88 | 0.81 | 45 min |
| LightGBM | 0.86 | 0.79 | 0.85 | 0.82 | 12 min |

**Selected**: Random Forest (best F1-score + interpretability)

---

### Training Details

**Training Environment**:
- **Compute**: [Describe compute resources]
- **Training Duration**: [Time to train]
- **Framework Version**: [e.g., scikit-learn 1.2.2, PyTorch 2.0]
- **Python Version**: [e.g., 3.9.16]

**Training Configuration**:

```yaml
# training_config.yaml
experiment_name: customer_churn_v1
compute_target: cpu-cluster-standard-d4
num_epochs: 100  # If applicable
batch_size: 256  # If applicable
learning_rate: 0.001  # If applicable
optimizer: adam  # If applicable
early_stopping: 
  patience: 10
  monitor: val_f1_score
```

---

## Performance Metrics

### Test Set Results

**Primary Metric**: [Metric name and value]

Example:
> **F1-Score**: 0.82

**Comprehensive Metrics**:

| Metric | Value | Threshold |
|--------|-------|-----------|
| Accuracy | 0.85 | ≥ 0.85 ✅ |
| Precision | 0.78 | ≥ 0.75 ✅ |
| Recall | 0.86 | ≥ 0.80 ✅ |
| F1-Score | 0.82 | ≥ 0.80 ✅ |
| AUC-ROC | 0.91 | ≥ 0.85 ✅ |
| AUC-PR | 0.84 | ≥ 0.75 ✅ |

---

### Confusion Matrix

|                    | Predicted: Churned (1) | Predicted: Retained (0) |
|--------------------|------------------------|-------------------------|
| **Actual: Churned (1)** | 860 (TP) | 140 (FN) |
| **Actual: Retained (0)** | 2,430 (FP) | 6,570 (TN) |

**Interpretation**:
- **True Positives (860)**: Correctly identified churners - enables proactive retention
- **False Positives (2,430)**: Incorrectly flagged as churners - acceptable given retention campaign is low-cost
- **False Negatives (140)**: Missed churners - **14% miss rate is concerning**, monitoring required
- **True Negatives (6,570)**: Correctly identified retained customers

---

### Performance by Segment

| Segment | Precision | Recall | F1-Score | Sample Size |
|---------|-----------|--------|----------|-------------|
| Overall | 0.78 | 0.86 | 0.82 | 10,000 |
| Small Business | 0.75 | 0.88 | 0.81 | 4,500 |
| Mid-Market | 0.80 | 0.85 | 0.82 | 3,500 |
| Enterprise | 0.82 | 0.83 | 0.82 | 2,000 |

**Segment Analysis**:

[Describe any performance variations across segments]

Example:
> Model performs consistently across customer segments. Slightly lower precision for Small Business segment may be due to higher volatility in this segment's behavior patterns.

---

### Business Impact Metrics

| Metric | Before Model | With Model | Improvement |
|--------|--------------|------------|-------------|
| Churn Rate | 12% quarterly | 9.6% quarterly | **20% reduction** ✅ |
| Retention Cost | $500/customer | $380/customer | **24% reduction** ✅ |
| False Alarm Rate | N/A | 27% | Acceptable ✅ |
| Intervention Success Rate | 35% | 52% | **49% improvement** ✅ |

**ROI Calculation**:

```
Annual Customers at Risk: 10,000
Model Prevents Churn: 2,000 (20% improvement)
Average Customer Lifetime Value: $5,000
Annual Value Created: $10M
Model Operating Cost: $200K
Net ROI: $9.8M (4,900% ROI)
```

---

## Fairness & Bias Assessment

### Fairness Evaluation

**Sensitive Attributes Analyzed**:
- [List attributes like age, gender, race, geography, etc.]

Example:
- Customer size (Small / Mid / Enterprise)
- Geographic region (North America / Europe / Asia-Pacific)
- Account age (<1 year / 1-3 years / 3+ years)

**Fairness Metrics**:

| Metric | Overall | Small Business | Mid-Market | Enterprise | Pass/Fail |
|--------|---------|----------------|------------|------------|-----------|
| **Accuracy** | 0.85 | 0.84 | 0.85 | 0.86 | ✅ Pass (Δ<5%) |
| **Precision** | 0.78 | 0.75 | 0.80 | 0.82 | ✅ Pass (Δ<10%) |
| **Recall** | 0.86 | 0.88 | 0.85 | 0.83 | ✅ Pass (Δ<10%) |
| **False Positive Rate** | 0.27 | 0.29 | 0.26 | 0.24 | ✅ Pass (Δ<20%) |

**Demographic Parity Ratio**: 0.92 (threshold: ≥ 0.80) ✅

**Equalized Odds Assessment**:
- **Pass**: Difference in false positive rates <0.10 across all segments

---

### Bias Mitigation

**Bias Sources Identified**:

1. **[Bias Type]**: [Description]
   - **Mitigation**: [How addressed]

Example:

1. **Training Data Imbalance**: Small Business customers over-represented (60% of data) vs Enterprise (15%)
   - **Mitigation**: Applied stratified sampling and class weights to balance representation

2. **Historical Bias**: Model trained on pre-COVID data may not reflect current customer behavior
   - **Mitigation**: Retrained on recent 18-month window, implemented drift detection

3. **Feature Proxy Bias**: Contract value correlates with company size, may introduce bias
   - **Mitigation**: Normalized contract value by company size, monitored fairness metrics

---

### Bias Testing Results

**Tests Performed**:
- [x] Demographic parity analysis
- [x] Equalized odds testing
- [x] Calibration analysis
- [x] Error rate parity
- [x] Treatment equality

**Overall Fairness Score**: 8.5/10 ✅

**Continuous Monitoring**:
- Monthly fairness metric review
- Automated alerts if metrics drop below thresholds
- Quarterly bias audits by AI Ethics team

---

## Explainability

### Global Interpretability

**Top 10 Most Important Features**:

| Rank | Feature | Importance | Description |
|------|---------|------------|-------------|
| 1 | nps_score | 0.18 | Net Promoter Score |
| 2 | monthly_active_users | 0.15 | Average MAU (last 3 months) |
| 3 | support_tickets_90d | 0.12 | Support tickets (90 days) |
| 4 | usage_decline_pct | 0.10 | % decline in usage vs prior quarter |
| 5 | account_age_months | 0.09 | Months since account creation |
| 6 | contract_value | 0.08 | Annual contract value |
| 7 | feature_adoption_score | 0.07 | % of features actively used |
| 8 | payment_delays | 0.06 | Number of late payments (12 months) |
| 9 | executive_engagement | 0.05 | Engagement score with account exec |
| 10 | competitor_mentions | 0.04 | Mentions of competitors in support tickets |

**Feature Importance Visualization**:

```
nps_score                  ████████████████████ 0.18
monthly_active_users       ███████████████ 0.15
support_tickets_90d        ████████████ 0.12
usage_decline_pct          ██████████ 0.10
account_age_months         █████████ 0.09
contract_value             ████████ 0.08
feature_adoption_score     ███████ 0.07
payment_delays             ██████ 0.06
executive_engagement       █████ 0.05
competitor_mentions        ████ 0.04
```

---

### Local Interpretability (SHAP)

**Example Prediction Explanation**:

```
Customer ID: CUST_12345
Churn Probability: 0.82 (High Risk)

SHAP Value Contributions:
  nps_score = -20            ↓ -0.25 (Strong negative contributor)
  support_tickets_90d = 8    ↑ +0.18 (High ticket volume)
  usage_decline_pct = 35%    ↑ +0.15 (Significant usage drop)
  monthly_active_users = 2   ↑ +0.12 (Low engagement)
  account_age_months = 14    ↑ +0.08 (Early stage, higher risk)
  contract_value = $12K      ↓ -0.05 (Lower value = higher risk)
  
  Base churn rate: 0.10
  Prediction: 0.82
  
Recommended Actions:
  1. Immediate account manager outreach (low NPS)
  2. Investigate support issues (high ticket count)
  3. Conduct executive business review
  4. Offer training/onboarding support (usage decline)
```

**Explainability Tools Used**:
- SHAP (SHapley Additive exPlanations)
- Feature importance from Random Forest
- Partial dependence plots

---

## Limitations & Risks

### Known Limitations

1. **[Limitation Type]**: [Description and impact]

Example:

1. **Temporal Limitations**:
   - Model trained on pre-2024 data; may not reflect recent market changes
   - **Impact**: Performance may degrade for customers acquired after Jan 2024
   - **Mitigation**: Quarterly retraining with recent data

2. **Data Requirements**:
   - Requires minimum 3 months of customer history
   - **Impact**: Cannot predict churn for newly acquired customers
   - **Mitigation**: Use rule-based system for customers <3 months old

3. **Feature Availability**:
   - Depends on NPS survey completion (60% response rate)
   - **Impact**: Missing NPS for 40% of customers reduces prediction confidence
   - **Mitigation**: Use imputation based on segment averages; flag low-confidence predictions

4. **Concept Drift**:
   - Customer behavior changes over time
   - **Impact**: Model accuracy degrades 5-10% per quarter without retraining
   - **Mitigation**: Monthly drift monitoring, quarterly retraining schedule

---

### Risk Assessment

| Risk | Likelihood | Impact | Severity | Mitigation |
|------|------------|--------|----------|------------|
| [Risk] | [H/M/L] | [H/M/L] | [H/M/L] | [Strategy] |

Example:

| Risk | Likelihood | Impact | Severity | Mitigation |
|------|------------|--------|----------|------------|
| False negatives (missed churners) | Medium | High | **High** | Weekly monitoring, human review of borderline cases |
| Model drift due to market changes | High | Medium | **High** | Automated drift detection, quarterly retraining |
| Over-reliance on automation | Medium | Medium | **Medium** | Require human approval for high-value accounts |
| Data privacy breach | Low | High | **Medium** | Encryption, access controls, regular audits |
| Biased predictions for new segments | Low | Medium | **Low** | Continuous fairness monitoring, segment analysis |

---

### Failure Modes

**What happens if the model fails?**

[Describe failure scenarios and fallbacks]

Example:

1. **Endpoint Unavailable**:
   - **Fallback**: Use rule-based churn scoring (manual calculation)
   - **Recovery Time**: < 4 hours

2. **Prediction Quality Degradation**:
   - **Detection**: Automated monitoring alerts if accuracy drops >10%
   - **Response**: Suspend automated actions, initiate investigation, trigger retraining

3. **Data Pipeline Failure**:
   - **Fallback**: Use last successful model run predictions
   - **Alert**: Immediate notification to ML team
   - **SLA**: Restore within 24 hours

---

## Ethical Considerations

### Ethical Principles

This model adheres to the following ethical principles:

- [x] **Transparency**: Model logic and decisions are explainable
- [x] **Fairness**: Tested for bias across demographic groups
- [x] **Privacy**: Uses only consented, aggregated data
- [x] **Accountability**: Clear ownership and human oversight
- [x] **Beneficence**: Designed to benefit customers through better service
- [x] **Non-maleficence**: Safeguards to prevent harm

---

### Ethical Review

**Review Date**: [Date]  
**Reviewed By**: [AI Ethics Committee]  
**Outcome**: [Approved / Conditional Approval / Rejected]

**Ethical Concerns Identified**:

1. **[Concern]**: [Description]
   - **Resolution**: [How addressed]

Example:

1. **Customer Consent**: Customers not explicitly informed of churn prediction model
   - **Resolution**: Updated privacy policy and terms of service to disclose AI usage

2. **Automated Decision-Making**: Risk of fully automated account actions without human oversight
   - **Resolution**: Implemented human-in-the-loop for all high-stakes decisions

3. **Data Retention**: Training data includes 5 years of customer history
   - **Resolution**: Aligned with data retention policy; implemented right-to-deletion process

---

### Responsible AI Checklist

- [x] Model purpose clearly documented
- [x] Training data sources documented
- [x] Bias and fairness tested
- [x] Explainability mechanisms implemented
- [x] Privacy and security measures in place
- [x] Human oversight required for decisions
- [x] Monitoring and alerting configured
- [x] Incident response plan documented
- [x] Regular audits scheduled
- [x] Stakeholder communication plan

---

## Deployment Details

### Production Environment

**Deployment Type**: [Real-time / Batch / Hybrid]

Example:
> Batch predictions (weekly schedule)

**Infrastructure**:

| Component | Specification |
|-----------|---------------|
| **Hosting** | Azure Kubernetes Service (AKS) |
| **Container** | Docker (Ubuntu 20.04, Python 3.9) |
| **Compute** | Standard_D4s_v3 (4 vCPU, 16 GB RAM) |
| **Replicas** | 3 (with auto-scaling to 10) |
| **Storage** | Azure Blob Storage (model artifacts) |
| **Database** | Azure SQL Database (predictions log) |
| **Monitoring** | Azure Application Insights |

---

### Deployment Pipeline

```
┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│    Model     │    │   Model      │    │   Staging    │
│  Training    │───►│ Registration │───►│ Deployment   │
└──────────────┘    └──────────────┘    └──────────────┘
                                               │
                                               │ Validation Tests
                                               │
                                        ┌──────▼──────────┐
                                        │   Production    │
                                        │   Deployment    │
                                        │  (Blue/Green)   │
                                        └─────────────────┘
```

**Deployment Frequency**: Weekly (every Sunday 2:00 AM UTC)

**Rollback Plan**:
- Automated rollback if error rate > 5%
- Manual rollback procedure: < 15 minutes
- Previous version kept for 90 days

---

### API Specification

**Endpoint**: `https://api.company.com/ml/churn-prediction/v1/predict`

**Authentication**: Bearer Token (OAuth 2.0)

**Request**:

```json
{
  "customer_id": "CUST_12345",
  "features": {
    "account_age_months": 14,
    "monthly_active_users": 2.5,
    "nps_score": -20,
    "support_tickets_90d": 8,
    "contract_value": 12000,
    "usage_decline_pct": 35,
    "feature_adoption_score": 0.45
  }
}
```

**Response**:

```json
{
  "customer_id": "CUST_12345",
  "prediction": {
    "churn_probability": 0.82,
    "risk_category": "High",
    "confidence": 0.91
  },
  "explanation": {
    "top_factors": [
      {"feature": "nps_score", "impact": -0.25, "value": -20},
      {"feature": "support_tickets_90d", "impact": 0.18, "value": 8},
      {"feature": "usage_decline_pct", "impact": 0.15, "value": 35}
    ]
  },
  "recommendations": [
    "Immediate account manager outreach",
    "Investigate support issues",
    "Conduct executive business review"
  ],
  "model_version": "1.0.0",
  "timestamp": "2026-01-12T10:30:00Z"
}
```

---

## Monitoring & Maintenance

### Performance Monitoring

**Metrics Tracked**:

| Metric | Frequency | Alert Threshold |
|--------|-----------|-----------------|
| Prediction Accuracy | Daily | < 0.80 |
| Inference Latency | Real-time | > 500ms |
| Error Rate | Real-time | > 2% |
| Data Drift (PSI) | Weekly | > 0.2 |
| Concept Drift | Monthly | Accuracy drop > 5% |
| Fairness Metrics | Monthly | Parity ratio < 0.80 |

**Monitoring Dashboard**: [Link to dashboard]

---

### Model Retraining

**Retraining Schedule**: Quarterly (every 3 months)

**Retraining Triggers**:
- Scheduled quarterly retraining
- Accuracy drops below 0.80
- Data drift detected (PSI > 0.3)
- Significant business/market changes
- New data sources become available

**Retraining Process**:
1. Collect new training data (last 18 months)
2. Validate data quality
3. Retrain model with same hyperparameters
4. Evaluate performance on holdout test set
5. Compare to current production model
6. If improvement ≥ 2%, deploy new version
7. If degradation, investigate and adjust approach

---

### Incident Response

**Escalation Path**:

```
Level 1: Automated Alert → ML Engineer (Response: 15 min)
Level 2: ML Team Lead (Response: 1 hour)
Level 3: Data Science Manager (Response: 4 hours)
Level 4: CTO / CAIO (Response: 24 hours)
```

**Common Incidents**:

| Incident Type | Response Time | Resolution |
|---------------|---------------|------------|
| High error rate (>5%) | 15 min | Rollback to previous version |
| Endpoint unavailable | 15 min | Failover to standby instance |
| Data pipeline failure | 1 hour | Manual data refresh |
| Drift detection | 24 hours | Trigger retraining pipeline |
| Fairness violation | 4 hours | Suspend predictions, investigate |

---

## Version History

| Version | Date | Changes | Author | Approver |
|---------|------|---------|--------|----------|
| 1.0.0 | 2025-06-15 | Initial production release | Jane Doe | John Smith |
| 1.1.0 | 2025-09-20 | Retrained with Q3 data, improved recall +5% | Jane Doe | John Smith |
| 1.2.0 | 2025-12-18 | Added new features (competitor mentions), improved F1 +3% | Jane Doe | John Smith |
| 2.0.0 | 2026-01-12 | Architecture change (XGBoost → Random Forest for explainability) | Jane Doe | John Smith |

**Change Log**: [Link to detailed change log]

---

## Approvals & Sign-offs

### Technical Approval

- [x] **ML Engineer**: [Name], [Date]
- [x] **Data Scientist**: [Name], [Date]
- [x] **ML Architect**: [Name], [Date]
- [x] **Platform Team**: [Name], [Date]

### Business Approval

- [x] **Product Owner**: [Name], [Date]
- [x] **Business Stakeholder**: [Name], [Date]
- [x] **Legal/Compliance**: [Name], [Date]

### Governance Approval

- [x] **AI Ethics Committee**: [Name], [Date]
- [x] **Security Team**: [Name], [Date]
- [x] **Privacy Officer**: [Name], [Date]
- [x] **Risk Management**: [Name], [Date]

### Final Approval

- [x] **Head of AI CoE**: [Name], [Date]
- [x] **CTO/CAIO**: [Name], [Date]

**Production Deployment Approval**: ✅ Approved on [Date]

---

## Contact & Support

**Model Owner**: [Name]  
**Email**: [email@company.com]  
**Team**: [Team Name]  
**Slack Channel**: #ml-churn-model  

**Support**:
- **Technical Issues**: ml-support@company.com
- **Business Questions**: product-ml@company.com
- **Ethics/Compliance**: ai-ethics@company.com

---

**Document Version**: 2.0.0  
**Last Updated**: January 12, 2026  
**Next Review**: April 12, 2026 (Quarterly)

---

*This model card follows the [Model Cards for Model Reporting](https://arxiv.org/abs/1810.03993) framework and Microsoft Responsible AI principles.*
