"""
Example Usage: Value Analysis Agent
Demonstrates how to use the agent programmatically
"""

from value_analysis_agent import (
    ValueAnalysisAgent, UseCase, FinancialBenefit, CostItem,
    ImpactLevel, ValueCategory
)


def example_financial_services_fraud_detection():
    """Example: Financial Services Fraud Detection Use Case"""
    
    print("\n" + "="*80)
    print("EXAMPLE: Financial Services - Fraud Detection System")
    print("="*80)
    
    # Create agent
    agent = ValueAnalysisAgent("Financial Services AI Initiative")
    
    # Create use case
    fraud_detection = UseCase(
        id="UC-001",
        title="Real-time Fraud Detection System",
        description="ML-powered fraud detection for credit card transactions",
        business_problem="$3.5M annual fraud losses, 2.1% false positive rate causing customer friction",
        impact_level=ImpactLevel.CRITICAL,
        effort_estimate=55,
        root_causes=[
            "Rule-based system cannot adapt to new fraud patterns",
            "No real-time risk scoring",
            "Manual review of all suspicious transactions (18 hours/day)",
            "False positives damage customer experience"
        ],
        stakeholders=["Chief Risk Officer", "Head of Fraud Prevention", "CIO", "CFO"]
    )
    
    # Add benefits
    fraud_detection.benefits = [
        FinancialBenefit(
            category=ValueCategory.COST_REDUCTION,
            description="Reduced fraud losses (85% detection improvement)",
            year_1=2000000,
            year_2=2400000,
            year_3=2700000,
            year_4=3000000,
            year_5=3300000,
            confidence_level=0.85
        ),
        FinancialBenefit(
            category=ValueCategory.COST_AVOIDANCE,
            description="Avoided regulatory fines and penalties",
            year_1=300000,
            year_2=350000,
            year_3=400000,
            year_4=450000,
            year_5=500000,
            confidence_level=0.75
        ),
        FinancialBenefit(
            category=ValueCategory.CUSTOMER_EXPERIENCE,
            description="Reduced false positives - customer retention",
            year_1=500000,
            year_2=600000,
            year_3=700000,
            year_4=750000,
            year_5=800000,
            confidence_level=0.70
        ),
        FinancialBenefit(
            category=ValueCategory.EFFICIENCY_IMPROVEMENT,
            description="Automated review process - labor savings",
            year_1=400000,
            year_2=420000,
            year_3=440000,
            year_4=460000,
            year_5=480000,
            confidence_level=0.90
        )
    ]
    
    agent.add_use_case(fraud_detection)
    
    # Add costs
    costs = [
        CostItem(
            category="Development",
            description="ML model development, integration, testing",
            year_0=800000,
            year_1=200000,
            year_2=0,
            year_3=0,
            year_4=0,
            year_5=0
        ),
        CostItem(
            category="Infrastructure",
            description="Azure ML, compute, storage",
            year_0=50000,
            year_1=180000,
            year_2=190000,
            year_3=200000,
            year_4=210000,
            year_5=220000
        ),
        CostItem(
            category="Operations",
            description="ML Ops team, monitoring, maintenance",
            year_0=0,
            year_1=150000,
            year_2=160000,
            year_3=170000,
            year_4=180000,
            year_5=190000
        ),
        CostItem(
            category="Training & Change Management",
            description="User training, process changes",
            year_0=100000,
            year_1=50000,
            year_2=0,
            year_3=0,
            year_4=0,
            year_5=0
        )
    ]
    
    for cost in costs:
        agent.add_cost(cost)
    
    # Generate report
    print("\n" + agent.generate_comprehensive_report())
    
    # Export
    agent.export_to_json("fraud_detection_analysis.json")
    agent.save_report("fraud_detection_report.txt")


def example_retail_demand_forecasting():
    """Example: Retail Demand Forecasting"""
    
    print("\n" + "="*80)
    print("EXAMPLE: Retail - AI-Powered Demand Forecasting")
    print("="*80)
    
    agent = ValueAnalysisAgent("Retail AI Transformation")
    
    # Use Case 1: Demand Forecasting
    demand_forecast = UseCase(
        id="UC-002",
        title="AI-Powered Demand Forecasting",
        description="ML forecasting for inventory optimization across 250 stores",
        business_problem="22% stockouts, $4.2M excess inventory carrying costs, 15% markdown losses",
        impact_level=ImpactLevel.HIGH,
        effort_estimate=34,
        root_causes=[
            "Historical averages don't account for trends, seasonality, events",
            "No integration of external signals (weather, events, social media)",
            "Manual Excel-based forecasting by 12 regional managers",
            "Lead times require 4-week forecasts but accuracy drops after 1 week"
        ],
        stakeholders=["VP Merchandising", "VP Operations", "Regional Managers", "CFO"]
    )
    
    demand_forecast.benefits = [
        FinancialBenefit(
            category=ValueCategory.COST_REDUCTION,
            description="Reduced inventory carrying costs (30% reduction)",
            year_1=500000,
            year_2=600000,
            year_3=650000,
            year_4=700000,
            year_5=750000,
            confidence_level=0.85
        ),
        FinancialBenefit(
            category=ValueCategory.REVENUE_GROWTH,
            description="Reduced stockouts - recovered lost sales",
            year_1=350000,
            year_2=400000,
            year_3=420000,
            year_4=450000,
            year_5=480000,
            confidence_level=0.75
        ),
        FinancialBenefit(
            category=ValueCategory.COST_AVOIDANCE,
            description="Reduced markdown/clearance losses",
            year_1=200000,
            year_2=240000,
            year_3=260000,
            year_4=280000,
            year_5=300000,
            confidence_level=0.80
        ),
        FinancialBenefit(
            category=ValueCategory.EFFICIENCY_IMPROVEMENT,
            description="Automated forecasting - labor time savings",
            year_1=180000,
            year_2=180000,
            year_3=180000,
            year_4=180000,
            year_5=180000,
            confidence_level=0.90
        )
    ]
    
    agent.add_use_case(demand_forecast)
    
    # Use Case 2: Personalized Recommendations
    recommendations = UseCase(
        id="UC-003",
        title="Personalized Product Recommendations",
        description="AI-driven product recommendations on website and mobile app",
        business_problem="3.2% conversion rate vs. 5.1% industry average, low cross-sell rate",
        impact_level=ImpactLevel.HIGH,
        effort_estimate=29,
        root_causes=[
            "Generic 'bestsellers' shown to all customers",
            "No personalization based on browse/purchase history",
            "Limited to same-category recommendations",
            "No real-time adaptation to session behavior"
        ],
        stakeholders=["VP E-commerce", "CMO", "Head of Digital", "CIO"]
    )
    
    recommendations.benefits = [
        FinancialBenefit(
            category=ValueCategory.REVENUE_GROWTH,
            description="Increased conversion rate (3.2% → 4.5%)",
            year_1=800000,
            year_2=950000,
            year_3=1100000,
            year_4=1250000,
            year_5=1400000,
            confidence_level=0.70
        ),
        FinancialBenefit(
            category=ValueCategory.REVENUE_GROWTH,
            description="Increased average order value (cross-sell)",
            year_1=400000,
            year_2=480000,
            year_3=550000,
            year_4=620000,
            year_5=700000,
            confidence_level=0.75
        ),
        FinancialBenefit(
            category=ValueCategory.CUSTOMER_EXPERIENCE,
            description="Improved customer lifetime value",
            year_1=250000,
            year_2=300000,
            year_3=350000,
            year_4=400000,
            year_5=450000,
            confidence_level=0.65
        )
    ]
    
    agent.add_use_case(recommendations)
    
    # Add costs for both use cases
    costs = [
        CostItem(
            category="Development",
            description="Development for both use cases",
            year_0=650000,
            year_1=150000,
            year_2=0,
            year_3=0,
            year_4=0,
            year_5=0
        ),
        CostItem(
            category="Infrastructure",
            description="Azure ML, compute, storage",
            year_0=40000,
            year_1=120000,
            year_2=130000,
            year_3=140000,
            year_4=150000,
            year_5=160000
        ),
        CostItem(
            category="Operations",
            description="Data science team, MLOps",
            year_0=0,
            year_1=200000,
            year_2=210000,
            year_3=220000,
            year_4=230000,
            year_5=240000
        )
    ]
    
    for cost in costs:
        agent.add_cost(cost)
    
    # Generate outputs
    print("\n" + agent.generate_comprehensive_report())
    agent.export_to_json("retail_ai_analysis.json")


def example_manufacturing_predictive_maintenance():
    """Example: Manufacturing Predictive Maintenance"""
    
    print("\n" + "="*80)
    print("EXAMPLE: Manufacturing - Predictive Maintenance")
    print("="*80)
    
    agent = ValueAnalysisAgent("Manufacturing AI Initiative")
    agent.discount_rate = 0.12  # Higher discount rate for manufacturing
    
    predictive_maintenance = UseCase(
        id="UC-004",
        title="Predictive Maintenance for Production Line",
        description="IoT + ML for predicting equipment failures",
        business_problem="$8M annual unplanned downtime costs, 18% OEE loss, safety incidents",
        impact_level=ImpactLevel.CRITICAL,
        effort_estimate=89,
        root_causes=[
            "Reactive maintenance after failures occur",
            "Fixed maintenance schedules don't match actual wear",
            "No sensor data for early failure detection",
            "12-48 hour lead time for replacement parts not in inventory"
        ],
        stakeholders=["VP Operations", "Plant Manager", "Maintenance Director", "COO"]
    )
    
    predictive_maintenance.benefits = [
        FinancialBenefit(
            category=ValueCategory.COST_REDUCTION,
            description="Reduced unplanned downtime (65% reduction)",
            year_1=2800000,
            year_2=3200000,
            year_3=3500000,
            year_4=3800000,
            year_5=4000000,
            confidence_level=0.80
        ),
        FinancialBenefit(
            category=ValueCategory.COST_REDUCTION,
            description="Optimized maintenance scheduling - labor savings",
            year_1=600000,
            year_2=650000,
            year_3=700000,
            year_4=750000,
            year_5=800000,
            confidence_level=0.85
        ),
        FinancialBenefit(
            category=ValueCategory.COST_AVOIDANCE,
            description="Prevented catastrophic equipment failures",
            year_1=400000,
            year_2=450000,
            year_3=500000,
            year_4=550000,
            year_5=600000,
            confidence_level=0.70
        ),
        FinancialBenefit(
            category=ValueCategory.RISK_MITIGATION,
            description="Reduced safety incidents and liability",
            year_1=200000,
            year_2=250000,
            year_3=300000,
            year_4=350000,
            year_5=400000,
            confidence_level=0.75
        ),
        FinancialBenefit(
            category=ValueCategory.EFFICIENCY_IMPROVEMENT,
            description="Improved OEE - additional production capacity",
            year_1=1200000,
            year_2=1400000,
            year_3=1600000,
            year_4=1800000,
            year_5=2000000,
            confidence_level=0.75
        )
    ]
    
    agent.add_use_case(predictive_maintenance)
    
    # Add costs
    costs = [
        CostItem(
            category="Development",
            description="ML models, IoT integration, dashboard development",
            year_0=1200000,
            year_1=300000,
            year_2=100000,
            year_3=0,
            year_4=0,
            year_5=0
        ),
        CostItem(
            category="IoT Hardware",
            description="Sensors, gateways, edge devices",
            year_0=800000,
            year_1=100000,
            year_2=100000,
            year_3=50000,
            year_4=50000,
            year_5=50000
        ),
        CostItem(
            category="Infrastructure",
            description="Azure IoT Hub, ML, Time Series Insights, storage",
            year_0=60000,
            year_1=240000,
            year_2=250000,
            year_3=260000,
            year_4=270000,
            year_5=280000
        ),
        CostItem(
            category="Operations",
            description="Data science, engineering, support team",
            year_0=0,
            year_1=300000,
            year_2=320000,
            year_3=340000,
            year_4=360000,
            year_5=380000
        )
    ]
    
    for cost in costs:
        agent.add_cost(cost)
    
    # Calculate NPV with custom discount rate
    total_benefits = sum(sum(b.total for b in predictive_maintenance.benefits))
    total_costs = sum(c.total for c in costs)
    
    # Create cash flow array
    cash_flows = [-2060000]  # Year 0
    for year in range(1, 6):
        year_benefits = sum(
            getattr(b, f'year_{year}') for b in predictive_maintenance.benefits
        )
        year_costs = sum(
            getattr(c, f'year_{year}') for c in costs
        )
        cash_flows.append(year_benefits - year_costs)
    
    npv = agent.calculate_npv(cash_flows, agent.discount_rate)
    payback = agent.calculate_payback_period(2060000, cash_flows[1:])
    
    print("\n" + "="*80)
    print("FINANCIAL ANALYSIS")
    print("="*80)
    print(f"Total 5-Year Benefits: ${total_benefits:,.0f}")
    print(f"Total Investment: ${total_costs:,.0f}")
    print(f"Net Benefit: ${total_benefits - total_costs:,.0f}")
    print(f"NPV (at {agent.discount_rate*100:.0f}%): ${npv:,.0f}")
    print(f"ROI: {((total_benefits - total_costs) / total_costs * 100):.1f}%")
    if payback:
        print(f"Payback Period: {payback:.2f} years")
    print("="*80)
    
    print("\n" + agent.generate_comprehensive_report())
    agent.export_to_json("manufacturing_predictive_maintenance.json")


def run_all_examples():
    """Run all example scenarios"""
    examples = [
        ("Financial Services", example_financial_services_fraud_detection),
        ("Retail", example_retail_demand_forecasting),
        ("Manufacturing", example_manufacturing_predictive_maintenance)
    ]
    
    print("\n" + "="*80)
    print("VALUE ANALYSIS AGENT - EXAMPLE SCENARIOS")
    print("="*80)
    print("\nThis script demonstrates the Value Analysis Agent with real-world scenarios")
    print("across different industries.\n")
    
    for i, (industry, func) in enumerate(examples, 1):
        print(f"\n{i}. {industry}")
    
    print("\n0. Run all examples")
    print("="*80)
    
    choice = input("\nSelect example (0-3): ").strip()
    
    if choice == "0":
        for industry, func in examples:
            func()
            input("\nPress Enter to continue to next example...")
    elif choice in ["1", "2", "3"]:
        examples[int(choice) - 1][1]()
    else:
        print("Invalid choice")


if __name__ == "__main__":
    run_all_examples()
