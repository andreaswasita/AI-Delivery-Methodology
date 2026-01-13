# 🧮 AI Project Interactive Calculators

**Interactive web-based calculators for AI project planning and financial analysis**

Hosted on GitHub Pages with 100% client-side calculations - no data leaves your browser.

---

## 🌐 Live Calculators

**🚀 Access Now**: [https://andreaswasita.github.io/AI-Delivery-Methodology/calculators/](https://andreaswasita.github.io/AI-Delivery-Methodology/calculators/)

---

## 📊 Available Calculators

### 💰 ROI Calculator ⭐ **LIVE NOW**

**[Launch ROI Calculator →](https://andreaswasita.github.io/AI-Delivery-Methodology/calculators/roi-calculator.html)**

Calculate comprehensive return on investment for AI projects with professional financial metrics:

**Core Capabilities**:
- 💵 **Net Present Value (NPV)** - Time-value adjusted returns with customizable discount rates
- 📈 **ROI Percentage** - Return on investment calculation with interpretation
- ⏱️ **Payback Period** - Time to break even (months and years)
- 📊 **5-Year Cash Flow Projections** - Year-by-year benefit and cost analysis
- 🔄 **Benefit Growth Modeling** - Compound annual growth rate modeling
- 🎯 **Sensitivity Analysis** - Test best/base/worst case scenarios
- 📉 **Cumulative Cash Flow Tracking** - Visual breakeven analysis

**New Features** (January 2026):
- ✅ **Detailed Azure Cost Guidance** - Specific USD pricing for Azure services:
  - Compute (VMs/AKS): $50K-$200K/year
  - Storage (Blob/Data Lake): $5K-$30K/year
  - Azure OpenAI (GPT-4): $20K-$100K/year for 1M daily requests
  - Azure ML: $0-$50K depending on compute
  - Cognitive Services: $5K-$30K/year
- ✅ **Azure Pricing Calculator Integration** - Direct link to [Microsoft Azure Pricing Calculator](https://azure.microsoft.com/en-us/pricing/calculator)
- ✅ **Real-World Examples** - Pre-populated examples with calculations
- ✅ **Export Functionality** - Print to PDF or copy results to clipboard

**Use Cases**:
- 🎯 Building business cases for AI investments
- 👔 Executive approval and budget justification
- 📋 Comparing multiple AI initiatives
- 💼 Creating financial models for proposals
- 🤝 Client presentations and workshops

**How to Use**:
1. **Enter Initial Investment**: Development costs, data prep, change management
2. **Enter Ongoing Costs**: Infrastructure (Azure), maintenance, licenses
3. **Quantify Benefits**: Cost savings, revenue increase, risk reduction
4. **Set Parameters**: Growth rate, discount rate (10% recommended for AI), time horizon
5. **Review Results**: NPV, ROI%, payback period, 5-year projections
6. **Export**: Print to PDF or copy to clipboard for presentations

[📖 Complete ROI Calculator Guide →](../guides/engagement-modes-framework.md#how-to-use-the-roi-calculator)

---

### 📊 Use Case Prioritization Calculator 🔜 **Coming Soon**

Score and rank AI use cases using the 11-metric framework:
- **Business Value Metrics** (8 dimensions): Revenue impact, cost savings, strategic alignment, user adoption, scalability, customer experience, competitive advantage, innovation
- **Technical Feasibility** (3 dimensions): Data availability, technical complexity, time to value
- **2×2 Matrix Visualization**: Quick Wins, Strategic Bets, Fill-Ins, Time Sinks
- **Portfolio View**: Compare multiple use cases side-by-side
- **Export to Excel**: Download scoring matrix

**Current Version**: [Use Case Prioritization Matrix Template →](../templates/19-use-case-prioritization-matrix.md)

---

### 📈 Benefit Realization Tracker 🔜 **Coming Soon**

Track actual vs. projected benefits throughout project lifecycle:
- **KPI Dashboard**: Real-time tracking of business metrics
- **Variance Analysis**: Actual vs. projected with explanations
- **Trend Visualization**: Line charts showing benefit realization over time
- **Quarterly Reporting**: Automated reports for steering committees
- **Alert System**: Notifications when metrics deviate from targets

---

### 🎯 Executive Readiness Scorecard 🔜 **Coming Soon**

Assess organizational readiness across 5 dimensions:
- **Strategic Clarity** (15 points): Vision alignment, problem articulation
- **Executive Commitment** (10 points): Leadership engagement, resource commitment
- **Decision-Making Readiness** (10 points): AI understanding, decision pace
- **Risk Tolerance** (10 points): Experimentation comfort, ethics governance
- **Change Leadership** (10 points): Change management capability, track record

**55-Point Assessment** with automated scoring and gap analysis

**Current Version**: [Executive Readiness Assessment Template →](../templates/16-executive-readiness-assessment.md)

---

### 💰 Azure Cost Estimator 🔜 **Coming Soon**

Estimate Azure infrastructure costs for AI/ML projects:
- **Service-Specific Pricing**: Azure ML, OpenAI, Cognitive Services, Compute, Storage
- **Environment Breakdown**: Dev, Test, UAT, Production
- **Monthly & Annual Projections**: 5-year cost forecasting
- **Right-Sizing Recommendations**: Optimize resource allocation
- **Cost Optimization Tips**: FinOps best practices

**Temporary Solution**: Use [Microsoft Azure Pricing Calculator](https://azure.microsoft.com/en-us/pricing/calculator) for detailed estimates

---

### 🔍 Risk Heat Map Generator 🔜 **Coming Soon**

Visualize project risks on likelihood vs. impact matrix:
- **18 Pre-Defined Risks**: From shared risk library
- **Interactive Heat Map**: Drag-and-drop risk positioning
- **Mitigation Tracking**: Monitor mitigation status
- **Export to PowerPoint**: Board-ready visualizations

**Current Version**: [Risk Library with 18 Risks →](../templates/shared-components/risk-library.md)

---

### ⏱️ Effort Estimator 🔜 **Coming Soon**

Convert project scope into effort estimates:
- **Story Point Conversion**: Hours/days per story point
- **Phase-by-Phase Breakdown**: Discovery, Build, Test, Deploy
- **Team Velocity Adjustment**: Account for team experience
- **Confidence Intervals**: Best/likely/worst case estimates
- **Resource Loading**: Full-time equivalent (FTE) calculations

---

### 👥 Team Sizing Calculator 🔜 **Coming Soon**

Determine optimal team composition:
- **Role-Based Sizing**: PM, Architects, Data Scientists, ML Engineers, DevOps
- **Skill Level Recommendations**: Junior/Mid/Senior ratios
- **Budget Impact Analysis**: Cost per role and total team cost
- **Timeline Optimization**: Team size vs. project duration tradeoffs

---

## 🚀 Quick Start

### For End Users

**Option 1: Public Access (Recommended)**
1. Visit: [https://andreaswasita.github.io/AI-Delivery-Methodology/calculators/](https://andreaswasita.github.io/AI-Delivery-Methodology/calculators/)
2. Select the calculator you need
3. Enter your project details
4. Review results and interpretations
5. Print to PDF or copy to clipboard

**Option 2: Run Locally**
```bash
# Clone the repository
git clone https://github.com/andreaswasita/AI-Delivery-Methodology.git
cd AI-Delivery-Methodology/calculators

# Open in browser
start roi-calculator.html  # Windows
open roi-calculator.html   # macOS
xdg-open roi-calculator.html  # Linux
```

**Option 3: Deploy to Your Azure Tenant**
```powershell
# Deploy to Azure Static Web Apps
cd ../infrastructure/scripts
.\deploy-calculators.ps1

# Follow prompts to configure:
# - Resource group name
# - Static Web App name
# - Region (default: australiaeast)
# - Custom domain (optional)
```

[📖 See Azure Deployment Guide →](./DEPLOYMENT.md)

---

### For Contributors & Developers

**Local Development**:
```bash
# Clone the repository
git clone https://github.com/andreaswasita/AI-Delivery-Methodology.git
cd AI-Delivery-Methodology/calculators

# Make changes to HTML, CSS, or JavaScript files
# Test in browser (no build process required)

# Open index.html to test locally
```

**Project Structure**:
```
calculators/
├── index.html                    # Landing page with calculator index
├── roi-calculator.html           # ROI Calculator (Live)
├── use-case-prioritization.html  # Coming soon
├── benefit-tracker.html          # Coming soon
├── readiness-scorecard.html      # Coming soon
├── azure-cost-estimator.html     # Coming soon
├── risk-heat-map.html            # Coming soon
├── effort-estimator.html         # Coming soon
├── team-sizer.html               # Coming soon
├── css/
│   └── styles.css               # Shared Fluent Design styles
├── js/
│   ├── roi-calculator.js        # ROI calculation logic
│   └── [other calculators].js  # Future calculator scripts
├── DEPLOYMENT.md                # Azure deployment guide
├── GITHUB-PAGES-SETUP.md        # GitHub Pages setup guide
└── README.md                    # This file
```

**Development Guidelines**:
- ✅ Keep all calculations 100% client-side
- ✅ Use Vanilla JavaScript (no frameworks)
- ✅ Follow Microsoft Fluent Design principles
- ✅ Provide clear input labels and help text
- ✅ Show calculation methodology and formulas
- ✅ Include interpretation of results
- ✅ Add print and copy-to-clipboard functionality
- ✅ Ensure mobile responsiveness
- ✅ Test across browsers (Chrome, Edge, Firefox, Safari)
- ✅ Add examples with pre-populated values

**Submitting Changes**:
1. Fork the repository
2. Create a feature branch: `git checkout -b feature/new-calculator`
3. Make your changes and test thoroughly
4. Submit a pull request with:
   - Clear description of changes
   - Screenshots (if UI changes)
   - Test results across browsers
   - Example calculations demonstrating functionality

---

## 🔒 Privacy & Security

**Your Data Stays With You**

- 🔐 **100% Client-Side Processing**: All calculations run entirely in your browser using JavaScript
- 🚫 **No Data Transmission**: Nothing is sent to any server - ever
- 📊 **No Analytics**: No tracking, cookies, or telemetry
- 🔓 **Open Source**: Fully auditable code - inspect network traffic to verify
- ✅ **GDPR Compliant**: No personal data collected or processed
- 🛡️ **Enterprise Safe**: Safe to use with confidential financial data

**How It Works**:
1. You enter data into form fields
2. JavaScript runs calculations in your browser's memory
3. Results display on your screen
4. When you close the page, all data is gone (not stored anywhere)

**Verification**:
- Open browser Developer Tools (F12)
- Check Network tab - you'll see zero outgoing requests after page load
- All JavaScript source code is viewable in the browser

---

## 🛠️ Technology Stack

| Technology | Purpose | Why We Use It |
|-----------|---------|---------------|
| **HTML5** | Semantic markup and structure | Standards-compliant, accessible |
| **CSS3** | Responsive design and styling | Microsoft Fluent Design principles |
| **Vanilla JavaScript** | Calculations and interactivity | Fast, no dependencies, easy to audit |
| **GitHub Pages** | Free, reliable hosting | Zero infrastructure cost, automatic SSL |
| **Azure Static Web Apps** | Optional enterprise deployment | Custom domains, Azure AD integration |

**No Frameworks**: We deliberately avoid frameworks (React, Vue, etc.) to keep the codebase simple, auditable, and fast-loading.

**No Build Process**: Edit HTML/CSS/JS files and refresh - no webpack, npm, or compilation needed.

---

## 💡 Key Features

### User Experience
- ✅ **Responsive Design**: Works perfectly on desktop, tablet, and mobile
- ✅ **Real-Time Calculations**: Results update as you type
- ✅ **Print-Friendly**: Print results directly from browser (Ctrl+P)
- ✅ **Copy to Clipboard**: One-click copy for pasting into emails/docs
- ✅ **Professional UI**: Microsoft Fluent Design-inspired interface
- ✅ **No Installation**: Runs directly in any modern browser
- ✅ **Offline Capable**: Works without internet after initial load
- ✅ **Fast Loading**: < 100KB total size, loads in < 1 second

### Calculation Features
- ✅ **Detailed Methodology**: Shows formulas and calculation steps
- ✅ **Result Interpretation**: Explains what metrics mean (not just numbers)
- ✅ **Examples Included**: Pre-populated realistic scenarios
- ✅ **Sensitivity Analysis**: Test different scenarios (best/base/worst)
- ✅ **Multi-Year Projections**: 5-year forward-looking analysis
- ✅ **Professional Output**: Ready for executive presentations

### Integration
- ✅ **Azure Pricing Calculator Link**: Direct integration for cost estimation
- ✅ **Template References**: Links to methodology templates
- ✅ **Guide Integration**: Embedded in engagement mode framework
- ✅ **Export Compatibility**: Results format for business case templates

---

## 📚 Related Resources

### Methodology Templates
- [Business Case Template](../templates/02-business-case.md) - Use ROI calculator results in Section 5
- [Use Case Prioritization Matrix](../templates/19-use-case-prioritization-matrix.md) - 11-metric scoring framework
- [Success Criteria & KPIs](../templates/07-success-criteria-kpis.md) - Track benefits realization
- [Executive Decision Memo](../templates/15-executive-decision-memo.md) - Board-ready financial summary

### Comprehensive Guides
- [ROI & Financial Analysis Module](../templates/shared-components/roi-financial-analysis.md) - 500+ line financial framework
- [Engagement Modes Framework](../guides/engagement-modes-framework.md) - How to use ROI calculator in different scenarios
- [Business Envisioning Workshop Guide](../guides/business-envisioning-workshop-guide.md) - Use calculator during workshops

### External Resources
- [Microsoft Azure Pricing Calculator](https://azure.microsoft.com/en-us/pricing/calculator) - Detailed Azure cost estimation
- [NPV Calculator Guide](https://www.calculator.net/npv-calculator.html) - Understanding Net Present Value
- [IRR Calculation Guide](https://corporatefinanceinstitute.com/resources/knowledge/finance/irr-internal-rate-return/) - Internal Rate of Return explained

---

## 🤝 Contributing

**We Welcome Contributions!**

### How to Contribute

**Bug Reports**:
- Use GitHub Issues to report bugs
- Include browser version, OS, and steps to reproduce
- Screenshots are helpful

**Feature Requests**:
- Use GitHub Discussions for feature ideas
- Describe the use case and expected behavior
- Explain how it fits into AI project planning

**Code Contributions**:
1. Fork the repository
2. Create a feature branch: `git checkout -b feature/new-calculator`
3. Follow development guidelines (see above)
4. Test thoroughly across browsers
5. Submit a pull request with clear description

### Calculator Development Guidelines

**Required Features for New Calculators**:
- [ ] 100% client-side calculations (no server calls)
- [ ] Clear input labels with help text
- [ ] Show calculation methodology/formulas
- [ ] Provide result interpretation (not just numbers)
- [ ] Include realistic examples with pre-populated values
- [ ] Add print-to-PDF functionality
- [ ] Add copy-to-clipboard functionality
- [ ] Mobile-responsive design (test on phones/tablets)
- [ ] Cross-browser testing (Chrome, Edge, Firefox, Safari)
- [ ] Accessible (WCAG 2.1 Level AA compliance)
- [ ] Error handling for invalid inputs

**Code Quality**:
- Use semantic HTML5
- Follow existing CSS naming conventions
- Comment complex calculation logic
- Use clear variable names (e.g., `totalInitialInvestment`, not `tii`)
- Include JSDoc comments for functions
- Validate all inputs before calculations

**UI/UX Standards**:
- Follow Microsoft Fluent Design principles
- Use existing color scheme from styles.css
- Maintain consistent spacing and typography
- Provide immediate visual feedback (e.g., results update as you type)
- Include loading states for complex calculations
- Show helpful error messages (not just "Invalid input")

---

## 📦 Deployment Options

### Option 1: GitHub Pages (Free)
**Current Setup**: Calculators are already live at [andreaswasita.github.io](https://andreaswasita.github.io/AI-Delivery-Methodology/calculators/)

**Features**:
- ✅ Free hosting
- ✅ Automatic SSL (HTTPS)
- ✅ Global CDN
- ✅ Auto-deployment on git push

[📖 GitHub Pages Setup Guide →](./GITHUB-PAGES-SETUP.md)

### Option 2: Azure Static Web Apps
**For Enterprise Deployments**

**Benefits**:
- 🏢 Private deployment with Azure AD authentication
- 🌐 Custom domain with automatic SSL
- 📊 Application Insights integration
- 🔐 Enterprise security and compliance
- 🚀 Global CDN with edge locations
- 🔄 Staging environments for testing

**Pricing**: Free tier available ($0/month for small deployments)

[📖 Azure Deployment Guide →](./DEPLOYMENT.md)

### Option 3: Self-Hosted
**Run on Your Own Infrastructure**

```bash
# Clone and serve with any web server
git clone https://github.com/andreaswasita/AI-Delivery-Methodology.git
cd AI-Delivery-Methodology/calculators

# Examples:
python -m http.server 8000              # Python
npx http-server -p 8000                 # Node.js
php -S localhost:8000                   # PHP

# Access at http://localhost:8000
```

---

## 📝 Version History & Roadmap

### Released

| Version | Date | Calculator | Features |
|---------|------|-----------|----------|
| **1.0** | Jan 13, 2026 | ROI Calculator | NPV, ROI%, Payback, 5-year projections, Azure cost guidance, Azure Pricing Calculator integration |

### Roadmap

| Priority | Calculator | Target | Status |
|----------|-----------|--------|--------|
| **P0** | Use Case Prioritization | Q1 2026 | 🔄 In Planning |
| **P1** | Azure Cost Estimator | Q1 2026 | 🔄 In Planning |
| **P1** | Benefit Realization Tracker | Q2 2026 | 📋 Planned |
| **P2** | Executive Readiness Scorecard | Q2 2026 | 📋 Planned |
| **P2** | Risk Heat Map Generator | Q2 2026 | 📋 Planned |
| **P3** | Effort Estimator | Q3 2026 | 📋 Planned |
| **P3** | Team Sizing Calculator | Q3 2026 | 📋 Planned |

**Want to Help?** Contributions welcome! See Contributing section above.

---

## 📄 License

This methodology is based on Microsoft's AI Frontier best practices and is intended for use in delivering AI projects. All content is provided as-is for educational and professional use.

---

## 📞 Support & Contact

### Get Help
- **GitHub Issues**: [Report bugs or request features](https://github.com/andreaswasita/AI-Delivery-Methodology/issues)
- **GitHub Discussions**: [Ask questions or share ideas](https://github.com/andreaswasita/AI-Delivery-Methodology/discussions)
- **Documentation**: [Main methodology repository](https://github.com/andreaswasita/AI-Delivery-Methodology)

### Report Issues
When reporting issues, please include:
- Calculator name and version
- Browser and operating system
- Steps to reproduce
- Expected vs. actual behavior
- Screenshots (if applicable)

### Request Features
When requesting features, please describe:
- The use case and problem you're solving
- How it would integrate with existing calculators
- Expected inputs and outputs
- Priority and urgency

---

## 🙏 Acknowledgments

**Based on Real-World Experience**

These calculators are based on:
- 100+ enterprise AI projects delivered by Microsoft Consulting Services
- Financial formulas validated by Fortune 500 finance teams
- Best practices from Microsoft AI Frontier methodology
- Feedback from data scientists, project managers, and executives across industries

**Special Thanks**:
- Microsoft field delivery teams for methodology input
- Solution architects for technical validation
- Finance teams for ROI formula accuracy
- Client organizations for allowing us to learn from their projects

---

## ⭐ Show Your Support

If these calculators help your AI projects, please:
- ⭐ Star the repository on GitHub
- 🐛 Report bugs to help us improve
- 💡 Suggest new calculators or features
- 📢 Share with colleagues who might benefit
- 🤝 Contribute code or documentation improvements

---

**Last Updated**: January 13, 2026  
**Current Version**: 1.0 (ROI Calculator Released)  
**Total Calculators**: 1 live, 7 in development  
**Status**: ✅ Production-Ready

---

**🚀 [Launch ROI Calculator Now →](https://andreaswasita.github.io/AI-Delivery-Methodology/calculators/roi-calculator.html)**

**📖 [Back to Main Methodology →](../README.md)**
