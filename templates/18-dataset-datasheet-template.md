# Dataset Documentation (Data Sheet) Template
## Comprehensive Dataset Documentation for Responsible AI

**Dataset Name**: [Insert Dataset Name]  
**Version**: [e.g., 1.0.0]  
**Last Updated**: [Date]  
**Dataset Owner**: [Team/Individual]  
**Access Level**: [Public / Internal / Confidential / Restricted]

---

## Table of Contents

1. [Dataset Overview](#dataset-overview)
2. [Motivation & Purpose](#motivation--purpose)
3. [Dataset Composition](#dataset-composition)
4. [Data Collection](#data-collection)
5. [Data Preprocessing](#data-preprocessing)
6. [Data Quality](#data-quality)
7. [Privacy & Security](#privacy--security)
8. [Ethical Considerations](#ethical-considerations)
9. [Dataset Usage](#dataset-usage)
10. [Maintenance & Updates](#maintenance--updates)
11. [Access & Distribution](#access--distribution)
12. [Version History](#version-history)

---

## Dataset Overview

### Quick Facts

| Attribute | Value |
|-----------|-------|
| **Dataset Name** | [Full name] |
| **Short Description** | [1-2 sentence description] |
| **Domain** | [e.g., Healthcare, Finance, Retail, Manufacturing] |
| **Data Type** | [Structured / Unstructured / Semi-structured] |
| **Format** | [CSV, Parquet, JSON, Images, Text, etc.] |
| **Size** | [Number of records and file size] |
| **Features** | [Number of columns/features] |
| **Time Period** | [Date range covered] |
| **Update Frequency** | [Daily, Weekly, Monthly, One-time] |
| **Language** | [For text data: English, Multi-lingual, etc.] |
| **Geographic Coverage** | [Countries/regions covered] |

Example:
| Attribute | Value |
|-----------|-------|
| **Dataset Name** | Customer Transaction History Dataset |
| **Short Description** | Historical customer purchase transactions for churn prediction modeling |
| **Domain** | E-commerce / Retail |
| **Data Type** | Structured |
| **Format** | Parquet (compressed) |
| **Size** | 50M records, 25 GB |
| **Features** | 45 columns |
| **Time Period** | January 2020 - December 2024 |
| **Update Frequency** | Weekly |
| **Language** | N/A (numeric/categorical data) |
| **Geographic Coverage** | North America, Europe |

---

## Motivation & Purpose

### Why was this dataset created?

[Explain the motivation behind creating this dataset]

Example:
> This dataset was created to enable predictive analytics for customer churn, allowing the business to identify at-risk customers and implement proactive retention strategies. The dataset consolidates transaction history, customer demographics, and engagement metrics from multiple source systems.

### What tasks is this dataset intended for?

- [x] [Task 1]
- [x] [Task 2]
- [x] [Task 3]

Example:
- [x] Customer churn prediction
- [x] Customer lifetime value estimation
- [x] Product recommendation systems
- [x] Customer segmentation analysis
- [x] Demand forecasting

### Who created this dataset?

**Created By**: [Team/Organization]  
**Funding**: [Funding source, if applicable]  
**Creation Date**: [Date]

Example:
**Created By**: Data Engineering Team, Customer Analytics Department  
**Funding**: Internal company resources  
**Creation Date**: January 2020

---

## Dataset Composition

### Data Schema

**Total Records**: [N]  
**Total Features**: [N]

#### Feature Descriptions

| Feature Name | Data Type | Description | Example Values | Missing % |
|-------------|-----------|-------------|----------------|-----------|
| [feature_1] | [type] | [description] | [examples] | [%] |

Example:
| Feature Name | Data Type | Description | Example Values | Missing % |
|-------------|-----------|-------------|----------------|-----------|
| customer_id | String | Unique customer identifier | "CUST_00123" | 0% |
| transaction_date | DateTime | Date and time of transaction | "2024-01-15 14:30:00" | 0% |
| transaction_amount | Float | Total transaction value (USD) | 49.99, 125.50 | 0.2% |
| product_category | String | Product category purchased | "Electronics", "Clothing" | 1.5% |
| payment_method | String | Payment method used | "Credit Card", "PayPal" | 0.8% |
| customer_age | Integer | Customer age at transaction time | 25, 42, 65 | 5.2% |
| customer_gender | String | Customer gender | "M", "F", "Other", "Prefer not to say" | 8.1% |
| account_age_days | Integer | Days since account creation | 365, 1095 | 0% |
| loyalty_tier | String | Customer loyalty program tier | "Bronze", "Silver", "Gold", "Platinum" | 2.3% |

---

### Data Statistics

#### Numerical Features

| Feature | Min | Max | Mean | Median | Std Dev |
|---------|-----|-----|------|--------|---------|
| [feature] | [val] | [val] | [val] | [val] | [val] |

Example:
| Feature | Min | Max | Mean | Median | Std Dev |
|---------|-----|-----|------|--------|---------|
| transaction_amount | $0.01 | $9,999.99 | $87.43 | $52.00 | $125.67 |
| customer_age | 18 | 95 | 42.3 | 41.0 | 15.8 |
| account_age_days | 1 | 1,825 | 638.2 | 547.0 | 421.5 |

#### Categorical Features

| Feature | Unique Values | Most Common | Second Most Common | Frequency Distribution |
|---------|---------------|-------------|--------------------|-----------------------|
| [feature] | [N] | [value (freq)] | [value (freq)] | [Skew: High/Medium/Low] |

Example:
| Feature | Unique Values | Most Common | Second Most Common | Frequency Distribution |
|---------|---------------|-------------|--------------------|-----------------------|
| payment_method | 5 | Credit Card (62%) | Debit Card (23%) | Medium skew |
| customer_gender | 4 | F (48%) | M (45%) | Balanced |
| loyalty_tier | 4 | Bronze (45%) | Silver (30%) | High skew |
| product_category | 12 | Electronics (28%) | Clothing (22%) | Medium skew |

---

### Data Distribution

**Class Distribution** (if applicable for classification tasks):

| Class | Count | Percentage |
|-------|-------|------------|
| [Class 1] | [N] | [%] |
| [Class 2] | [N] | [%] |

Example:
| Class | Count | Percentage |
|-------|-------|------------|
| Churned (within 90 days) | 5.2M | 10.4% |
| Active (retained) | 44.8M | 89.6% |

**Note**: Dataset is imbalanced (10:1 ratio). Consider using stratified sampling or SMOTE for model training.

---

### Sensitive / Protected Attributes

**Does this dataset contain data that might be considered sensitive or personal?**

- [x] Yes / [ ] No

**If yes, list the sensitive attributes:**

| Attribute | Type | Justification for Inclusion | Protection Measures |
|-----------|------|----------------------------|---------------------|
| [attribute] | [PII/PHI/Other] | [reason] | [measures] |

Example:
| Attribute | Type | Justification for Inclusion | Protection Measures |
|-----------|------|----------------------------|---------------------|
| customer_age | Demographic | Required for age-based segmentation and fairness analysis | Aggregated in 5-year bins for reporting |
| customer_gender | Demographic | Fairness testing and bias detection | Optional field, "Prefer not to say" option |
| zip_code | Geographic PII | Geographic segmentation | 3-digit ZIP only (not full 5-digit) |

**Redacted/Removed PII**:
- Email addresses → Hashed customer_id
- Phone numbers → Removed
- Full names → Removed
- Credit card numbers → Removed (only payment method type retained)
- Addresses → Replaced with 3-digit ZIP code

---

## Data Collection

### How was the data collected?

**Collection Method**: [Describe collection methodology]

Example:
> Data was collected from three primary source systems:
> 1. **E-commerce Platform**: Transactional data captured automatically at checkout
> 2. **Customer Relationship Management (CRM)**: Customer demographic and account data
> 3. **Marketing Automation Platform**: Customer engagement and campaign interaction data
>
> Data is extracted nightly via scheduled ETL pipelines, transformed to common schema, and loaded into Azure Data Lake.

---

### Data Sources

| Source System | Data Elements | Frequency | Latency | Reliability |
|--------------|---------------|-----------|---------|-------------|
| [System 1] | [Elements] | [Frequency] | [Latency] | [%] |

Example:
| Source System | Data Elements | Frequency | Latency | Reliability |
|--------------|---------------|-----------|---------|-------------|
| E-commerce DB (SQL Server) | Transactions, products, orders | Real-time | <1 min | 99.9% |
| CRM (Salesforce) | Customer demographics, accounts | Daily batch | 12 hours | 99.5% |
| Marketing Platform (HubSpot) | Engagement metrics, campaigns | Daily batch | 24 hours | 99.0% |
| Support System (Zendesk) | Support tickets, satisfaction scores | Daily batch | 12 hours | 99.2% |

---

### Collection Timeframe

**Start Date**: [Date]  
**End Date**: [Date or "Ongoing"]  
**Total Duration**: [Duration]

Example:
**Start Date**: January 1, 2020  
**End Date**: Ongoing (continuously updated)  
**Total Duration**: 5 years+ (as of Jan 2026)

---

### Sampling Strategy

**Was sampling used?**

- [ ] Yes / [x] No - Full population included

**If yes, describe sampling methodology:**

[Describe sampling strategy]

Example:
> N/A - Dataset includes all transactions from all customers during the specified time period (no sampling applied).

---

### Data Collection Ethics

**Was informed consent obtained?**

- [x] Yes / [ ] No / [ ] N/A

**If yes, how?**

Example:
> Customers provide consent via:
> 1. Terms of Service agreement during account creation (explicit consent)
> 2. Privacy Policy acceptance (updated annually)
> 3. Cookie consent for web analytics data
>
> Customers can opt-out at any time via account settings or by contacting customer support. Opt-out results in exclusion from analytics datasets within 48 hours.

**Was IRB approval obtained?** (If applicable)

- [ ] Yes / [ ] No / [x] N/A (commercial use case)

---

## Data Preprocessing

### Cleaning Steps Performed

1. **[Step 1]**: [Description and justification]

Example:

1. **Duplicate Removal**:
   - Removed 12,450 duplicate transaction records (0.025% of dataset)
   - Identified duplicates based on: customer_id + transaction_date + transaction_amount
   - Kept first occurrence, removed subsequent duplicates

2. **Outlier Handling**:
   - Capped transaction_amount at 99.5th percentile ($2,500) to remove fraudulent transactions
   - Flagged and investigated transactions >$10,000 (0.01% of data)
   - Removed 350 transactions with negative amounts (data entry errors)

3. **Missing Value Treatment**:
   - Imputed missing transaction_amount (0.2%) using median by product_category
   - Imputed missing customer_age (5.2%) using median age by account_age_days
   - Removed records with missing customer_id or transaction_date (0 records after validation)

4. **Data Type Conversions**:
   - Converted transaction_date from String to DateTime format
   - Standardized currency values to USD (converted from EUR, GBP)
   - Normalized categorical values (e.g., "m", "M", "male" → "M")

5. **Feature Engineering**:
   - Created derived features: days_since_last_purchase, purchase_frequency, avg_transaction_value
   - Binned customer_age into age groups: 18-25, 26-35, 36-45, 46-55, 56-65, 66+
   - Encoded categorical features using label encoding

---

### Transformations Applied

| Transformation | Features Affected | Justification |
|---------------|------------------|---------------|
| [Transformation] | [Features] | [Reason] |

Example:
| Transformation | Features Affected | Justification |
|---------------|------------------|---------------|
| Log transformation | transaction_amount, account_age_days | Reduce right skew, normalize distribution |
| Min-max scaling | All numeric features | Normalize range to [0, 1] for ML models |
| One-hot encoding | payment_method, product_category, loyalty_tier | Convert categorical to numeric |
| Date parsing | transaction_date | Extract year, month, day, day_of_week features |

---

### Data Splits

**Was the data split into train/validation/test sets?**

- [x] Yes / [ ] No

**If yes, provide split details:**

| Split | Records | Percentage | Selection Method |
|-------|---------|------------|------------------|
| Training | 35M | 70% | Temporal (2020-2023) |
| Validation | 7.5M | 15% | Temporal (Jan-Jun 2024) |
| Test | 7.5M | 15% | Temporal (Jul-Dec 2024) |

**Split Method Justification**:
> Used temporal split to prevent data leakage and simulate real-world deployment scenario where model predicts future behavior based on historical data. Random split would leak future information into training set.

---

## Data Quality

### Quality Assessment

**Overall Data Quality Score**: [X/10]

Example: 8.5/10

**Quality Dimensions**:

| Dimension | Score (1-10) | Assessment | Issues Identified |
|-----------|--------------|------------|-------------------|
| **Completeness** | 9.0 | Good | 5.2% missing values in customer_age, 8.1% in gender |
| **Accuracy** | 8.5 | Good | 350 transactions with negative amounts (corrected) |
| **Consistency** | 8.0 | Good | Some inconsistent categorical encoding (standardized) |
| **Timeliness** | 9.5 | Excellent | Data refreshed weekly, <48 hour lag |
| **Validity** | 9.0 | Excellent | 99.97% of records pass validation rules |
| **Uniqueness** | 9.5 | Excellent | 0.025% duplicates (removed) |

---

### Known Data Issues

| Issue | Affected Records | Impact | Mitigation |
|-------|------------------|--------|------------|
| [Issue] | [N or %] | [High/Med/Low] | [Action taken] |

Example:
| Issue | Affected Records | Impact | Mitigation |
|-------|------------------|--------|------------|
| Missing customer_age | 2.6M (5.2%) | Medium | Imputed using median by account age |
| Missing customer_gender | 4M (8.1%) | Low | Added "Unknown" category, flagged for analysis |
| Inconsistent date formats | 150K (0.3%) | High | Standardized to ISO 8601 format |
| Currency conversion errors | 5K (0.01%) | Medium | Manual review and correction |

---

### Data Validation Rules

**Validation rules applied:**

1. **[Rule Type]**: [Description]

Example:

1. **Schema Validation**:
   - All required columns present
   - Data types match schema definition
   - No null values in primary key (customer_id)

2. **Business Rules**:
   - transaction_amount > $0
   - transaction_date within valid range (2020-present)
   - customer_age between 18 and 120
   - All product_category values in approved list

3. **Referential Integrity**:
   - All customer_ids exist in customer master table
   - All product_ids exist in product catalog
   - All transaction_dates >= account_creation_date

4. **Statistical Validation**:
   - No outliers beyond 3 standard deviations (or capped)
   - Class distribution within expected ranges
   - Feature correlations match historical patterns

---

## Privacy & Security

### Privacy Protection Measures

**PII Handling**:

- [x] PII identified and documented
- [x] PII removed or pseudonymized
- [x] Data anonymized where possible
- [x] Access controls implemented
- [x] Encryption at rest and in transit
- [x] Audit logging enabled

**Specific Measures**:

1. **[Measure Type]**: [Description]

Example:

1. **Pseudonymization**:
   - Email addresses hashed using SHA-256
   - Names replaced with customer_id (random UUID)
   - Credit card numbers removed (only payment type retained)

2. **Data Minimization**:
   - Only collected data necessary for stated purpose
   - Removed fields not required for analysis (e.g., IP addresses, device IDs)
   - Reduced precision of location data (ZIP code → 3-digit ZIP)

3. **Aggregation**:
   - Age reported in 5-year bins for public reporting
   - Income reported in ranges rather than exact values
   - Geographic data aggregated to region level

4. **Access Controls**:
   - Role-based access control (RBAC) enforced
   - Data accessible only to authorized data scientists and analysts
   - Multi-factor authentication required
   - All access logged and audited monthly

---

### Regulatory Compliance

**Regulations Applicable**:

- [x] GDPR (General Data Protection Regulation) - Europe
- [x] CCPA (California Consumer Privacy Act) - California
- [x] HIPAA (Health Insurance Portability and Accountability Act) - If healthcare data
- [ ] Other: [Specify]

**Compliance Measures**:

| Regulation | Requirement | Implementation |
|------------|-------------|----------------|
| [Regulation] | [Requirement] | [How met] |

Example:
| Regulation | Requirement | Implementation |
|------------|-------------|----------------|
| GDPR | Right to be forgotten | Automated deletion pipeline, <30 day fulfillment |
| GDPR | Data portability | Export API available to customers |
| GDPR | Consent management | Consent tracked in CRM, linked to dataset records |
| CCPA | Opt-out mechanism | Privacy settings in customer portal |
| CCPA | Data disclosure | Annual transparency report published |

---

### Data Security

**Security Classification**: [Public / Internal / Confidential / Restricted]

Example: **Confidential**

**Security Controls**:

| Control | Implementation |
|---------|----------------|
| **Encryption at Rest** | AES-256 encryption for all storage |
| **Encryption in Transit** | TLS 1.3 for all data transfers |
| **Access Control** | RBAC with MFA, least privilege principle |
| **Network Security** | Private endpoints, no public internet access |
| **Monitoring** | 24/7 security monitoring, automated alerting |
| **Audit Logging** | All access logged, retained for 7 years |
| **Data Masking** | PII masked in non-production environments |
| **Backup & Recovery** | Daily backups, encrypted, geo-redundant |

---

## Ethical Considerations

### Ethical Review

**Was an ethical review conducted?**

- [x] Yes / [ ] No

**Conducted By**: [AI Ethics Committee / IRB / Other]  
**Review Date**: [Date]  
**Outcome**: [Approved / Conditional / Rejected]

Example:
**Conducted By**: AI Ethics Committee  
**Review Date**: December 15, 2019  
**Outcome**: Approved with conditions (added opt-out mechanism, enhanced consent language)

---

### Ethical Concerns Identified

1. **[Concern]**: [Description]
   - **Mitigation**: [Action taken]

Example:

1. **Demographic Bias Risk**:
   - Dataset underrepresents customers from certain geographic regions (rural areas: 5% vs 20% of population)
   - **Mitigation**: Added weighting factor for underrepresented regions; flagged in documentation; monitoring for bias in model outputs

2. **Consent Granularity**:
   - Original consent was broad; didn't specifically mention machine learning use cases
   - **Mitigation**: Updated privacy policy and terms of service; sent notification to all existing customers; provided opt-out mechanism

3. **Potential for Discriminatory Outcomes**:
   - Gender and age data could enable discriminatory practices if misused
   - **Mitigation**: Implemented fairness testing requirements for all models; restricted access to sensitive attributes; required bias assessment for production deployment

---

### Social Impact Assessment

**Potential Positive Impacts**:

- [Benefit 1]
- [Benefit 2]

Example:
- Enables personalized customer experiences, improving satisfaction
- Helps identify at-risk customers for proactive support, reducing involuntary churn
- Powers product recommendations, helping customers discover relevant products

**Potential Negative Impacts**:

- [Risk 1]
- [Risk 2]

Example:
- Could enable manipulative marketing practices if misused
- Risk of discriminatory treatment based on demographic attributes
- Privacy concerns if data handling practices are inadequate

**Mitigation Strategies**:

- [Strategy 1]
- [Strategy 2]

Example:
- Established AI ethics guidelines and required ethics review for all use cases
- Implemented fairness testing and bias monitoring
- Transparent privacy practices with easy opt-out
- Regular audits of model outcomes for unintended consequences

---

## Dataset Usage

### Recommended Uses

**This dataset is suitable for:**

- [x] [Use case 1]
- [x] [Use case 2]

Example:
- [x] Customer churn prediction modeling
- [x] Customer lifetime value estimation
- [x] Segmentation and clustering analysis
- [x] Demand forecasting
- [x] Product recommendation systems
- [x] Marketing campaign optimization

**Best Practices**:

1. [Practice 1]

Example:

1. **Temporal Split for Time-Series**: Always use temporal train/test split (not random) to prevent data leakage
2. **Class Imbalance Handling**: Apply SMOTE, under/oversampling, or class weights due to 10:1 imbalance
3. **Feature Scaling**: Normalize numeric features before feeding to distance-based algorithms
4. **Fairness Testing**: Test model outputs for bias across demographic groups (age, gender, geography)
5. **Concept Drift Monitoring**: Implement drift detection as customer behavior changes over time

---

### Out-of-Scope Uses

**This dataset should NOT be used for:**

- ❌ [Prohibited use 1]

Example:
- ❌ Making automated decisions with significant impact without human review (e.g., account termination)
- ❌ Targeting vulnerable populations (e.g., minors, financially distressed customers)
- ❌ Training models on non-U.S./Europe customers (data limited to these regions)
- ❌ Real-time fraud detection (dataset designed for batch analytics, not real-time)
- ❌ Medical or health-related predictions (not validated for such use)

---

## Maintenance & Updates

### Update Schedule

**Update Frequency**: [Daily / Weekly / Monthly / Quarterly / Annually / As-needed]

Example: **Weekly** (every Sunday at 2:00 AM UTC)

**Update Process**:

1. [Step 1]

Example:

1. **Extract**: Pull incremental data from source systems (last 7 days)
2. **Validate**: Run data quality checks and validation rules
3. **Transform**: Apply standardized transformations and cleaning
4. **Append**: Append new data to existing dataset
5. **Test**: Run integration tests on updated dataset
6. **Publish**: Make new version available with updated metadata

**Update Notification**:
- Slack notification to #data-updates channel
- Email to registered dataset users
- Version increment in metadata

---

### Versioning

**Current Version**: [Version number]  
**Versioning Scheme**: [Semantic versioning / Date-based / Other]

Example:
**Current Version**: 2.5.0  
**Versioning Scheme**: Semantic versioning (MAJOR.MINOR.PATCH)

**Version Numbering Rules**:
- **MAJOR**: Breaking schema changes, major data source changes
- **MINOR**: New features/columns added, non-breaking enhancements
- **PATCH**: Bug fixes, data quality improvements, backfills

---

### Dataset Lifecycle

**Current Status**: [Active / Deprecated / Archived]

Example: **Active**

**Retention Policy**:
- **Active Data**: Last 5 years kept in hot storage
- **Archived Data**: 5-10 years old moved to cold storage
- **Deleted Data**: >10 years old permanently deleted (unless legal hold)

**Deprecation Plan**:
- N/A - Dataset actively maintained

**End-of-Life**: Not planned

---

## Access & Distribution

### How to Access

**Location**: [Path/URL to dataset]

Example:
```
Microsoft Fabric Lakehouse: abfss://datasets@fabricworkspace.lakehouse.fabric.microsoft.com/customer_transactions/
Azure Data Lake: abfss://datasets@dlstorageprod.dfs.core.windows.net/customer_transactions/
Dataverse: https://org.crm.dynamics.com/api/data/v9.2/customerdata
Format: Parquet (compressed)
Partitioned by: year, month
```

**Access Requirements**:

- [Requirement 1]

Example:
- Active company Azure AD account
- Member of "DataScience-Team" security group
- Completed data privacy training (annually)
- Signed data usage agreement

**Request Process**:

1. [Step 1]

Example:

1. Submit access request via IT Service Desk portal
2. Manager approval required
3. Complete data privacy training (if not current)
4. Sign data usage agreement
5. Access provisioned within 2 business days

---

### Distribution

**Is this dataset publicly available?**

- [ ] Yes / [x] No

**If yes:**

- **License**: [e.g., MIT, Apache 2.0, CC-BY-4.0]
- **Distribution Platform**: [e.g., Kaggle, UCI ML Repository, AWS Open Data]
- **DOI**: [Digital Object Identifier, if applicable]

**If no (internal use only):**

- **Internal Distribution Platform**: Microsoft Fabric Lakehouse, Dataverse, Azure Data Lake, SharePoint, internal data catalog
- **Access Governance**: RBAC enforced, access logged and audited

---

## Version History

| Version | Date | Changes | Author | Approver |
|---------|------|---------|--------|----------|
| 1.0.0 | 2020-01-15 | Initial dataset creation | Data Eng Team | CTO |
| 1.5.0 | 2021-06-01 | Added support ticket data source | Data Eng Team | CTO |
| 2.0.0 | 2022-03-10 | Schema change: added customer engagement metrics | Data Eng Team | CTO |
| 2.5.0 | 2024-01-12 | Added marketing campaign data; improved data quality | Data Eng Team | CTO |

**Detailed Change Log**: [Link to full change log]

---

## Contact & Support

**Dataset Owner**: [Name]  
**Email**: [email@company.com]  
**Team**: Data Engineering Team  
**Slack Channel**: #data-customer-transactions  

**Support**:
- **Technical Issues**: data-support@company.com
- **Access Requests**: IT Service Desk
- **Data Quality Issues**: data-quality@company.com
- **Privacy/Compliance Questions**: privacy-office@company.com

---

## References & Related Datasets

**Related Datasets**:
- [Dataset Name 1] - [Brief description and link]
- [Dataset Name 2] - [Brief description and link]

Example:
- **Customer Demographics Dataset** - Customer profile data (age, location, account info)
- **Product Catalog Dataset** - Product metadata, categories, pricing
- **Marketing Campaign Dataset** - Campaign history, engagement metrics

**Documentation**:
- [Data Dictionary] - Detailed feature definitions
- [Data Lineage Diagram] - Visual representation of data flow
- [Data Quality Dashboard] - Real-time data quality metrics

---

**Document Version**: 2.5.0  
**Last Updated**: January 12, 2026  
**Next Review**: April 12, 2026 (Quarterly)

---

*This data sheet follows the [Datasheets for Datasets](https://arxiv.org/abs/1803.09010) framework and Microsoft Responsible AI principles.*
