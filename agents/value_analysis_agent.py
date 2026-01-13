"""
Value Analysis Agent for AI Delivery Methodology

This agent assists the AI Delivery Methodology team in performing comprehensive
value analysis for AI projects, including:
- Business value assessment
- ROI calculation and financial analysis
- Use case prioritization
- Root cause analysis (Five Whys)
- Benefit quantification
- Risk-adjusted value scoring
"""

import json
import os
from datetime import datetime
from typing import Dict, List, Optional, Tuple
from dataclasses import dataclass, asdict, field
from enum import Enum


class ImpactLevel(Enum):
    """Business impact levels"""
    CRITICAL = 5
    HIGH = 4
    MEDIUM = 3
    LOW = 2
    MINIMAL = 1


class ValueCategory(Enum):
    """Categories of business value"""
    REVENUE_GROWTH = "Revenue Growth"
    COST_REDUCTION = "Cost Reduction"
    COST_AVOIDANCE = "Cost Avoidance"
    RISK_MITIGATION = "Risk Mitigation"
    EFFICIENCY_IMPROVEMENT = "Efficiency Improvement"
    CUSTOMER_EXPERIENCE = "Customer Experience"
    STRATEGIC_POSITIONING = "Strategic Positioning"


@dataclass
class FinancialBenefit:
    """Financial benefit structure"""
    category: ValueCategory
    description: str
    year_0: float = 0.0
    year_1: float = 0.0
    year_2: float = 0.0
    year_3: float = 0.0
    year_4: float = 0.0
    year_5: float = 0.0
    confidence_level: float = 0.85  # 0-1 scale
    
    @property
    def total(self) -> float:
        """Calculate total benefits over 5 years"""
        return sum([self.year_1, self.year_2, self.year_3, self.year_4, self.year_5])
    
    @property
    def risk_adjusted_total(self) -> float:
        """Calculate risk-adjusted total"""
        return self.total * self.confidence_level


@dataclass
class CostItem:
    """Cost item structure"""
    category: str
    description: str
    year_0: float = 0.0
    year_1: float = 0.0
    year_2: float = 0.0
    year_3: float = 0.0
    year_4: float = 0.0
    year_5: float = 0.0
    
    @property
    def total(self) -> float:
        """Calculate total costs"""
        return sum([self.year_0, self.year_1, self.year_2, self.year_3, self.year_4, self.year_5])


@dataclass
class UseCase:
    """AI Use Case structure"""
    id: str
    title: str
    description: str
    business_problem: str
    impact_level: ImpactLevel
    effort_estimate: int  # story points or person-days
    benefits: List[FinancialBenefit] = field(default_factory=list)
    root_causes: List[str] = field(default_factory=list)
    stakeholders: List[str] = field(default_factory=list)
    dependencies: List[str] = field(default_factory=list)
    
    @property
    def total_benefit(self) -> float:
        """Calculate total benefits across all benefit items"""
        return sum(b.total for b in self.benefits)
    
    @property
    def value_score(self) -> float:
        """Calculate value score (benefit / effort)"""
        if self.effort_estimate == 0:
            return 0
        return self.total_benefit / self.effort_estimate
    
    @property
    def priority_score(self) -> float:
        """Calculate priority score (value * impact)"""
        return self.value_score * self.impact_level.value


class ValueAnalysisAgent:
    """Agent for performing comprehensive value analysis"""
    
    def __init__(self, project_name: str):
        self.project_name = project_name
        self.use_cases: List[UseCase] = []
        self.costs: List[CostItem] = []
        self.discount_rate: float = 0.10  # 10% default
        
    def add_use_case(self, use_case: UseCase) -> None:
        """Add a use case to the analysis"""
        self.use_cases.append(use_case)
        print(f"✅ Added use case: {use_case.title}")
    
    def add_cost(self, cost: CostItem) -> None:
        """Add a cost item to the analysis"""
        self.costs.append(cost)
        print(f"✅ Added cost item: {cost.description}")
    
    def conduct_five_whys(self, problem_statement: str) -> List[str]:
        """
        Interactive Five Whys root cause analysis
        Returns list of answers leading to root cause
        """
        print("\n" + "="*70)
        print("🔍 FIVE WHYS ROOT CAUSE ANALYSIS")
        print("="*70)
        print(f"\nProblem Statement: {problem_statement}\n")
        
        whys = []
        current_answer = problem_statement
        
        for i in range(1, 6):
            print(f"\nQuestion {i}: Why {current_answer.lower()}?")
            answer = input("Answer: ").strip()
            
            if not answer:
                print("⚠️  Empty answer. Stopping analysis.")
                break
                
            whys.append(answer)
            current_answer = answer
            
            # Ask if they want to continue
            if i < 5:
                continue_analysis = input("\nContinue to next 'Why?' (y/n): ").strip().lower()
                if continue_analysis != 'y':
                    break
        
        print("\n" + "-"*70)
        print("ROOT CAUSE ANALYSIS COMPLETE")
        print("-"*70)
        print("\nRoot Cause Chain:")
        for i, why in enumerate(whys, 1):
            print(f"  {i}. {why}")
        
        if whys:
            print(f"\n🎯 Root Cause: {whys[-1]}")
        
        return whys
    
    def calculate_roi(self, total_benefits: float, total_costs: float) -> Dict:
        """Calculate ROI metrics"""
        net_benefit = total_benefits - total_costs
        roi_percentage = (net_benefit / total_costs * 100) if total_costs > 0 else 0
        
        return {
            'total_benefits': total_benefits,
            'total_costs': total_costs,
            'net_benefit': net_benefit,
            'roi_percentage': roi_percentage
        }
    
    def calculate_npv(self, cash_flows: List[float], discount_rate: Optional[float] = None) -> float:
        """
        Calculate Net Present Value
        cash_flows: [Year0, Year1, Year2, Year3, Year4, Year5]
        """
        if discount_rate is None:
            discount_rate = self.discount_rate
            
        npv = 0
        for year, cash_flow in enumerate(cash_flows):
            npv += cash_flow / ((1 + discount_rate) ** year)
        
        return npv
    
    def calculate_payback_period(self, initial_investment: float, annual_cash_flows: List[float]) -> Optional[float]:
        """Calculate payback period in years"""
        cumulative = -initial_investment
        
        for year, cash_flow in enumerate(annual_cash_flows, start=1):
            cumulative += cash_flow
            if cumulative >= 0:
                # Linear interpolation for fractional year
                previous_cumulative = cumulative - cash_flow
                fraction = abs(previous_cumulative) / cash_flow
                return year - 1 + fraction
        
        return None  # Never paid back
    
    def prioritize_use_cases(self) -> List[Tuple[UseCase, float, str]]:
        """
        Prioritize use cases based on value score, impact, and effort
        Returns: List of (use_case, priority_score, recommendation)
        """
        if not self.use_cases:
            return []
        
        prioritized = []
        for uc in self.use_cases:
            score = uc.priority_score
            
            # Determine recommendation
            if score > 50 and uc.impact_level.value >= 4:
                recommendation = "🚀 MUST DO - High value, high impact"
            elif score > 30:
                recommendation = "✅ SHOULD DO - Good value proposition"
            elif score > 15:
                recommendation = "⚠️  CONSIDER - Moderate value"
            else:
                recommendation = "❌ DEFER - Low value/high effort"
            
            prioritized.append((uc, score, recommendation))
        
        # Sort by priority score descending
        prioritized.sort(key=lambda x: x[1], reverse=True)
        return prioritized
    
    def generate_value_matrix(self) -> str:
        """Generate value vs effort matrix visualization"""
        if not self.use_cases:
            return "No use cases to analyze"
        
        matrix = "\n" + "="*70 + "\n"
        matrix += "VALUE vs EFFORT MATRIX\n"
        matrix += "="*70 + "\n\n"
        
        # Categorize use cases
        quick_wins = []      # High value, low effort
        strategic = []       # High value, high effort
        fill_ins = []        # Low value, low effort
        avoid = []           # Low value, high effort
        
        for uc in self.use_cases:
            value = uc.total_benefit
            effort = uc.effort_estimate
            
            # Determine thresholds (can be adjusted)
            high_value = value > 500000  # $500K
            high_effort = effort > 50    # story points/days
            
            if high_value and not high_effort:
                quick_wins.append(uc)
            elif high_value and high_effort:
                strategic.append(uc)
            elif not high_value and not high_effort:
                fill_ins.append(uc)
            else:
                avoid.append(uc)
        
        matrix += "🎯 QUICK WINS (High Value, Low Effort):\n"
        for uc in quick_wins:
            matrix += f"   • {uc.title} - Value: ${uc.total_benefit:,.0f}, Effort: {uc.effort_estimate}\n"
        
        matrix += "\n📈 STRATEGIC (High Value, High Effort):\n"
        for uc in strategic:
            matrix += f"   • {uc.title} - Value: ${uc.total_benefit:,.0f}, Effort: {uc.effort_estimate}\n"
        
        matrix += "\n⏳ FILL-INS (Low Value, Low Effort):\n"
        for uc in fill_ins:
            matrix += f"   • {uc.title} - Value: ${uc.total_benefit:,.0f}, Effort: {uc.effort_estimate}\n"
        
        matrix += "\n❌ AVOID (Low Value, High Effort):\n"
        for uc in avoid:
            matrix += f"   • {uc.title} - Value: ${uc.total_benefit:,.0f}, Effort: {uc.effort_estimate}\n"
        
        return matrix
    
    def generate_comprehensive_report(self) -> str:
        """Generate comprehensive value analysis report"""
        report = []
        report.append("="*80)
        report.append(f"VALUE ANALYSIS REPORT: {self.project_name}")
        report.append("="*80)
        report.append(f"Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        report.append("")
        
        # Executive Summary
        report.append("📊 EXECUTIVE SUMMARY")
        report.append("-"*80)
        
        total_benefits = sum(sum(b.total for b in uc.benefits) for uc in self.use_cases)
        total_costs = sum(c.total for c in self.costs)
        
        if total_costs > 0:
            roi_metrics = self.calculate_roi(total_benefits, total_costs)
            report.append(f"Total Expected Benefits (5-year): ${total_benefits:,.2f}")
            report.append(f"Total Investment Required: ${total_costs:,.2f}")
            report.append(f"Net Benefit: ${roi_metrics['net_benefit']:,.2f}")
            report.append(f"ROI: {roi_metrics['roi_percentage']:.1f}%")
            report.append("")
        
        # Use Case Summary
        report.append("🎯 USE CASE ANALYSIS")
        report.append("-"*80)
        report.append(f"Total Use Cases Analyzed: {len(self.use_cases)}")
        report.append("")
        
        # Prioritization
        prioritized = self.prioritize_use_cases()
        report.append("USE CASE PRIORITIZATION (by Value Score):")
        report.append("")
        
        for rank, (uc, score, recommendation) in enumerate(prioritized, 1):
            report.append(f"{rank}. {uc.title}")
            report.append(f"   Priority Score: {score:.1f}")
            report.append(f"   Impact: {uc.impact_level.name}")
            report.append(f"   Total Benefit: ${uc.total_benefit:,.0f}")
            report.append(f"   Effort: {uc.effort_estimate} points")
            report.append(f"   {recommendation}")
            report.append("")
        
        # Value Matrix
        report.append(self.generate_value_matrix())
        report.append("")
        
        # Financial Analysis
        report.append("💰 FINANCIAL ANALYSIS")
        report.append("-"*80)
        
        # Benefits breakdown by category
        benefits_by_category = {}
        for uc in self.use_cases:
            for benefit in uc.benefits:
                cat = benefit.category.value
                if cat not in benefits_by_category:
                    benefits_by_category[cat] = 0
                benefits_by_category[cat] += benefit.total
        
        report.append("Benefits by Category:")
        for category, value in sorted(benefits_by_category.items(), key=lambda x: x[1], reverse=True):
            percentage = (value / total_benefits * 100) if total_benefits > 0 else 0
            report.append(f"  • {category}: ${value:,.0f} ({percentage:.1f}%)")
        report.append("")
        
        # Costs breakdown
        if self.costs:
            report.append("Cost Breakdown:")
            costs_by_category = {}
            for cost in self.costs:
                if cost.category not in costs_by_category:
                    costs_by_category[cost.category] = 0
                costs_by_category[cost.category] += cost.total
            
            for category, value in sorted(costs_by_category.items(), key=lambda x: x[1], reverse=True):
                percentage = (value / total_costs * 100) if total_costs > 0 else 0
                report.append(f"  • {category}: ${value:,.0f} ({percentage:.1f}%)")
            report.append("")
        
        # Recommendations
        report.append("📋 RECOMMENDATIONS")
        report.append("-"*80)
        
        quick_wins = [uc for uc, score, rec in prioritized if "MUST DO" in rec or "QUICK WIN" in rec]
        if quick_wins:
            report.append("Immediate Actions (Phase 1):")
            for uc in quick_wins[:3]:  # Top 3
                report.append(f"  1. {uc.title}")
                report.append(f"     - Expected Value: ${uc.total_benefit:,.0f}")
                report.append(f"     - Estimated Effort: {uc.effort_estimate} points")
            report.append("")
        
        report.append("Risk Considerations:")
        report.append("  • Validate benefit assumptions with stakeholders")
        report.append("  • Pilot high-value use cases before full deployment")
        report.append("  • Monitor and track actual vs expected benefits")
        report.append("  • Adjust roadmap based on early results")
        report.append("")
        
        report.append("="*80)
        report.append("END OF REPORT")
        report.append("="*80)
        
        return "\n".join(report)
    
    def export_to_json(self, filepath: str) -> None:
        """Export analysis to JSON file"""
        data = {
            'project_name': self.project_name,
            'generated_date': datetime.now().isoformat(),
            'discount_rate': self.discount_rate,
            'use_cases': [
                {
                    'id': uc.id,
                    'title': uc.title,
                    'description': uc.description,
                    'business_problem': uc.business_problem,
                    'impact_level': uc.impact_level.name,
                    'effort_estimate': uc.effort_estimate,
                    'total_benefit': uc.total_benefit,
                    'value_score': uc.value_score,
                    'priority_score': uc.priority_score,
                    'benefits': [asdict(b) for b in uc.benefits],
                    'root_causes': uc.root_causes,
                    'stakeholders': uc.stakeholders,
                    'dependencies': uc.dependencies
                }
                for uc in self.use_cases
            ],
            'costs': [asdict(c) for c in self.costs]
        }
        
        with open(filepath, 'w') as f:
            json.dump(data, f, indent=2, default=str)
        
        print(f"✅ Exported analysis to {filepath}")
    
    def save_report(self, filepath: str) -> None:
        """Save comprehensive report to text file"""
        report = self.generate_comprehensive_report()
        
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(report)
        
        print(f"✅ Saved report to {filepath}")


# Interactive CLI Interface
def interactive_value_analysis():
    """Interactive command-line interface for value analysis"""
    print("\n" + "="*80)
    print("🎯 AI DELIVERY METHODOLOGY - VALUE ANALYSIS AGENT")
    print("="*80)
    print("\nWelcome! This agent will help you perform comprehensive value analysis")
    print("for your AI project initiatives.\n")
    
    # Get project name
    project_name = input("Enter project name: ").strip()
    if not project_name:
        project_name = "AI Project"
    
    agent = ValueAnalysisAgent(project_name)
    
    # Main menu
    while True:
        print("\n" + "-"*80)
        print("MAIN MENU")
        print("-"*80)
        print("1. Add Use Case")
        print("2. Conduct Five Whys Analysis")
        print("3. Add Cost Item")
        print("4. View Use Case Prioritization")
        print("5. Generate Value Matrix")
        print("6. Generate Comprehensive Report")
        print("7. Export Analysis (JSON)")
        print("8. Save Report (TXT)")
        print("9. Exit")
        print("-"*80)
        
        choice = input("\nSelect option (1-9): ").strip()
        
        if choice == "1":
            add_use_case_interactive(agent)
        elif choice == "2":
            problem = input("\nEnter problem statement: ").strip()
            if problem:
                agent.conduct_five_whys(problem)
        elif choice == "3":
            add_cost_interactive(agent)
        elif choice == "4":
            show_prioritization(agent)
        elif choice == "5":
            print(agent.generate_value_matrix())
        elif choice == "6":
            print("\n" + agent.generate_comprehensive_report())
        elif choice == "7":
            filename = input("Enter filename (e.g., analysis.json): ").strip()
            if filename:
                agent.export_to_json(filename)
        elif choice == "8":
            filename = input("Enter filename (e.g., report.txt): ").strip()
            if filename:
                agent.save_report(filename)
        elif choice == "9":
            print("\n✅ Thank you for using Value Analysis Agent!")
            break
        else:
            print("⚠️  Invalid option. Please try again.")


def add_use_case_interactive(agent: ValueAnalysisAgent):
    """Interactive use case addition"""
    print("\n" + "="*70)
    print("ADD NEW USE CASE")
    print("="*70)
    
    uc_id = input("Use Case ID (e.g., UC-001): ").strip()
    title = input("Title: ").strip()
    description = input("Description: ").strip()
    problem = input("Business Problem: ").strip()
    
    print("\nImpact Level:")
    print("  1. CRITICAL (5)")
    print("  2. HIGH (4)")
    print("  3. MEDIUM (3)")
    print("  4. LOW (2)")
    print("  5. MINIMAL (1)")
    impact_choice = input("Select (1-5): ").strip()
    impact_map = {"1": ImpactLevel.CRITICAL, "2": ImpactLevel.HIGH, 
                  "3": ImpactLevel.MEDIUM, "4": ImpactLevel.LOW, "5": ImpactLevel.MINIMAL}
    impact = impact_map.get(impact_choice, ImpactLevel.MEDIUM)
    
    effort = int(input("Effort Estimate (story points/days): ").strip() or "0")
    
    # Create use case
    use_case = UseCase(
        id=uc_id,
        title=title,
        description=description,
        business_problem=problem,
        impact_level=impact,
        effort_estimate=effort
    )
    
    # Add benefits
    add_benefits = input("\nAdd financial benefits? (y/n): ").strip().lower()
    if add_benefits == 'y':
        while True:
            print("\nBenefit Category:")
            for i, cat in enumerate(ValueCategory, 1):
                print(f"  {i}. {cat.value}")
            cat_choice = int(input("Select (1-7, 0 to stop): ").strip() or "0")
            if cat_choice == 0:
                break
            
            category = list(ValueCategory)[cat_choice - 1]
            desc = input("Benefit description: ").strip()
            y1 = float(input("Year 1 benefit ($): ").strip() or "0")
            y2 = float(input("Year 2 benefit ($): ").strip() or "0")
            y3 = float(input("Year 3 benefit ($): ").strip() or "0")
            y4 = float(input("Year 4 benefit ($): ").strip() or "0")
            y5 = float(input("Year 5 benefit ($): ").strip() or "0")
            confidence = float(input("Confidence level (0-1, default 0.85): ").strip() or "0.85")
            
            benefit = FinancialBenefit(
                category=category,
                description=desc,
                year_1=y1,
                year_2=y2,
                year_3=y3,
                year_4=y4,
                year_5=y5,
                confidence_level=confidence
            )
            use_case.benefits.append(benefit)
            print(f"✅ Added benefit: {desc}")
    
    agent.add_use_case(use_case)


def add_cost_interactive(agent: ValueAnalysisAgent):
    """Interactive cost addition"""
    print("\n" + "="*70)
    print("ADD COST ITEM")
    print("="*70)
    
    category = input("Cost Category (e.g., Development, Infrastructure): ").strip()
    description = input("Description: ").strip()
    
    y0 = float(input("Year 0 (initial) cost ($): ").strip() or "0")
    y1 = float(input("Year 1 cost ($): ").strip() or "0")
    y2 = float(input("Year 2 cost ($): ").strip() or "0")
    y3 = float(input("Year 3 cost ($): ").strip() or "0")
    y4 = float(input("Year 4 cost ($): ").strip() or "0")
    y5 = float(input("Year 5 cost ($): ").strip() or "0")
    
    cost = CostItem(
        category=category,
        description=description,
        year_0=y0,
        year_1=y1,
        year_2=y2,
        year_3=y3,
        year_4=y4,
        year_5=y5
    )
    
    agent.add_cost(cost)


def show_prioritization(agent: ValueAnalysisAgent):
    """Display use case prioritization"""
    print("\n" + "="*70)
    print("USE CASE PRIORITIZATION")
    print("="*70)
    
    prioritized = agent.prioritize_use_cases()
    
    if not prioritized:
        print("\n⚠️  No use cases to prioritize yet.")
        return
    
    print(f"\n{'Rank':<6} {'Use Case':<30} {'Priority':<12} {'Value':<15} {'Effort':<10}")
    print("-"*70)
    
    for rank, (uc, score, recommendation) in enumerate(prioritized, 1):
        print(f"{rank:<6} {uc.title[:28]:<30} {score:<12.1f} ${uc.total_benefit:<14,.0f} {uc.effort_estimate:<10}")
        print(f"       {recommendation}")
        print()


if __name__ == "__main__":
    # Run interactive mode
    interactive_value_analysis()
