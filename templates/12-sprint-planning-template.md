# Sprint Planning Template

## Sprint Information

| **Project Name** | [AI Project Name] |
|-----------------|-------------------|
| **Sprint Number** | Sprint [X] |
| **Sprint Duration** | [2 weeks typical] |
| **Sprint Start Date** | [DD/MM/YYYY] |
| **Sprint End Date** | [DD/MM/YYYY] |
| **Product Owner** | [Name] |
| **Scrum Master** | [Name] |

---

## Sprint Goal

**Sprint Goal**: [One clear, concise sentence describing what the sprint aims to achieve]

**Example**: "Establish data pipeline and train baseline model with >80% accuracy"

---

## Team Capacity

### Team Members

| Name | Role | Availability (%) | Capacity (Hours) | Capacity (Story Points) |
|------|------|------------------|------------------|------------------------|
| [Name] | Data Scientist | 100% | 80h | ~13 SP |
| [Name] | ML Engineer | 80% | 64h | ~10 SP |
| [Name] | Data Engineer | 100% | 80h | ~13 SP |
| [Name] | Full Stack Dev | 50% | 40h | ~7 SP |

**Total Team Capacity**: ___ hours / ___ story points

**Notes on Capacity**:
- Assume 80 hours per person per 2-week sprint (8h/day × 10 days)
- Account for holidays, planned absences, meetings (typically ~20% overhead)
- Adjust for part-time allocation

---

## Sprint Backlog

### Selected User Stories

#### Story 1: [Story Title]

**User Story**:
```
As a [type of user]
I want to [perform some action]
So that I can [achieve some goal]
```

**Acceptance Criteria**:
- [ ] Given [context], when [action], then [expected result]
- [ ] Given [context], when [action], then [expected result]
- [ ] Given [context], when [action], then [expected result]

**Story Points**: [X]

**Priority**: High / Medium / Low

**Assigned To**: [Team Member]

**Dependencies**: [Any dependencies on other stories or external factors]

**Technical Notes**:
[Any technical considerations, approach, or constraints]

---

#### Story 2: [Story Title]

**User Story**:
```
As a [type of user]
I want to [perform some action]
So that I can [achieve some goal]
```

**Acceptance Criteria**:
- [ ] Given [context], when [action], then [expected result]
- [ ] Given [context], when [action], then [expected result]

**Story Points**: [X]

**Priority**: High / Medium / Low

**Assigned To**: [Team Member]

**Dependencies**: [Dependencies]

**Technical Notes**:
[Notes]

---

#### Story 3: [Story Title]
[Repeat structure for each story]

---

### Technical Tasks (Non-User Stories)

#### Task 1: [Task Name]
- **Description**: [What needs to be done]
- **Story Points**: [X]
- **Assigned To**: [Team Member]
- **Why**: [Why is this needed?]

#### Task 2: [Task Name]
[Repeat]

---

## Sprint Backlog Summary

| ID | Story/Task | Story Points | Assigned To | Priority |
|----|------------|--------------|-------------|----------|
| US-01 | [Story title] | 5 | [Name] | High |
| US-02 | [Story title] | 3 | [Name] | High |
| US-03 | [Story title] | 8 | [Name] | Medium |
| T-01 | [Task title] | 2 | [Name] | High |
| T-02 | [Task title] | 3 | [Name] | Medium |

**Total Committed Story Points**: [X]

**Team Capacity**: [Y] story points

**Capacity Utilization**: [X/Y] = [Z%]

**Recommendation**: Aim for 80-90% capacity utilization to allow for unknowns

---

## Definition of Done

A user story is considered "Done" when:

- [ ] Code is written and committed to Git
- [ ] Code follows coding standards
- [ ] Unit tests written (>70% coverage for new code)
- [ ] Code reviewed and approved
- [ ] Functionality tested (manual or automated)
- [ ] Acceptance criteria validated
- [ ] Documentation updated (inline comments, README)
- [ ] Deployed to dev environment
- [ ] Demonstrated to Product Owner
- [ ] Product Owner accepts the work

**Sprint-Specific DoD Additions**:
- [ ] [Any additional criteria for this sprint]

---

## Risks & Dependencies

### Identified Risks

| Risk | Probability | Impact | Mitigation | Owner |
|------|------------|--------|------------|-------|
| [Risk 1] | High/Med/Low | High/Med/Low | [Mitigation plan] | [Name] |
| [Risk 2] | | | | |

### Dependencies

| Story | Depends On | Status | ETA | Blocker? |
|-------|------------|--------|-----|----------|
| US-03 | External API access | Pending | [Date] | Yes |
| US-05 | Story US-02 complete | Not Started | End of Week 1 | No |

---

## Sprint Ceremonies Schedule

| Ceremony | Frequency | Day/Time | Duration | Attendees |
|----------|-----------|----------|----------|-----------|
| Daily Standup | Daily | [Time] | 15 min | Dev Team |
| Backlog Refinement | Mid-sprint | [Day/Time] | 1 hour | PO, Team |
| Sprint Review/Demo | End of sprint | [Day/Time] | 1 hour | All stakeholders |
| Sprint Retrospective | End of sprint | [Day/Time] | 45 min | Dev Team, SM |
| Next Sprint Planning | End of sprint | [Day/Time] | 2 hours | PO, Team, SM |

---

## Success Criteria

This sprint will be successful if:

1. [Success criteria 1, e.g., "Data pipeline processes 100K records successfully"]
2. [Success criteria 2, e.g., "Baseline model achieves >80% accuracy"]
3. [Success criteria 3, e.g., "All high-priority stories completed"]
4. [Success criteria 4, e.g., "Zero critical bugs"]
5. [Success criteria 5, e.g., "Stakeholders satisfied with demo"]

---

## Notes from Sprint Planning Meeting

**Date**: [DD/MM/YYYY]

**Attendees**: [List of attendees]

**Key Discussions**:
- [Discussion point 1]
- [Discussion point 2]

**Decisions Made**:
- [Decision 1]
- [Decision 2]

**Action Items**:
- [ ] [Action 1] - Owner: [Name] - Due: [Date]
- [ ] [Action 2] - Owner: [Name] - Due: [Date]

---

## Sprint Burndown Chart

[Space to paste or link to burndown chart from Azure DevOps]

**Target**: Steady decline from [X] story points to 0 over [Y] days

---

## Communication Plan

**Daily Updates**: Daily standup at [Time]

**Blockers**: Raise immediately in Teams channel, escalate in standup

**Status Reports**: [Frequency, e.g., "End of week summary to stakeholders"]

**Demo Preparation**: [When/how, e.g., "Day before sprint review"]

---

## Tools & Links

- **Azure DevOps Board**: [Link]
- **Git Repository**: [Link]
- **Teams Channel**: [Link]
- **Documentation**: [Link]
- **Demo Environment**: [Link]

---

## Appendix: Story Sizing Guide

Use Fibonacci sequence for story points: **1, 2, 3, 5, 8, 13, 21**

**1 point**: Trivial, <2 hours, very low complexity
**2 points**: Simple, ~half day, low complexity
**3 points**: Moderate, ~1 day, some complexity
**5 points**: Significant, 2-3 days, moderate complexity
**8 points**: Large, 3-5 days, high complexity
**13 points**: Very large, consider breaking down
**21 points**: Epic, must be broken down into smaller stories

**Factors to Consider**:
- Complexity
- Amount of work
- Uncertainty/unknowns
- Dependencies

---

**Document Status**: Draft / Final

**Next Review**: End of sprint

---

**Let's have a great sprint!** 🚀
