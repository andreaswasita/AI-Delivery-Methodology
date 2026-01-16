"""
Methodology Phases Knowledge Module for AI Delivery Agent

This module contains comprehensive information about all 9 phases of the
AI Delivery Methodology, including objectives, criteria, checklists, and deliverables.
"""

from dataclasses import dataclass, field
from typing import List, Dict
from enum import Enum


class PhaseType(Enum):
    """Delivery methodology phases"""
    PRE_SALES_DISCOVERY = "Pre-sales & Discovery"
    MOBILISE = "Mobilise"
    HACKATHONS = "Hackathons (Prototype)"
    SETUP_PLATFORM = "Setup Platform"
    BUILD = "Build"
    INTEGRATE = "Integrate"
    TEST_EVALUATE = "Test & Evaluate"
    PREPARE_DEPLOY = "Prepare & Deploy"
    OPERATE_CARE = "Operate & Care"


@dataclass
class PhaseInfo:
    """Comprehensive phase information"""
    name: str
    phase_number: int
    purpose: str
    duration: str
    key_objectives: List[str]
    success_criteria: List[str]
    deliverables: List[str]
    exit_criteria: List[str]
    key_activities: List[str]
    key_roles: List[str]
    templates: List[str] = field(default_factory=list)
    guides: List[str] = field(default_factory=list)
    checklists: List[str] = field(default_factory=list)


# Phase 0: Pre-sales & Discovery
PRESALES_DISCOVERY = PhaseInfo(
    name="Pre-sales & Discovery",
    phase_number=0,
    purpose="Qualify opportunities, understand business context, identify root causes, and validate technical feasibility",
    duration="2-4 weeks",
    key_objectives=[
        "Qualify the opportunity and assess business readiness",
        "Understand business problem and identify root causes (Five Whys)",
        "Assess data availability and quality",
        "Validate technical feasibility",
        "Define initial use cases and prioritize",
        "Establish business case and ROI",
        "Identify risks and constraints"
    ],
    success_criteria=[
        "Business requirements documented and approved by stakeholders",
        "At least one use case with clear business value identified",
        "Data sufficiency confirmed (≥7/10 data readiness score)",
        "Technical feasibility validated (architecture feasible, no blocking technical issues)",
        "Risks identified and manageable (no high/critical unmitigatable risks)",
        "Executive sponsorship confirmed",
        "Steering committee approval to proceed"
    ],
    deliverables=[
        "Opportunity Qualification Report (Pre-sales)",
        "Business Envisioning Workshop Output (Use cases, prioritization)",
        "Business Requirements Document (BRD)",
        "Data Assessment Report",
        "Solution Architecture Document",
        "ML Approach Document",
        "Privacy & Compliance Assessment (GDPR/DPIA)",
        "Initial Business Case",
        "Discovery Report with recommendations"
    ],
    exit_criteria=[
        "Business requirements documented and approved",
        "Use case with clear business value identified",
        "Data readiness score ≥7/10",
        "Technical feasibility validated",
        "No blocking risks",
        "Executive sponsorship confirmed"
    ],
    key_activities=[
        "Stakeholder interviews and workshops",
        "Business Envisioning Workshop",
        "Five Whys root cause analysis",
        "Data discovery and assessment",
        "Technical architecture design",
        "ML approach evaluation",
        "Privacy and compliance review",
        "Business case development",
        "Risk assessment"
    ],
    key_roles=[
        "Executive Sponsor",
        "Business Owner",
        "AI/ML Lead",
        "Solution Architect",
        "Data Scientist",
        "Business Analyst",
        "Data Engineer"
    ],
    templates=[
        "11-presales-qualification.md",
        "09-business-requirements-document.md",
        "10-data-assessment-report.md",
        "14-business-envisioning-use-case-template.md"
    ],
    guides=[
        "presales-discovery-activities-for-presentations.md",
        "business-envisioning-workshop-guide.md",
        "solution-envisioning-workshop-guide.md"
    ],
    checklists=[
        "discovery-checklist.md",
        "business-envisioning-workshop-checklist.md"
    ]
)

# Phase 1: Mobilise
MOBILISE = PhaseInfo(
    name="Mobilise",
    phase_number=1,
    purpose="Establish project foundation, governance, team, and baseline",
    duration="2-3 weeks",
    key_objectives=[
        "Establish project governance structure",
        "Assemble and onboard project team",
        "Create project charter and baseline",
        "Define success criteria and KPIs",
        "Set up project infrastructure",
        "Establish communication plan",
        "Create risk register and mitigation plans"
    ],
    success_criteria=[
        "Project Charter approved",
        "Budget approved",
        "Team assembled and onboarded",
        "Governance established",
        "Risks identified and mitigation plans in place"
    ],
    deliverables=[
        "Project Charter",
        "Business Case (refined)",
        "RACI Matrix",
        "Project Plan & Roadmap",
        "Risk Register",
        "Communication Plan",
        "Success Criteria & KPIs",
        "Stakeholder Analysis",
        "Team onboarding materials"
    ],
    exit_criteria=[
        "Project Charter signed by Executive Sponsor and key stakeholders",
        "Budget formally approved",
        "Full project team assigned and onboarded",
        "Governance structure established (steering committee, working groups)",
        "Success criteria and KPIs baselined and agreed",
        "Risk register with 10+ identified risks and mitigation plans"
    ],
    key_activities=[
        "Project Charter creation",
        "Team assembly and onboarding",
        "Governance framework setup",
        "RACI matrix definition",
        "Project planning and roadmap",
        "Risk identification and planning",
        "Communication plan development",
        "KPI baseline establishment"
    ],
    key_roles=[
        "Executive Sponsor",
        "Project Manager",
        "Business Owner",
        "AI/ML Lead",
        "Change Manager",
        "Steering Committee"
    ],
    templates=[
        "01-project-charter.md",
        "02-business-case.md",
        "03-raci-matrix.md",
        "04-project-plan-roadmap.md",
        "05-risk-register.md",
        "06-communication-plan.md",
        "07-success-criteria-kpis.md",
        "08-stakeholder-analysis.md"
    ],
    guides=[
        "mobilisation-complete-guide.md"
    ],
    checklists=[
        "mobilisation-checklist.md"
    ]
)

# Phase 2: Hackathons (Prototype)
HACKATHONS = PhaseInfo(
    name="Hackathons (Prototype)",
    phase_number=2,
    purpose="Rapid validation, proof of concepts, fail fast learning, and technical risk mitigation",
    duration="2-4 weeks",
    key_objectives=[
        "Validate AI/ML approach with real data",
        "Build working prototype demonstrating core capability",
        "Test technical feasibility",
        "Assess data quality and model performance",
        "Identify technical risks early",
        "Get stakeholder feedback",
        "Refine requirements and scope"
    ],
    success_criteria=[
        "Working prototype demonstrates core AI capability",
        "Baseline model achieves >70% of target accuracy",
        "Stakeholder demo successful with positive feedback",
        "Technical architecture validated",
        "Data pipeline proven",
        "No blocking technical risks",
        "Go/No-Go decision: PROCEED to Build"
    ],
    deliverables=[
        "Working prototype",
        "Prototype demo and presentation",
        "Model performance report",
        "Data quality assessment",
        "Technical architecture validation",
        "Lessons learned document",
        "Refined requirements",
        "Go/No-Go recommendation"
    ],
    exit_criteria=[
        "Prototype demonstrates core AI/ML capability",
        "Model performance acceptable (>70% of target)",
        "Stakeholder demo completed with positive feedback",
        "Technical risks identified and mitigated",
        "Data quality sufficient for production",
        "Go/No-Go decision made"
    ],
    key_activities=[
        "Rapid prototyping",
        "Data exploration and preprocessing",
        "Model experimentation",
        "Architecture validation",
        "Stakeholder demos",
        "Technical risk assessment",
        "Lessons learned capture"
    ],
    key_roles=[
        "AI/ML Lead",
        "Data Scientists",
        "Data Engineer",
        "Solution Architect",
        "Business Owner"
    ],
    guides=[
        "hackathons-complete-guide.md"
    ],
    checklists=[
        "hackathons-prototype-checklist.md"
    ]
)

# Phase 3: Setup Platform
SETUP_PLATFORM = PhaseInfo(
    name="Setup Platform",
    phase_number=3,
    purpose="Establish infrastructure, MLOps, security, and compliance foundations for production",
    duration="3-4 weeks",
    key_objectives=[
        "Set up production-ready infrastructure",
        "Implement MLOps pipelines (CI/CD)",
        "Configure security and access controls",
        "Establish data pipelines",
        "Set up monitoring and logging",
        "Implement model training and deployment pipelines",
        "Ensure compliance and governance"
    ],
    success_criteria=[
        "All environments (DEV, TEST, PROD) operational",
        "MLOps pipelines working (train, deploy, monitor)",
        "Security controls implemented and validated",
        "Data pipelines operational",
        "Monitoring and alerting configured",
        "Compliance requirements met",
        "Platform ready for development"
    ],
    deliverables=[
        "Infrastructure deployment (Azure/AWS resources)",
        "MLOps pipelines (CI/CD)",
        "Monitoring dashboards",
        "Security configuration",
        "Data pipelines",
        "Infrastructure documentation",
        "Operations runbooks",
        "Platform validation report"
    ],
    exit_criteria=[
        "All environments provisioned and validated",
        "MLOps pipelines tested end-to-end",
        "Security scan passed (no critical vulnerabilities)",
        "Monitoring operational",
        "Development team has access",
        "Platform meets performance requirements"
    ],
    key_activities=[
        "Infrastructure provisioning",
        "MLOps pipeline development",
        "Security implementation",
        "Monitoring setup",
        "Data pipeline development",
        "Documentation creation",
        "Platform testing"
    ],
    key_roles=[
        "Solution Architect",
        "DevOps/MLOps Engineer",
        "Data Engineer",
        "Security Engineer",
        "AI/ML Lead"
    ],
    guides=[
        "setup-platform-complete-guide.md",
        "mlops-devops-complete-guide.md"
    ],
    checklists=[
        "setup-platform-checklist.md"
    ]
)

# Phase 4: Build
BUILD = PhaseInfo(
    name="Build",
    phase_number=4,
    purpose="Agile development of production-quality AI solution with continuous stakeholder engagement",
    duration="8-12 weeks (4-6 sprints)",
    key_objectives=[
        "Develop all planned features and functionality",
        "Build production-quality ML models",
        "Implement user interfaces and APIs",
        "Conduct continuous testing (unit, integration)",
        "Create comprehensive documentation",
        "Maintain stakeholder engagement",
        "Ensure code quality and standards"
    ],
    success_criteria=[
        "All MVP features complete and tested",
        "Code quality standards met (test coverage >80%, no critical issues)",
        "Security requirements met (no high/critical vulnerabilities)",
        "Performance requirements met (latency, throughput targets)",
        "Documentation complete (user, admin, technical)",
        "Training materials ready",
        "Integration testing passed",
        "Demo to stakeholders successful",
        "Steering committee approval to proceed"
    ],
    deliverables=[
        "Working application (all features)",
        "ML models (trained and validated)",
        "APIs and integrations",
        "User interface",
        "Unit and integration tests",
        "Code repository",
        "Technical documentation",
        "User documentation",
        "Training materials",
        "Sprint reports and demos"
    ],
    exit_criteria=[
        "All MVP features complete",
        "Code quality >80% coverage",
        "Security scan passed",
        "Performance targets met",
        "Documentation complete",
        "Stakeholder demo successful"
    ],
    key_activities=[
        "Sprint planning and execution",
        "Feature development",
        "ML model development",
        "Continuous testing",
        "Code reviews",
        "Documentation writing",
        "Sprint demos",
        "Stakeholder engagement"
    ],
    key_roles=[
        "Product Owner",
        "Scrum Master",
        "Software Engineers",
        "Data Scientists",
        "QA Engineer",
        "UX Designer",
        "Technical Writer"
    ],
    guides=[
        "build-phase-complete-guide.md",
        "story-points-estimation-guide.md"
    ],
    checklists=[
        "build-phase-checklist.md"
    ]
)

# Phase 5: Integrate
INTEGRATE = PhaseInfo(
    name="Integrate",
    phase_number=5,
    purpose="System integration, data pipeline deployment, and end-to-end workflow validation",
    duration="2-4 weeks",
    key_objectives=[
        "Integrate AI solution with enterprise systems",
        "Deploy data pipelines to production",
        "Implement API integrations",
        "Validate end-to-end workflows",
        "Conduct integration testing",
        "Ensure data synchronization",
        "Verify system interoperability"
    ],
    success_criteria=[
        "All planned integrations completed and operational",
        "Data synchronization working with <1% error rate",
        "Integration testing passed (>95% success rate)",
        "End-to-end workflows validated",
        "Performance SLAs met",
        "Zero critical integration issues"
    ],
    deliverables=[
        "Integrated system",
        "API documentation",
        "Integration test results",
        "Data flow diagrams",
        "Integration documentation",
        "Performance test results",
        "Integration validation report"
    ],
    exit_criteria=[
        "All integrations working",
        "Integration tests passed >95%",
        "Data synchronization validated",
        "Performance acceptable",
        "No critical issues"
    ],
    key_activities=[
        "System integration",
        "API development and testing",
        "Data pipeline deployment",
        "Integration testing",
        "Performance testing",
        "Issue resolution"
    ],
    key_roles=[
        "Integration Engineer",
        "Data Engineer",
        "Solution Architect",
        "QA Engineer",
        "DevOps Engineer"
    ],
    guides=[
        "integrate-phase-complete-guide.md"
    ],
    checklists=[
        "integrate-phase-checklist.md"
    ]
)

# Phase 6: Test & Evaluate
TEST_EVALUATE = PhaseInfo(
    name="Test & Evaluate",
    phase_number=6,
    purpose="Comprehensive QA, bias testing, performance validation, and UAT sign-off",
    duration="4-6 weeks",
    key_objectives=[
        "Execute comprehensive test plan",
        "Conduct User Acceptance Testing (UAT)",
        "Validate ML model performance",
        "Perform security and penetration testing",
        "Execute performance and load testing",
        "Test disaster recovery procedures",
        "Resolve all critical defects",
        "Obtain UAT sign-off"
    ],
    success_criteria=[
        "All test cases executed with >95% pass rate",
        "UAT completed with sign-off from business",
        "Model performance validated on test data",
        "Security testing passed",
        "Performance/load testing passed",
        "All critical and high priority defects resolved",
        "No open P1/P2 defects",
        "Go-live readiness score >85%"
    ],
    deliverables=[
        "Comprehensive test plan",
        "Test cases (functional, integration, performance, security)",
        "UAT results with sign-off",
        "Performance test results",
        "Security test results (penetration test report)",
        "Model validation report",
        "Defect log with resolution status",
        "Test summary report",
        "Go-live readiness assessment"
    ],
    exit_criteria=[
        "UAT sign-off obtained",
        "All critical/high defects resolved",
        "Performance requirements met",
        "Security requirements met",
        "Model performance meets criteria",
        "Integration testing passed >95%",
        "Disaster recovery tested",
        "Go-live readiness >85%"
    ],
    key_activities=[
        "Test execution (functional, integration, system)",
        "User Acceptance Testing (UAT)",
        "Performance testing",
        "Security testing",
        "Model validation",
        "Defect management",
        "Regression testing",
        "Go-live readiness assessment"
    ],
    key_roles=[
        "QA Lead",
        "Test Engineers",
        "Business Users",
        "Security Engineer",
        "Performance Engineer",
        "Data Scientists"
    ],
    guides=[
        "test-evaluate-phase-complete-guide.md"
    ],
    checklists=[
        "test-evaluate-phase-checklist.md"
    ]
)

# Phase 7: Prepare & Deploy
PREPARE_DEPLOY = PhaseInfo(
    name="Prepare & Deploy",
    phase_number=7,
    purpose="Production deployment, training delivery, change management, and successful go-live",
    duration="2-4 weeks",
    key_objectives=[
        "Deploy solution to production",
        "Deliver user training",
        "Execute change management activities",
        "Establish support infrastructure",
        "Conduct hypercare operations",
        "Monitor system performance",
        "Ensure smooth transition to operations"
    ],
    success_criteria=[
        "Production deployment successful",
        "User training >90% complete",
        "User adoption >80%",
        "System uptime >99%",
        "User satisfaction >4.0/5",
        "No critical open issues",
        "Hypercare completed successfully",
        "Transition to BAU approved"
    ],
    deliverables=[
        "Production deployment",
        "Deployment plan and runbook",
        "Training delivered (records, certificates)",
        "Training materials (guides, videos, FAQs)",
        "User accounts provisioned",
        "Support infrastructure (helpdesk, ticketing)",
        "Hypercare plan and schedule",
        "Monitoring dashboards operational",
        "Go-live communication",
        "Deployment summary report"
    ],
    exit_criteria=[
        "Application deployed to production",
        "Smoke testing passed",
        "Training completion >90%",
        "Support infrastructure operational",
        "Hypercare period completed (30 days)",
        "System stability demonstrated",
        "Transition to Operate & Care approved"
    ],
    key_activities=[
        "Production deployment",
        "User training delivery",
        "Change management execution",
        "Support setup",
        "Hypercare operations",
        "Issue triage and resolution",
        "Performance monitoring",
        "User adoption tracking"
    ],
    key_roles=[
        "Deployment Lead",
        "Training Lead",
        "Change Manager",
        "Support Manager",
        "Operations Team",
        "Business Users"
    ],
    guides=[
        "prepare-deploy-phase-complete-guide.md"
    ],
    checklists=[
        "prepare-deploy-phase-checklist.md"
    ]
)

# Phase 8: Operate & Care
OPERATE_CARE = PhaseInfo(
    name="Operate & Care",
    phase_number=8,
    purpose="Monitoring, optimization, continuous improvement, and value realization",
    duration="Ongoing",
    key_objectives=[
        "Monitor system performance and health",
        "Maintain ML model performance",
        "Provide ongoing support",
        "Track business value realization",
        "Implement continuous improvements",
        "Manage incidents and changes",
        "Ensure compliance and security",
        "Optimize costs and performance"
    ],
    success_criteria=[
        "System uptime >99.9% (per SLA)",
        "Incident resolution within SLA (>95%)",
        "Model accuracy maintained (>target threshold)",
        "User adoption >target (80% active users)",
        "User satisfaction >4.0/5",
        "Business KPIs achieved (ROI, cost savings)",
        "Security incidents <target (zero critical)",
        "Cost within budget (±10%)",
        "Continuous value delivery"
    ],
    deliverables=[
        "Monitoring dashboards",
        "Performance reports",
        "Incident reports",
        "Model retraining schedule",
        "Optimization recommendations",
        "Value realization reports",
        "Compliance reports",
        "Enhancement backlog"
    ],
    exit_criteria=[
        "Ongoing - measured by success criteria",
        "Continuous monitoring and improvement"
    ],
    key_activities=[
        "Performance monitoring",
        "Incident management",
        "Model monitoring and retraining",
        "User support",
        "Security monitoring",
        "Cost optimization",
        "Value tracking",
        "Enhancement planning",
        "Compliance auditing"
    ],
    key_roles=[
        "Operations Manager",
        "Support Team",
        "ML Engineers",
        "DevOps Engineers",
        "Business Analysts",
        "Security Team"
    ],
    guides=[
        "operate-care-phase-complete-guide.md",
        "ai-model-risk-management-guide.md"
    ],
    checklists=[
        "operate-care-phase-checklist.md"
    ]
)


# Phase registry
PHASES = {
    PhaseType.PRE_SALES_DISCOVERY: PRESALES_DISCOVERY,
    PhaseType.MOBILISE: MOBILISE,
    PhaseType.HACKATHONS: HACKATHONS,
    PhaseType.SETUP_PLATFORM: SETUP_PLATFORM,
    PhaseType.BUILD: BUILD,
    PhaseType.INTEGRATE: INTEGRATE,
    PhaseType.TEST_EVALUATE: TEST_EVALUATE,
    PhaseType.PREPARE_DEPLOY: PREPARE_DEPLOY,
    PhaseType.OPERATE_CARE: OPERATE_CARE
}


def get_phase_info(phase_type: PhaseType) -> PhaseInfo:
    """Get detailed information about a specific phase"""
    return PHASES[phase_type]


def get_all_phases() -> Dict[PhaseType, PhaseInfo]:
    """Get information about all phases"""
    return PHASES


def get_phase_by_number(phase_number: int) -> PhaseInfo:
    """Get phase by number (0-8)"""
    for phase_info in PHASES.values():
        if phase_info.phase_number == phase_number:
            return phase_info
    raise ValueError(f"Invalid phase number: {phase_number}")


def get_phase_summary() -> str:
    """Get a summary of all phases"""
    summary = ["AI DELIVERY METHODOLOGY - PHASES OVERVIEW", "=" * 80, ""]
    
    for phase_type in PhaseType:
        phase = PHASES[phase_type]
        summary.append(f"Phase {phase.phase_number}: {phase.name}")
        summary.append(f"Duration: {phase.duration}")
        summary.append(f"Purpose: {phase.purpose}")
        summary.append("")
    
    return "\n".join(summary)


def display_phase_details(phase_type: PhaseType) -> str:
    """Display detailed information about a phase"""
    phase = PHASES[phase_type]
    
    output = [
        "=" * 80,
        f"PHASE {phase.phase_number}: {phase.name.upper()}",
        "=" * 80,
        "",
        f"Duration: {phase.duration}",
        f"Purpose: {phase.purpose}",
        "",
        "KEY OBJECTIVES:",
        *[f"  • {obj}" for obj in phase.key_objectives],
        "",
        "SUCCESS CRITERIA:",
        *[f"  ✓ {criteria}" for criteria in phase.success_criteria],
        "",
        "KEY DELIVERABLES:",
        *[f"  📄 {deliverable}" for deliverable in phase.deliverables],
        "",
        "EXIT CRITERIA:",
        *[f"  ⚡ {criteria}" for criteria in phase.exit_criteria],
        "",
        "KEY ACTIVITIES:",
        *[f"  → {activity}" for activity in phase.key_activities],
        "",
        "KEY ROLES:",
        *[f"  👤 {role}" for role in phase.key_roles],
        ""
    ]
    
    if phase.templates:
        output.extend([
            "TEMPLATES:",
            *[f"  📋 {template}" for template in phase.templates],
            ""
        ])
    
    if phase.guides:
        output.extend([
            "GUIDES:",
            *[f"  📖 {guide}" for guide in phase.guides],
            ""
        ])
    
    if phase.checklists:
        output.extend([
            "CHECKLISTS:",
            *[f"  ✅ {checklist}" for checklist in phase.checklists],
            ""
        ])
    
    return "\n".join(output)


if __name__ == "__main__":
    # Example usage
    print(get_phase_summary())
    print("\n")
    print(display_phase_details(PhaseType.BUILD))
