# GitHub Projects Setup Guide
## AI Delivery Methodology Development Tracking

**Purpose:** Set up GitHub Projects to track the development, enhancement, and maintenance of the AI Delivery Methodology framework with your team.

**Repository:** `andreaswasita/AI-Delivery-Methodology`

---

## Overview

This guide walks you through creating GitHub Projects to manage the AI Delivery Methodology development work. We'll create:

1. **Master Development Project** - Overall methodology development and enhancement tracking
2. **Component-Specific Views** - Organized by methodology components (guides, checklists, calculators, agents, etc.)

---

## Prerequisites

- GitHub account with owner/admin access to `andreaswasita/AI-Delivery-Methodology`
- Project creation permissions enabled for your account

---

## Step 1: Create Master Development Project

### 1.1 Navigate to Projects

1. Go to https://github.com/andreaswasita/AI-Delivery-Methodology
2. Click the **Projects** tab at the top
3. Click **New project** (green button)

### 1.2 Configure Master Project

**Project Settings:**
- **Project name:** `AI Delivery Methodology - Development Tracker`
- **Description:** `Track development of methodology framework, guides, checklists, calculators, agents, documentation, and enhancements.`
- **Template:** Select **Board** (Kanban-style)
- **Visibility:** Private or Public (recommend Public for open collaboration)

### 1.3 Customize Board Columns

Replace default columns with development workflow statuses:

**Recommended Columns:**
1. **📋 Backlog** - Ideas and future work
2. **🔍 In Review** - Being evaluated or designed
3. **✍️ In Progress** - Actively being developed
4. **👀 Review/QA** - Ready for team review
5. **✅ Done** - Completed and merged
6. **📦 Released** - Deployed and available

**How to Customize:**
- Click the `⋮` menu on each column
- Select "Rename" or "Delete"
- Click `+ Add column` to create new ones
- Drag columns to reorder

---

## Step 2: Create Development Issues by Component

### 2.1 Guides & Documentation

**Issue Template:**
```markdown
Title: [Guides] Enhance Setup Platform Checklist
Labels: guides, documentation, enhancement

Description:
Improve the setup platform checklist based on recent Azure AI Foundry updates.

Objectives:
- [ ] Add Azure AI Foundry workspace setup steps
- [ ] Update security configuration guidance
- [ ] Add Prompt Flow orchestration setup
- [ ] Include monitoring dashboard setup

Deliverables:
- [ ] Updated checklist in guides/03-setup-platform-checklist.md
- [ ] Screenshots or diagrams for new steps
- [ ] Review by 2 team members

Success Criteria:
- Checklist validated with real Azure setup
- All steps tested and working
- Documentation clear for new users

Component: Guides
Priority: High
```

**Create Similar Issues For:**
- `[Guides] Create Azure AI Foundry Integration Guide`
- `[Guides] Update Build Phase Checklist with Agent Development`
- `[Guides] Add Teams Integration Deployment Guide`
- `[Guides] Create Master Agent Orchestration Guide`
- `[Guides] Update Business Envisioning Workshop Checklist`

---

### 2.2 Calculators & Tools

```markdown
Title: [Calculators] Add AI Agent ROI Calculator
Labels: calculators, tools, new-feature

Description:
Create new calculator for AI agent implementation ROI based on the C-level presentation.

Objectives:
- [ ] Design calculator UI in HTML/CSS/JS
- [ ] Implement ROI calculation formulas
- [ ] Add productivity gain scenarios (conservative, base, optimistic)
- [ ] Create export to PDF/Excel functionality
- [ ] Add visual charts for ROI projection

Deliverables:
- [ ] calculators/ai-agent-roi-calculator.html
- [ ] Integration with existing calculator suite
- [ ] User guide and examples
- [ ] Testing with real data

Success Criteria:
- Calculator produces accurate ROI projections
- Matches presentation business case numbers
- Mobile-responsive design
- Works offline

Component: Calculators
Priority: High
```

**Additional Calculator Issues:**
- `[Calculators] Enhance Effort Estimator with AI Agent Productivity Multipliers`
- `[Calculators] Update Team Sizer for AI-Augmented Teams`
- `[Calculators] Add Azure AI Foundry Cost Estimator`
- `[Calculators] Create Agent Capacity Planning Calculator`
- `[Calculators] Fix Chatbot Authentication Issues`

---

### 2.3 Agents & Automation

```markdown
Title: [Agents] Develop Value Analysis Agent MVP
Labels: agents, python, ai

Description:
Create MVP of the Value Analysis Agent that can analyze project data and calculate ROI.

Objectives:
- [ ] Review existing agents/value_analysis_agent.py
- [ ] Enhance with Azure OpenAI integration
- [ ] Add methodology phase tracking capabilities
- [ ] Create agent API endpoints
- [ ] Add Teams integration hooks

Deliverables:
- [ ] Enhanced agents/value_analysis_agent.py
- [ ] API documentation
- [ ] Unit tests (agents/test_agent.py)
- [ ] Integration examples
- [ ] Deployment guide

Success Criteria:
- Agent analyzes project data accurately
- API responds in <2 seconds
- 90% test coverage
- Deployed to test environment

Component: Agents
Priority: High
```

**Additional Agent Issues:**
- `[Agents] Create Project Management Agent`
- `[Agents] Build Research Agent for Market Analysis`
- `[Agents] Develop Test Agent for Checklist Validation`
- `[Agents] Create Documentation Agent for Guide Generation`
- `[Agents] Implement Master Agent Orchestrator`

---

### 2.4 Checklists & Templates

```markdown
Title: [Checklists] Create AI Agent Development Checklist
Labels: checklists, templates, new-feature

Description:
Create comprehensive checklist for building and deploying AI agents.

Objectives:
- [ ] Research agent development best practices
- [ ] Document agent design phase checklist items
- [ ] Add agent testing and validation steps
- [ ] Include security and compliance checks
- [ ] Add deployment and monitoring steps

Deliverables:
- [ ] checklists/09-ai-agent-development-checklist.md
- [ ] Excel version (if needed)
- [ ] Integration with methodology flow

Success Criteria:
- Checklist covers full agent lifecycle
- Validated with real agent development
- Team consensus on checklist items

Component: Checklists
Priority: Medium
```

**Additional Checklist Issues:**
- `[Checklists] Update All Checklists with AI Agent Integration Points`
- `[Checklists] Create Azure AI Foundry Setup Checklist`
- `[Checklists] Add Teams Deployment Checklist`
- `[Checklists] Create Agent Testing & QA Checklist`
- `[Checklists] Generate Excel Versions of All Checklists`

---

### 2.5 Presentations & Decks

```markdown
Title: [Presentations] Create Technical Deep-Dive on Agent Architecture
Labels: presentations, documentation

Description:
Create technical presentation for engineering teams on 3-layer agent architecture.

Objectives:
- [ ] Design presentation structure
- [ ] Create technical architecture diagrams
- [ ] Document Master Agent orchestration patterns
- [ ] Add code examples and patterns
- [ ] Include deployment architecture

Deliverables:
- [ ] presentations/agent-architecture-technical-deep-dive.md
- [ ] PowerPoint/PDF version
- [ ] Architecture diagrams (PNG/SVG)
- [ ] Code samples

Success Criteria:
- Presentation reviewed by architects
- Technical accuracy validated
- Ready for engineering team presentation

Component: Presentations
Priority: Medium
```

**Additional Presentation Issues:**
- `[Presentations] Convert C-Level Deck to PowerPoint`
- `[Presentations] Create Sales Enablement Deck for AI Methodology`
- `[Presentations] Develop Workshop Facilitation Guide`
- `[Presentations] Create Executive Summary One-Pager`

---

### 2.6 Documentation & Architecture

```markdown
Title: [Docs] Document Azure AI Foundry Integration Patterns
Labels: documentation, architecture, azure

Description:
Create comprehensive documentation for Azure AI Foundry integration with methodology.

Objectives:
- [ ] Document Prompt Flow orchestration patterns
- [ ] Add agent deployment workflows
- [ ] Create security configuration guide
- [ ] Document monitoring and observability setup
- [ ] Add troubleshooting guide

Deliverables:
- [ ] docs/azure-ai-foundry-integration.md
- [ ] Architecture diagrams
- [ ] Configuration examples
- [ ] Troubleshooting playbook

Success Criteria:
- Documentation enables team to set up Foundry
- All configurations tested and working
- Team can troubleshoot common issues

Component: Documentation
Priority: High
```

**Additional Documentation Issues:**
- `[Docs] Create Methodology Quick Start Guide`
- `[Docs] Document GitHub Projects Integration`
- `[Docs] Create API Documentation for Agents`
- `[Docs] Write Contributor Guidelines`
- `[Docs] Create Architecture Decision Records (ADRs)`

---

### 2.7 Infrastructure & Deployment

```markdown
Title: [Infrastructure] Set Up Azure Static Web App for Calculators
Labels: infrastructure, deployment, azure

Description:
Deploy calculators suite to Azure Static Web Apps for public access.

Objectives:
- [ ] Create Azure Static Web App resource
- [ ] Configure GitHub Actions deployment
- [ ] Set up custom domain (if needed)
- [ ] Configure SSL certificates
- [ ] Add CDN for performance

Deliverables:
- [ ] infrastructure/azure-static-web-app.bicep
- [ ] .github/workflows/deploy-calculators.yml
- [ ] Deployment documentation
- [ ] Live URL

Success Criteria:
- Calculators accessible at public URL
- CI/CD pipeline working
- SSL configured correctly
- <2 second page load time

Component: Infrastructure
Priority: Medium
```

**Additional Infrastructure Issues:**
- `[Infrastructure] Set Up Python Environment for Agents`
- `[Infrastructure] Configure Azure AI Foundry Workspace`
- `[Infrastructure] Create GitHub Actions for Testing`
- `[Infrastructure] Set Up Monitoring and Alerting`
- `[Infrastructure] Configure Backup and Disaster Recovery`

---

### 2.8 Testing & Quality

```markdown
Title: [Testing] Create Automated Tests for Calculators
Labels: testing, quality, javascript

Description:
Add automated testing for all calculator tools.

Objectives:
- [ ] Set up Jest testing framework
- [ ] Write unit tests for ROI calculator
- [ ] Add tests for effort estimator
- [ ] Create tests for team sizer
- [ ] Add integration tests

Deliverables:
- [ ] calculators/tests/ directory
- [ ] Test suite with >80% coverage
- [ ] CI/CD integration
- [ ] Test documentation

Success Criteria:
- All calculators have test coverage
- Tests run in CI/CD pipeline
- No breaking changes reach main branch

Component: Testing
Priority: Medium
```

**Additional Testing Issues:**
- `[Testing] Add Unit Tests for Python Agents`
- `[Testing] Create Integration Tests for Agent Orchestration`
- `[Testing] Set Up End-to-End Testing for Methodology Flow`
- `[Testing] Add Performance Testing for Agents`
- `[Testing] Create Security Testing Suite`

---

### 2.9 Enhancements & Features

```markdown
Title: [Enhancement] Add Multi-Language Support to Methodology
Labels: enhancement, i18n, feature

Description:
Add internationalization support for guides and calculators.

Objectives:
- [ ] Assess current content for translation readiness
- [ ] Set up i18n framework
- [ ] Translate core guides to Spanish
- [ ] Translate calculators UI
- [ ] Create language selection mechanism

Deliverables:
- [ ] i18n framework implemented
- [ ] Spanish translations for Phase 0-3 guides
- [ ] Language switcher in calculators
- [ ] Translation contribution guide

Success Criteria:
- Spanish translations accurate and complete
- Easy to add new languages
- No performance degradation

Component: Enhancement
Priority: Low
```

**Additional Enhancement Issues:**
- `[Enhancement] Add Dark Mode to Calculators`
- `[Enhancement] Create Mobile App for Methodology`
- `[Enhancement] Add AI-Powered Chatbot for Methodology Q&A`
- `[Enhancement] Create Video Tutorials for Each Phase`
- `[Enhancement] Build Methodology Assessment Tool`

---

### 2.10 Bug Fixes & Maintenance

```markdown
Title: [Bug] Fix Chatbot Authentication Issue
Labels: bug, calculators, high-priority

Description:
Value analysis chatbot authentication is failing based on CHATBOT-TROUBLESHOOTING.md.

Objectives:
- [ ] Reproduce authentication error
- [ ] Review Azure OpenAI key configuration
- [ ] Check CORS settings
- [ ] Test proxy server setup
- [ ] Verify endpoint URLs

Deliverables:
- [ ] Root cause analysis
- [ ] Fix implemented and tested
- [ ] Updated troubleshooting docs
- [ ] Prevent future occurrences

Success Criteria:
- Chatbot authentication working
- No console errors
- Documented solution for team

Component: Bug Fix
Priority: High
```

**Additional Bug/Maintenance Issues:**
- `[Bug] Fix Broken Links in Methodology Navigator`
- `[Maintenance] Update Dependencies for Python Agents`
- `[Maintenance] Refresh Azure CLI Commands in Guides`
- `[Bug] Fix Mobile Responsiveness in Calculators`
- `[Maintenance] Archive Outdated Content in Archive/`

---

## Step 3: Configure Project Views

### 3.1 Create Component View (Grouped by Component)

1. In your project, click `⋮` next to "View 1"
2. Select **Group by** → **Labels**
3. This groups issues by component (guides, calculators, agents, etc.)
4. Rename view to "Component View"

### 3.2 Create Priority View (Grouped by Priority)

1. Click `+ New view`
2. Select **Board** template
3. Group by **Priority** label (high-priority, medium-priority, low-priority)
4. Rename view to "Priority View"

### 3.3 Create Timeline View (Roadmap)

1. Click `+ New view`
2. Select **Roadmap** template
3. Configure:
   - Show start/end dates
   - Group by Component
4. Rename view to "Roadmap View"

### 3.4 Create Team View (Grouped by Assignee)

1. Click `+ New view`
2. Select **Board** template
3. Group by **Assignee**
4. Rename view to "Team View"

---

## Step 4: Link Project to Repository

### 4.1 Link Issues to Repository

When creating issues in Step 2:
1. Navigate to https://github.com/andreaswasita/AI-Delivery-Methodology/issues
2. Click **New issue**
3. Paste issue content from Step 2
4. On the right sidebar, under **Projects**, select your project
5. Set appropriate **Labels**, **Milestone**, and **Assignees**

### 4.2 Enable Project Automation

1. Go to your project settings (⋮ → Settings)
2. Enable automation:
   - ✅ Auto-add items when they match filter
   - ✅ Auto-archive items when closed
   - ✅ Auto-move items based on status changes

---

## Step 5: Add Custom Fields

Enhance tracking with custom fields:

### 5.1 Add Custom Fields

1. In project, click `+ New field`
2. Create these fields:

**Field: Component**
- Type: Single select
- Options: Guides, Calculators, Agents, Checklists, Presentations, Documentation, Infrastructure, Testing, Enhancement, Bug

**Field: Priority**
- Type: Single select
- Options: 🔴 Critical, 🟠 High, 🟡 Medium, 🟢 Low

**Field: Effort**
- Type: Single select
- Options: XS (1-2 hours), S (2-4 hours), M (1-2 days), L (3-5 days), XL (1+ weeks)

**Field: Sprint**
- Type: Number or Text
- Format: Sprint number (Sprint 1, Sprint 2, etc.)

**Field: Release Target**
- Type: Date
- Format: Date picker

---

## Step 6: Set Up Milestones

### 6.1 Create Milestones

Navigate to https://github.com/andreaswasita/AI-Delivery-Methodology/milestones

**Create these milestones:**

1. **v1.0 - Core Methodology Complete**
   - Due date: 3 months from start
   - Description: All core guides, checklists, and phase documentation complete

2. **v1.1 - Calculators & Tools Complete**
   - Due date: 4 months from start
   - Description: All calculator tools deployed and functional

3. **v1.2 - Agent Framework MVP**
   - Due date: 5 months from start
   - Description: Python agent framework with 3-5 agents working

4. **v2.0 - Azure AI Foundry Integration**
   - Due date: 6 months from start
   - Description: Full Azure AI Foundry orchestration integrated

5. **v2.1 - Teams Integration Complete**
   - Due date: 7 months from start
   - Description: All agents deployable to Microsoft Teams

6. **Q1 Release**
   - Due date: End of Q1
   - Description: Quarterly release with all Q1 features

7. **Q2 Release**
   - Due date: End of Q2
   - Description: Quarterly release with all Q2 features

---

## Step 7: Initial Population

### 7.1 Create All Issues

Use the issue templates from Step 2 to create approximately **50-60 issues** covering all components.

**Recommended Issue Count per Component:**
- Guides & Documentation: 8-10 issues
- Calculators & Tools: 6-8 issues
- Agents & Automation: 8-10 issues
- Checklists & Templates: 5-7 issues
- Presentations & Decks: 4-5 issues
- Documentation & Architecture: 6-8 issues
- Infrastructure & Deployment: 5-6 issues
- Testing & Quality: 5-6 issues
- Enhancements & Features: 4-5 issues
- Bug Fixes & Maintenance: 3-5 issues

### 7.2 Assign Issues to Project

For each issue:
1. Assign to appropriate milestone (v1.0, v1.1, etc.)
2. Add to project (Development Tracker)
3. Set labels (component, priority, effort)
4. Assign owner (team member)
5. Set initial status (📋 Backlog)

### 7.3 Prioritize Initial Sprint

Move to **✍️ In Progress**:
- High-priority bug fixes
- Core documentation updates
- Critical calculator fixes
- Foundation agent development

---

## Step 8: Team Collaboration Setup

### 8.1 Add Team Members

1. Go to repository settings
2. Navigate to **Collaborators**
3. Invite team members with appropriate permissions:
   - **Admin:** Can manage repository and projects
   - **Write:** Can create issues, PRs, and update projects
   - **Read:** Can view and comment

### 8.2 Set Up Team Communication

**GitHub Discussions:**
1. Enable Discussions in repository settings
2. Create categories:
   - 📣 Announcements
   - 💡 Ideas & Proposals
   - 🙋 Q&A
   - 🎯 Sprint Planning
   - 📊 Sprint Retrospectives

**Project Notifications:**
1. Configure issue notifications
2. Set up project activity alerts
3. Create Slack/Teams integration (optional)

### 8.3 Define Contribution Workflow

**Branch Strategy:**
- `main` - Production-ready code
- `develop` - Integration branch
- `feature/*` - Feature branches
- `fix/*` - Bug fix branches
- `docs/*` - Documentation updates

**Pull Request Process:**
1. Create feature branch
2. Make changes
3. Create PR with description
4. Link PR to issue
5. Request review from 1-2 team members
6. Merge after approval

---

## Step 9: Ongoing Management

### 9.1 Sprint Planning (Every 2 Weeks)

**Sprint Planning Agenda:**
- Review previous sprint completion
- Move completed items to ✅ Done
- Prioritize backlog for next sprint
- Assign sprint capacity (based on team availability)
- Move selected issues to ✍️ In Progress
- Update milestone dates if needed

**Sprint Goals:**
- Set clear sprint objective (e.g., "Complete Phase 1 guides")
- Define done criteria
- Identify dependencies and blockers

### 9.2 Daily Standups (Optional)

**Quick Check-in Format:**
- What did I complete yesterday?
- What am I working on today?
- Any blockers or help needed?
- Update issue status in project

### 9.3 Sprint Review & Retrospective (End of Sprint)

**Sprint Review:**
- Demo completed work to team
- Update documentation
- Mark issues as completed
- Close milestone if reached

**Sprint Retrospective:**
- What went well?
- What could be improved?
- Action items for next sprint
- Update process documentation

### 9.4 Monthly Repository Health Check

**Metrics to Track:**
- Issue velocity (closed per week)
- Pull request merge time
- Code review turnaround
- Documentation coverage
- Test coverage
- Open vs. closed issues

**Repository Maintenance:**
- Close stale issues
- Update dependencies
- Archive old branches
- Review and update labels
- Cleanup outdated documentation

---

## Summary Checklist

**Setup Complete When:**
- ✅ Development Tracker project created with 6 status columns
- ✅ 50-60 issues created covering all components
- ✅ All issues linked to project and repository
- ✅ 7 milestones created (v1.0, v1.1, v1.2, v2.0, v2.1, Q1, Q2)
- ✅ Custom fields added (Component, Priority, Effort, Sprint, Release Target)
- ✅ 4 views configured (Component, Priority, Roadmap, Team)
- ✅ Project automation enabled
- ✅ Team members invited and onboarded
- ✅ Contribution workflow documented
- ✅ First sprint planned and started

---

## Quick Start Issues to Create First

**Priority 1 - Start Immediately:**
1. `[Bug] Fix Chatbot Authentication Issue` (calculators)
2. `[Docs] Create GitHub Projects Setup Guide` (this document!)
3. `[Guides] Add Azure AI Foundry Integration Guide`
4. `[Calculators] Add AI Agent ROI Calculator`
5. `[Agents] Review and Test Existing Value Analysis Agent`

**Priority 2 - Next Sprint:**
6. `[Checklists] Create AI Agent Development Checklist`
7. `[Infrastructure] Set Up Azure Static Web App for Calculators`
8. `[Testing] Create Automated Tests for Calculators`
9. `[Documentation] Document Azure AI Foundry Integration Patterns`
10. `[Presentations] Convert C-Level Deck to PowerPoint`

**Priority 3 - Backlog:**
- All enhancement and new feature requests
- Nice-to-have improvements
- Future exploration items

---

## Resources

**GitHub Projects Documentation:**
- https://docs.github.com/en/issues/planning-and-tracking-with-projects

**Repository Structure:**
```
AI-Delivery-Methodology/
├── agents/              # Python agents and automation
├── calculators/         # HTML/JS calculator tools
├── checklists/          # Markdown and Excel checklists
├── guides/              # Phase-by-phase guides
├── presentations/       # Markdown presentations and decks
├── docs/                # Architecture and technical docs
├── infrastructure/      # IaC and deployment configs
├── templates/           # Reusable templates
└── archive/             # Archived content
```

**Key Documents:**
- [C-Level AI Agents Presentation](../presentations/c-level-ai-agents-project-delivery.md)
- [README.md](../README.md)
- [Methodology Phases](../agents/PHASES_QUICK_REFERENCE.md)
- [Enhancement Summary](../ENHANCEMENTS-SUMMARY-FEB-2026.md)

**Support:**
- GitHub Issues: Report bugs or request features
- GitHub Discussions: Ask questions and share ideas
- Pull Requests: Contribute code and documentation

---

## Next Steps

1. **Create Development Tracker Project** (30 minutes)
   - Follow Step 1 to create project in GitHub
   
2. **Create First 10 Issues** (1 hour)
   - Start with Priority 1 issues from Quick Start section
   - Use issue templates from Step 2
   
3. **Invite Team Members** (15 minutes)
   - Add collaborators with appropriate permissions
   
4. **Plan First Sprint** (30 minutes)
   - Select 5-10 issues for Sprint 1
   - Move to ✍️ In Progress column
   - Set sprint end date (2 weeks)
   
5. **Start Development!** 🚀
   - Begin working on in-progress issues
   - Update project daily
   - Hold standup sync (daily or 2-3x/week)

---

## Pro Tips

**For Effective Project Management:**
- 🏷️ Use consistent labeling (component, priority, effort)
- 📝 Keep issue descriptions clear and actionable
- 🔗 Link related issues with keywords: "Closes #123", "Related to #456"
- 📊 Review project board daily to keep it current
- 🎯 Limit work in progress (WIP) to avoid context switching
- ✅ Close issues promptly when complete
- 🔄 Regular retrospectives to improve process

**For Better Collaboration:**
- 💬 Comment on issues for discussions
- 👀 Request reviews for quality checks
- 🎉 Celebrate wins and completed milestones
- 📣 Share progress updates in GitHub Discussions
- 🤝 Help unblock teammates
- 📚 Document learnings in wiki or docs

---

**Document Version:** 1.0  
**Last Updated:** February 5, 2026  
**Maintained By:** AI Delivery Methodology Team
