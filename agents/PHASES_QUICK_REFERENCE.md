# Quick Reference: Using Phases Feature

## Accessing Phases

```
python value_analysis_agent.py
↓
Main Menu
↓
Option 9: View Methodology Phases
```

## Navigation Flow

```
METHODOLOGY PHASES MENU
├── 1. View All Phases Overview
│   └── Shows all 9 phases with duration and purpose
│
├── 2. View Specific Phase Details
│   ├── Select phase (0-8)
│   └── Interactive detail view:
│       ├── 1. View Success Criteria
│       ├── 2. View Deliverables
│       ├── 3. View Exit Criteria
│       ├── 4. View Key Activities
│       ├── 5. View All Details Again
│       └── 6. Return to Phases Menu
│
├── 3. View Phase by Number
│   ├── Enter number (0-8)
│   └── Same interactive detail view
│
└── 4. Return to Main Menu
```

## Common Scenarios

### Scenario 1: Planning Discovery Phase
```
Action: Option 9 → Option 2 → Select Phase 0
View: Success Criteria, Deliverables, Exit Criteria
Result: Complete checklist of what's needed
```

### Scenario 2: Phase Gate Review (Build Complete)
```
Action: Option 9 → Option 3 → Enter: 4
View: Option 3 (Exit Criteria)
Result: Verify all criteria met before Test & Evaluate
```

### Scenario 3: New Team Member Orientation
```
Action: Option 9 → Option 1
View: All phases overview
Result: Understand complete project lifecycle
```

### Scenario 4: Client Presentation Prep
```
Action: Option 9 → Option 2 → Browse each phase
View: Purpose, Duration, Deliverables
Result: Build comprehensive methodology slides
```

## Phase Quick Reference

| # | Phase | Duration | Primary Purpose |
|---|-------|----------|-----------------|
| 0 | Pre-sales & Discovery | 2-4 weeks | Qualify & validate |
| 1 | Mobilise | 2-3 weeks | Establish foundation |
| 2 | Hackathons | 2-4 weeks | Rapid prototype & validate |
| 3 | Setup Platform | 3-4 weeks | Infrastructure & MLOps |
| 4 | Build | 8-12 weeks | Agile development |
| 5 | Integrate | 2-4 weeks | System integration |
| 6 | Test & Evaluate | 4-6 weeks | QA & validation |
| 7 | Prepare & Deploy | 2-4 weeks | Production deployment |
| 8 | Operate & Care | Ongoing | Monitor & optimize |

## Tips

✅ **Before starting phase:** Review objectives and deliverables  
✅ **During phase:** Check key activities regularly  
✅ **Before phase gate:** Validate all exit criteria met  
✅ **For presentations:** Use phase details for professional content  
✅ **For planning:** Reference duration and resource needs  

## Example Output

```
================================================================================
PHASE 4: BUILD
================================================================================

Duration: 8-12 weeks (4-6 sprints)
Purpose: Agile development of production-quality AI solution...

KEY OBJECTIVES:
  • Develop all planned features and functionality
  • Build production-quality ML models
  • Implement user interfaces and APIs
  • Conduct continuous testing (unit, integration)
  ...

SUCCESS CRITERIA:
  ✓ All MVP features complete and tested
  ✓ Code quality standards met (test coverage >80%)
  ✓ Security requirements met
  ...

KEY DELIVERABLES:
  📄 Working application (all features)
  📄 ML models (trained and validated)
  📄 APIs and integrations
  ...
```

## Integration with Value Analysis

The phases feature complements value analysis:

1. **During Discovery (Phase 0):** Use Five Whys analysis
2. **During Mobilisation (Phase 1):** Generate business case with ROI
3. **Throughout Project:** Track value realization against phase milestones
4. **During Planning:** Reference phase deliverables for scope definition

---

**Pro Tip:** Bookmark this guide for quick reference during project execution!
