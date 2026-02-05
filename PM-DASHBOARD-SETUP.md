# Live PM Dashboard - GitHub Projects Integration

## 🎯 Overview

The **Live PM Dashboard** connects directly to your GitHub Projects to display real-time project management metrics, eliminating the need for manual updates and providing instant visibility into sprint progress.

## ✨ Features

### Real-Time Metrics
- **Sprint Velocity** - Current sprint completion rate
- **Sprint Progress** - Percentage complete with remaining issues
- **Open Issues Count** - Total open issues across all milestones
- **Team Capacity** - Current team utilization

### Interactive Visualizations
- **Sprint Timeline** - Visual cards showing all sprints with progress bars
- **Burndown Chart** - Ideal vs actual sprint progress
- **Velocity Trend Chart** - Historical velocity across past sprints
- **Active Issues Table** - Top 10 open issues with status, priority, and story points

### Data Sources
- **GitHub Issues API** - All repository issues and pull requests
- **GitHub Milestones API** - Sprint tracking via milestones
- **GitHub Labels** - Story points and priorities from labels
- **GitHub Assignees** - Team member assignments

## 🚀 Quick Start

### Step 1: Create GitHub Personal Access Token

1. Go to [GitHub Settings > Developer Settings > Personal Access Tokens](https://github.com/settings/tokens/new)
2. Click **Generate new token (classic)**
3. Give it a name: `PM Dashboard Access`
4. Select scopes:
   - ✅ `repo` (Full control of private repositories)
   - ✅ `read:project` (Read access to projects)
   - ✅ `read:org` (Read org and team membership)
5. Click **Generate token**
6. **COPY THE TOKEN** - you won't see it again!

### Step 2: Set Up Milestones as Sprints

1. Go to your repository on GitHub
2. Navigate to **Issues** > **Milestones**
3. Create milestones for your sprints:
   - **Title:** Sprint 1, Sprint 2, etc.
   - **Due Date:** End of 2-week sprint
   - **Description:** Sprint goals
4. Assign issues to milestones as you plan sprints

### Step 3: Use Labels for Story Points and Priority

Add labels to your repository:

**Story Points:**
- `SP: 1`, `SP: 2`, `SP: 3`, `SP: 5`, `SP: 8`, `SP: 13`

**Priority:**
- `High` (red)
- `Medium` (yellow)
- `Low` (green)

Apply these labels to issues for tracking.

### Step 4: Connect the Dashboard

1. Open [pm-dashboard-live.html](pm-dashboard-live.html)
2. Fill in the connection form:
   - **GitHub Personal Access Token:** Paste your token
   - **Repository Owner:** Your username or organization (e.g., `andreaswasita`)
   - **Repository Name:** Your repo name (e.g., `AI-Delivery-Methodology`)
   - **Project Number:** 1 (or your project number from GitHub Projects URL)
3. Click **🔗 Connect to GitHub**
4. Dashboard loads with live data!

## 📊 Dashboard Sections

### 1. Key Metrics (Top Cards)
Four metric cards showing:
- Sprint velocity (issues completed in current sprint)
- Sprint progress percentage
- Total open issues
- Team capacity utilization

### 2. Sprint Timeline
Horizontal scrollable cards showing all milestones:
- Active sprints highlighted in blue
- Progress bars showing completion
- Due dates and issue counts
- Click milestone titles to open in GitHub

### 3. Sprint Burndown Chart
Line chart comparing:
- **Ideal burndown** (gray dashed line) - perfect linear progress
- **Actual progress** (blue line) - real team progress

### 4. Active Issues Table
Top 10 open issues with columns:
- Issue number and title (clickable to GitHub)
- Assignee
- Status badge
- Priority badge
- Story points

### 5. Team Velocity Trend
Bar chart showing completed issues per sprint over last 5 closed sprints.

## 🔄 Data Refresh

- **Automatic:** Dashboard loads fresh data on page load
- **Manual:** Click **🔄 Refresh** button in any section
- **Live:** Connect once, your token is saved in browser localStorage

## 🛡️ Security & Privacy

### Token Storage
- Your GitHub token is stored **only in your browser's localStorage**
- Never sent to any external servers
- Only used for direct GitHub API calls from your browser

### Data Access
- Dashboard only reads public repository data (if repo is public)
- For private repos, token needs `repo` scope
- No data is stored or transmitted to third parties

### Best Practices
- Use a token with minimal required scopes
- Revoke tokens you're not using
- Don't share your token with others
- Use different tokens for different tools

## 📐 GitHub Projects Structure

### Recommended Setup

```
Your Repository
├─ Issues
│  ├─ #1 - Setup development environment [SP: 3] [High]
│  ├─ #2 - Create user authentication [SP: 8] [Medium]
│  └─ #3 - Design database schema [SP: 5] [High]
├─ Milestones (Sprints)
│  ├─ Sprint 1 (Jan 1-14) - 5 issues, 3 closed
│  ├─ Sprint 2 (Jan 15-28) - 8 issues, 2 closed (active)
│  └─ Sprint 3 (Jan 29-Feb 11) - 6 issues, 0 closed (planned)
└─ Labels
   ├─ SP: 1, SP: 2, SP: 3, SP: 5, SP: 8, SP: 13
   ├─ High, Medium, Low
   └─ Bug, Feature, Enhancement
```

### Issue Example
```markdown
Title: Implement user authentication API
Labels: SP: 8, High, Feature
Milestone: Sprint 2
Assignee: @developer1

Description:
Create REST API endpoints for user authentication...
```

## 🎨 Customization

### Modify Story Point Label Format
Edit JavaScript line ~670:
```javascript
const storyPointLabel = issue.labels.find(l => 
  l.name.match(/^(SP|Points|Story Points):\s*\d+/i)
);
```

### Change Sprint Duration (for burndown)
Edit JavaScript line ~810:
```javascript
const days = 10; // Change to 14 for 2-week sprints
```

### Add Custom Priority Labels
Edit JavaScript line ~674:
```javascript
const priority = issue.labels.find(l => 
  ['critical', 'high', 'medium', 'low'].includes(l.name.toLowerCase())
);
```

## 🔧 Troubleshooting

### "Failed to connect to GitHub" Error
**Causes:**
- Invalid token
- Token lacks required scopes
- Repository owner/name typo
- Private repo without `repo` scope

**Solutions:**
1. Verify token has `repo` and `read:project` scopes
2. Check spelling of owner and repo name
3. Try with a public repository first
4. Generate a new token if old one expired

### "No sprints/milestones found"
**Cause:** Repository has no milestones created

**Solution:**
1. Go to your repo > Issues > Milestones
2. Create at least one milestone
3. Click 🔄 Refresh on dashboard

### Charts not showing
**Cause:** Not enough data (need at least 2 closed sprints for velocity chart)

**Solution:**
- Complete and close at least 2 milestones
- Ensure issues are assigned to milestones

### Story points showing as "-"
**Cause:** Issues don't have story point labels

**Solution:**
1. Create labels: `SP: 1`, `SP: 2`, `SP: 3`, `SP: 5`, `SP: 8`, `SP: 13`
2. Apply to issues
3. Refresh dashboard

## 📈 Best Practices

### 1. Consistent Labeling
- Use Fibonacci sequence for story points: 1, 2, 3, 5, 8, 13
- Always label priority: High, Medium, Low
- Tag issue types: Bug, Feature, Enhancement

### 2. Sprint Planning
- Create milestones 2-3 sprints ahead
- Set realistic due dates
- Review and close sprints promptly

### 3. Daily Updates
- Assign issues as team members start work
- Close issues immediately when done
- Update progress regularly for accurate burndown

### 4. Retrospectives
- Review velocity chart trends
- Analyze sprint completion rates
- Identify blockers from open issues

## 🔗 Integration with AI Methodology

The live dashboard complements the AI Delivery Methodology by:

1. **Sprint Planning** - Visualize capacity before planning poker
2. **Daily Standups** - Quick team progress check
3. **Mid-Sprint Check-ins** - Real-time burndown analysis
4. **Sprint Reviews** - Automatic metrics for demo
5. **Retrospectives** - Historical velocity data for improvement

## 📚 Resources

- [GitHub REST API Documentation](https://docs.github.com/en/rest)
- [GitHub Milestones Guide](https://docs.github.com/en/issues/using-labels-and-milestones-to-track-work/about-milestones)
- [Agile Sprint Planning Best Practices](guides/94-story-points-estimation-guide.md)

## 🆘 Support

For issues or questions:
1. Check [Troubleshooting](#-troubleshooting) section
2. Review your GitHub API token permissions
3. Ensure repository is accessible with your token
4. Try with a different repository to isolate issue

---

**Last Updated:** February 2026  
**Version:** 1.0  
**License:** MIT
