# Story Points Estimation Guide for AI/ML Projects
## Practical Guide with Examples

---

## 📖 Document Information

| **Field** | **Value** |
|-----------|-----------|
| **Version** | 1.0 |
| **Last Updated** | January 15, 2026 |
| **Author** | AI Delivery Methodology Team |
| **Purpose** | Provide comprehensive guidance on estimating user stories for AI/ML projects |

---

## 📑 Table of Contents

1. [What Are Story Points?](#what-are-story-points)
2. [Why Use Story Points for AI Projects?](#why-use-story-points-for-ai-projects)
3. [The Fibonacci Sequence](#the-fibonacci-sequence)
4. [Estimation Factors](#estimation-factors)
5. [AI/ML-Specific Considerations](#aiml-specific-considerations)
6. [Story Point Scale with AI Examples](#story-point-scale-with-ai-examples)
7. [Common AI User Stories by Size](#common-ai-user-stories-by-size)
8. [Planning Poker Process](#planning-poker-process)
9. [Team Velocity](#team-velocity)
10. [Common Pitfalls](#common-pitfalls)
11. [Calibration Examples](#calibration-examples)

---

## What Are Story Points?

**Story points** are a relative unit of measure used to estimate the effort required to implement a user story. They consider:

- **Complexity**: How difficult is the work?
- **Amount of work**: How much needs to be done?
- **Uncertainty**: How many unknowns exist?
- **Dependencies**: What else needs to be in place?

### Key Principle: Relative, Not Absolute

Story points measure **relative effort**, not time. A 5-point story takes roughly twice as long as a 2-point story, and half as long as a 10-point story.

---

## Why Use Story Points for AI Projects?

AI/ML projects have unique characteristics that make story points particularly valuable:

### ✅ Benefits

1. **Handles Uncertainty**: ML experiments have unpredictable outcomes
2. **Team-Based**: Accounts for team experience with AI technologies
3. **Technology-Agnostic**: Works across different AI frameworks
4. **Accounts for Complexity**: Captures non-coding work (data prep, model training, evaluation)
5. **Velocity Tracking**: Helps predict capacity over time

### 🎯 AI-Specific Challenges

- Data quality issues discovered late
- Model performance doesn't meet targets
- Hyperparameter tuning takes longer than expected
- Infrastructure issues (GPU availability, memory)
- Integration complexity with existing systems

---

## The Fibonacci Sequence

Use the **modified Fibonacci sequence**: **1, 2, 3, 5, 8, 13, 21, 40, 100**

### Why Fibonacci?

- Forces discussion about significant differences
- Reflects increasing uncertainty for larger items
- Prevents false precision ("Is it 7 or 8 points?")

### Scale Breakdown

| Points | Size | Description | Typical Duration* |
|--------|------|-------------|-------------------|
| **1** | XS | Trivial change | 1-2 hours |
| **2** | S | Simple task | 2-4 hours |
| **3** | M | Small story | 4-8 hours (1 day) |
| **5** | L | Medium story | 1-2 days |
| **8** | XL | Large story | 2-3 days |
| **13** | XXL | Very large story | 3-5 days |
| **21** | Epic | Should be broken down | 5-10 days |
| **40** | Epic | Must be broken down | 2+ weeks |
| **100** | Theme | Must be broken into epics | 1+ month |

*_Duration is illustrative only - story points are relative, not time-based_

---

## Estimation Factors

### 1. Complexity

**Low Complexity** (Multiply by 0.8-1.0):
- Well-understood requirements
- Proven technology stack
- Similar work done before
- Clear acceptance criteria

**Medium Complexity** (Multiply by 1.0-1.2):
- Some new technology
- Moderate data challenges
- Standard ML algorithms
- Some integration points

**High Complexity** (Multiply by 1.3-1.5):
- Cutting-edge AI techniques
- Poor data quality
- Complex integrations
- Regulatory requirements

**Very High Complexity** (Multiply by 1.6-2.0):
- Novel research-level work
- Multi-model systems
- Real-time requirements
- Strict SLA requirements

### 2. Uncertainty

- **Low**: "We've done this before"
- **Medium**: "We understand the approach"
- **High**: "We need to experiment"
- **Very High**: "We don't know if this is possible"

### 3. Dependencies

- External APIs
- Data availability
- Other team deliverables
- Infrastructure provisioning
- Approvals and gates

---

## AI/ML-Specific Considerations

### Data Work

**Add points for**:
- Data discovery and profiling
- Data quality assessment
- Data cleaning and transformation
- Feature engineering
- Data labeling/annotation
- Data pipeline development

### Model Development

**Add points for**:
- Exploratory data analysis
- Model selection and experimentation
- Hyperparameter tuning
- Model validation and testing
- Bias/fairness evaluation
- Explainability implementation

### Infrastructure

**Add points for**:
- GPU/compute resource setup
- Model registry configuration
- MLOps pipeline development
- Monitoring and alerting
- Model versioning

---

## Story Point Scale with AI Examples

### 1 Point - Trivial (1-2 hours)

**Examples**:
- Update model hyperparameter in config file
- Add logging statement to prediction endpoint
- Fix typo in data schema
- Update documentation with new API endpoint
- Add unit test for helper function

**Characteristics**:
- No research needed
- No new infrastructure
- No data work
- Clear implementation
- Minimal testing

---

### 2 Points - Simple (2-4 hours)

**Examples**:
- Add new feature to existing feature store
- Update data validation rules
- Add error handling to API endpoint
- Create simple data visualization
- Write integration test for existing endpoint

**Characteristics**:
- Well-defined scope
- Existing patterns to follow
- Minimal data work
- Standard testing

---

### 3 Points - Small Story (~1 day)

**Examples**:
- Implement basic data preprocessing step
- Add new metric to model evaluation
- Create simple batch inference job
- Implement A/B test framework component
- Add authentication to API endpoint

**Characteristics**:
- Some design needed
- Moderate testing required
- May need minor infrastructure changes
- Clear acceptance criteria

---

### 5 Points - Medium Story (1-2 days)

**Examples**:
- Implement feature engineering pipeline for one data source
- Add model explainability (SHAP/LIME) to predictions
- Create model performance monitoring dashboard
- Implement data drift detection for one model
- Develop batch scoring pipeline
- Create custom evaluation metric

**Characteristics**:
- Requires design discussion
- Multiple components involved
- Comprehensive testing needed
- Some uncertainty in approach

**Real Example - Fraud Detection**:
```
Story: As a fraud analyst, I can see SHAP explanations for fraud predictions

Tasks:
- Research SHAP library and implementation (1 pt)
- Integrate SHAP with existing model (2 pts)
- Create API endpoint for explanations (1 pt)
- Add UI component to display explanations (1 pt)
Total: 5 points
```

---

### 8 Points - Large Story (2-3 days)

**Examples**:
- Implement end-to-end training pipeline for new model
- Create real-time inference API with Redis caching
- Develop feature store for one domain
- Implement model retraining automation
- Build custom model serving infrastructure
- Integrate with external ML platform

**Characteristics**:
- Significant design work
- Multiple systems involved
- Performance testing required
- Integration complexity

**Real Example - Customer Churn**:
```
Story: As a system, I can automatically retrain churn model monthly

Tasks:
- Design retraining pipeline architecture (1 pt)
- Implement data extraction for training (2 pts)
- Add model validation and comparison (2 pts)
- Create automated model promotion logic (2 pts)
- Add monitoring and alerting (1 pt)
Total: 8 points
```

---

### 13 Points - Very Large Story (3-5 days)

**Examples**:
- Implement complete MLOps pipeline (CI/CD for models)
- Develop multi-model ensemble system
- Build real-time streaming ML pipeline
- Create automated feature engineering system
- Implement model A/B testing framework
- Develop custom AutoML solution

**Characteristics**:
- Complex architecture
- High uncertainty
- Multiple integration points
- Extensive testing required
- Consider breaking down

**Real Example - Recommendation Engine**:
```
Story: As a user, I receive real-time personalized recommendations

Tasks:
- Design real-time architecture (2 pts)
- Implement user feature extraction (2 pts)
- Build item embedding service (2 pts)
- Develop recommendation ranking algorithm (3 pts)
- Create caching layer (2 pts)
- Integrate with user service (2 pts)
Total: 13 points

⚠️ Consider breaking into 2-3 smaller stories
```

---

### 21 Points - Epic (5-10 days)

**⛔ BREAK THIS DOWN** - Too large for a single sprint

**Examples**:
- Build complete ML platform from scratch
- Implement enterprise-wide feature store
- Develop multi-language NLP system
- Create end-to-end computer vision pipeline

**How to Break Down**:
1. Identify core functionality (MVP)
2. Separate infrastructure from features
3. Create story for each major component
4. Split by data source or model type

---

## Common AI User Stories by Size

### Data Engineering Stories

| Story | Typical Points | Notes |
|-------|----------------|-------|
| Add new data source to pipeline | 5-8 | Depends on API complexity |
| Implement data quality checks | 3-5 | Per data source |
| Create data transformation job | 3-5 | Standard transformations |
| Build feature engineering pipeline | 8-13 | Complex calculations |
| Implement data versioning | 8-13 | Infrastructure setup |

### Model Development Stories

| Story | Typical Points | Notes |
|-------|----------------|-------|
| Train baseline model | 3-5 | Using existing pipeline |
| Experiment with new algorithm | 5-8 | Includes evaluation |
| Hyperparameter tuning | 3-8 | Depends on search space |
| Implement model validation | 5-8 | Comprehensive tests |
| Add bias/fairness testing | 5-8 | Framework setup |

### API/Integration Stories

| Story | Typical Points | Notes |
|-------|----------------|-------|
| Create simple REST endpoint | 2-3 | CRUD operations |
| Add prediction endpoint | 5-8 | Includes model loading |
| Implement batch scoring API | 8-13 | Queue + processing |
| Build real-time streaming | 13-21 | High complexity |
| Integrate with enterprise system | 8-13 | Depends on system |

### Infrastructure Stories

| Story | Typical Points | Notes |
|-------|----------------|-------|
| Set up model registry | 5-8 | Configuration |
| Implement CI/CD pipeline | 8-13 | Full automation |
| Add monitoring dashboard | 5-8 | Standard metrics |
| Set up GPU cluster | 8-13 | Infrastructure provisioning |
| Implement model versioning | 5-8 | Registry + tracking |

---

## Planning Poker Process

### Step-by-Step Guide

#### 1. Preparation (Before Meeting)

- [ ] Product Owner writes user stories with acceptance criteria
- [ ] Stories added to backlog with descriptions
- [ ] Team reviews stories before meeting
- [ ] Reference stories selected (baseline comparisons)

#### 2. Story Discussion (5-10 minutes per story)

1. **Product Owner presents story**
   - Read user story
   - Explain business value
   - Review acceptance criteria
   - Answer clarifying questions

2. **Technical discussion**
   - Data Scientist: Data and model complexity
   - ML Engineer: Infrastructure needs
   - Backend Developer: API and integration
   - Frontend Developer: UI requirements
   - QA: Testing complexity

3. **Identify unknowns**
   - What do we know?
   - What don't we know?
   - What assumptions are we making?

#### 3. Estimation (2-3 minutes)

1. **Silent voting**
   - Each team member selects a card
   - Everyone reveals simultaneously
   - No discussion until after reveal

2. **Discuss differences**
   - Highest and lowest estimates explain reasoning
   - Team discusses assumptions
   - Re-vote if needed

3. **Consensus**
   - Agree on final estimate
   - Document key assumptions
   - Note any dependencies

#### 4. Example Session

```
Story: Implement data drift detection for churn model

Product Owner: "We need to monitor when customer behavior changes
significantly so we know when to retrain the model."

Data Scientist: "I'll need to set up statistical tests and define 
thresholds. Plus baseline data collection."

ML Engineer: "We'll need scheduled jobs and alerting infrastructure."

QA: "Need to test both true positive drift and false alarms."

First Vote: 3, 5, 5, 8, 13

Lowest (3): "I think we can use existing monitoring framework"
Highest (13): "But we need to implement the statistical tests and 
alerting logic, plus testing different threshold scenarios"

Discussion: Team agrees existing framework helps, but custom logic needed

Second Vote: 5, 5, 5, 8, 5

Consensus: 5 points ✓
```

---

## Team Velocity

### What is Velocity?

**Velocity** = Story points completed per sprint

### Measuring Velocity

**Sprint 1-3**: Calibration period
- Track completed story points
- Don't over-commit
- Focus on "Done" definition

**Sprint 4+**: Use average velocity for planning

### Typical Velocities

| Team Size | Experience | Typical Velocity (2-week sprint) |
|-----------|------------|----------------------------------|
| 3-4 people | Junior | 15-25 points |
| 3-4 people | Mixed | 25-35 points |
| 3-4 people | Senior | 35-45 points |
| 5-7 people | Junior | 25-40 points |
| 5-7 people | Mixed | 40-60 points |
| 5-7 people | Senior | 60-80 points |
| 8-10 people | Mixed | 60-90 points |

### Factors Affecting Velocity

**Increase Velocity**:
- Team experience grows
- Domain knowledge improves
- Tools and automation mature
- Technical debt reduced

**Decrease Velocity**:
- New team members
- Complex integrations
- High technical debt
- Frequent context switching
- Production support burden

---

## Common Pitfalls

### ❌ Pitfall #1: Confusing Story Points with Hours

**Wrong**: "This is 5 points because it's 5 hours of work"
**Right**: "This is 5 points because it's similar complexity to our reference 5-point story"

### ❌ Pitfall #2: Not Including AI-Specific Work

**Wrong**: Estimating only coding time
**Right**: Include data prep, model training, hyperparameter tuning, evaluation

### ❌ Pitfall #3: Underestimating Data Work

**Example**:
```
Initial estimate: 5 points (just the model code)
Reality: 13 points
- Data discovery: 2 pts
- Data cleaning: 3 pts
- Feature engineering: 3 pts
- Model training: 2 pts
- Evaluation: 2 pts
- Documentation: 1 pt
```

### ❌ Pitfall #4: Ignoring Technical Debt

Add 20-30% for:
- Refactoring legacy code
- Updating dependencies
- Improving test coverage
- Addressing security issues

### ❌ Pitfall #5: Not Accounting for Uncertainty

Use **confidence levels**:
- High confidence: Use base estimate
- Medium confidence: Add 30-50%
- Low confidence: Add 50-100% or spike first

### ❌ Pitfall #6: Stories Too Large

**Rule**: If story > 13 points, break it down

**Example of Breaking Down**:
```
Original (21 pts): Build complete recommendation system

Break into:
- Story 1 (8 pts): Implement collaborative filtering model
- Story 2 (5 pts): Create user embedding service
- Story 3 (5 pts): Build recommendation API
- Story 4 (3 pts): Add A/B testing framework
```

---

## Calibration Examples

### Reference Stories for Your Team

Create a "reference story catalog" with actual completed stories:

#### 1-Point Reference
```
Story: Update model hyperparameter in config file
Actual work: Changed learning_rate from 0.01 to 0.001 in config.yaml
Time: 30 minutes
```

#### 3-Point Reference
```
Story: Add new metric to model evaluation
Actual work:
- Added F2-score calculation
- Updated evaluation script
- Added visualization
- Updated documentation
Time: 1 day
```

#### 5-Point Reference
```
Story: Implement SHAP explanations for predictions
Actual work:
- Researched SHAP library
- Integrated with existing model
- Created API endpoint
- Added UI component
- Unit and integration tests
Time: 2 days
```

#### 8-Point Reference
```
Story: Build automated model retraining pipeline
Actual work:
- Designed pipeline architecture
- Implemented data extraction
- Added model validation logic
- Created automated promotion
- Set up monitoring
- Comprehensive testing
Time: 3 days
```

#### 13-Point Reference
```
Story: Implement real-time fraud detection API
Actual work:
- Designed real-time architecture
- Built feature extraction service
- Implemented model serving
- Added caching layer
- Created monitoring dashboard
- Load testing
- Security review
Time: 5 days
```

---

## AI/ML Story Templates with Examples

### Template 1: Model Training Story

```
As a [Data Scientist],
I need to [train a production-ready model],
So that [we can make accurate predictions]

Acceptance Criteria:
- [ ] Model achieves >X% accuracy on validation set
- [ ] Training pipeline is automated
- [ ] Model is versioned in registry
- [ ] Performance metrics documented
- [ ] Model passed fairness evaluation

Estimate: 5-8 points (depending on complexity)
```

### Template 2: Data Pipeline Story

```
As a [ML Engineer],
I need to [build a data pipeline for model training],
So that [we have clean, feature-engineered data]

Acceptance Criteria:
- [ ] Data extracted from source system
- [ ] Data quality checks implemented
- [ ] Feature engineering applied
- [ ] Pipeline is scheduled/triggered
- [ ] Data versioned and tracked
- [ ] Pipeline monitored

Estimate: 8-13 points
```

### Template 3: Model Serving Story

```
As a [Application],
I need to [call model prediction API],
So that [users receive real-time recommendations]

Acceptance Criteria:
- [ ] REST API endpoint created
- [ ] Model loaded and ready
- [ ] Response time <100ms at p95
- [ ] Error handling implemented
- [ ] API documented (Swagger)
- [ ] Load tested for 1000 req/sec

Estimate: 8-13 points
```

---

## Quick Reference Card

### Story Point Cheat Sheet

| Points | Complexity | Duration* | AI Example |
|--------|------------|-----------|------------|
| **1** | Trivial | 1-2 hrs | Update config parameter |
| **2** | Simple | 2-4 hrs | Add logging to endpoint |
| **3** | Small | 1 day | Add data validation rule |
| **5** | Medium | 1-2 days | Implement SHAP explanations |
| **8** | Large | 2-3 days | Build retraining pipeline |
| **13** | Very Large | 3-5 days | Create real-time API |
| **21+** | Epic | Break it down! | Don't estimate - split first |

*_Illustrative only - use relative sizing_

### Planning Poker Quick Steps

1. ☑️ PO presents story
2. ☑️ Team discusses (5-10 min)
3. ☑️ Silent vote
4. ☑️ Discuss outliers
5. ☑️ Re-vote if needed
6. ☑️ Reach consensus

### Velocity Rules of Thumb

- **Sprint 1-3**: Calibration, don't over-commit
- **Sprint 4+**: Use 3-sprint average
- **Plan for 80-90%** of average velocity
- **Buffer for unknowns**: Leave 10-20% slack

---

## Additional Resources

### Tools
- **Azure DevOps**: Built-in story point tracking
- **Jira**: Agile planning with story points
- **Planning Poker Online**: [planningpokeronline.com](https://planningpokeronline.com)
- **Miro/Mural**: Virtual planning poker boards

### Related Documents
- [Sprint Planning Template](../templates/12-sprint-planning-template.md)
- [Build Phase Complete Guide](./build-phase-complete-guide.md)
- [Hackathons Complete Guide](./hackathons-complete-guide.md)

### Further Reading
- Mike Cohn: "Agile Estimating and Planning"
- Mountain Goat Software: Story Point Estimation
- Atlassian Agile Coach: Story Points and Estimation

---

## Appendix: Industry Benchmarks

### AI Project Complexity Multipliers

| Project Type | Complexity Multiplier | Notes |
|--------------|----------------------|-------|
| Simple Dashboard/Reporting | 0.7-0.9 | Well-defined, low risk |
| Document Classification | 0.9-1.1 | Standard NLP |
| Chatbot (Simple) | 1.0-1.2 | Rule-based or simple ML |
| Demand Forecasting | 1.1-1.3 | Time series complexity |
| Recommendation Engine | 1.2-1.5 | Multi-model, real-time |
| Computer Vision | 1.3-1.6 | GPU needs, model complexity |
| Predictive Maintenance | 1.3-1.7 | IoT integration, streaming |
| Fraud Detection (Real-time) | 1.5-1.8 | High throughput, low latency |
| Autonomous Systems | 1.8-2.5 | Safety-critical, complex ML |

### Hours per Story Point (Industry Average)

| Team Experience | Hours per Point |
|----------------|-----------------|
| Junior team (0-1 years) | 8-10 hours |
| Mixed team (1-3 years) | 6-8 hours |
| Senior team (3+ years) | 4-6 hours |
| Expert team (5+ years) | 3-5 hours |

_Note: These are averages only - your team's actual hours per point will vary_

---

**Document Status**: ✅ Complete

**Last Updated**: January 15, 2026

**Feedback**: Submit issues or suggestions via GitHub

---

**Let's estimate with confidence!** 🎯
