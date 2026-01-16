"""
Example: Value Realization Tracking with AI Delivery Agent

This example demonstrates how to use the value tracking features
to monitor actual vs. forecast performance and ensure NPV achievement.
"""

from value_analysis_agent import (
    ValueAnalysisAgent, UseCase, FinancialBenefit, CostItem, ActualValue,
    ImpactLevel, ValueCategory
)

# Create agent
agent = ValueAnalysisAgent("Customer Service AI Project")

# Add use case with forecast
use_case = UseCase(
    id="UC-001",
    title="AI Customer Service Chatbot",
    description="Automated tier-1 customer support",
    business_problem="85% of inquiries are repetitive, causing long wait times",
    impact_level=ImpactLevel.CRITICAL,
    effort_estimate=29
)

# Add forecast benefits
benefit = FinancialBenefit(
    category=ValueCategory.COST_REDUCTION,
    description="Labor cost savings from automation",
    year_1=400000,
    year_2=450000,
    year_3=500000,
    year_4=550000,
    year_5=600000,
    confidence_level=0.85
)
use_case.benefits.append(benefit)

agent.add_use_case(use_case)

# Add forecast costs
cost = CostItem(
    category="Implementation & Operations",
    description="Development, infrastructure, and ongoing support",
    year_0=150000,  # Initial investment
    year_1=180000,
    year_2=170000,
    year_3=165000,
    year_4=165000,
    year_5=165000
)
agent.add_cost(cost)

print("\n" + "="*80)
print("FORECAST ESTABLISHED")
print("="*80)

# Set baseline NPV
agent.set_baseline_npv()

print("\n" + "="*80)
print("TRACKING ACTUAL PERFORMANCE")
print("="*80)

# Record Q1 2026 actuals - EXCEEDED TARGETS
actual_q1 = ActualValue(
    period="2026-Q1",
    use_case_id="UC-001",
    forecast_benefit=100000,  # $400K annual / 4 quarters
    actual_benefit=115000,     # 15% above forecast
    forecast_cost=45000,       # $180K annual / 4 quarters
    actual_cost=42000,         # 3K under budget
    notes="Exceeded targets due to higher than expected adoption (65% vs 50% forecast)"
)
agent.record_actual_value(actual_q1)

# Record Q2 2026 actuals - SLIGHT UNDERPERFORMANCE
actual_q2 = ActualValue(
    period="2026-Q2",
    use_case_id="UC-001",
    forecast_benefit=100000,
    actual_benefit=88000,      # 12% below forecast
    forecast_cost=45000,
    actual_cost=48000,         # 3K over budget
    notes="Adoption plateau - users requesting additional training. Infrastructure costs higher than expected."
)
agent.record_actual_value(actual_q2)

# Record Q3 2026 actuals - BACK ON TRACK
actual_q3 = ActualValue(
    period="2026-Q3",
    use_case_id="UC-001",
    forecast_benefit=100000,
    actual_benefit=105000,     # 5% above forecast
    forecast_cost=45000,
    actual_cost=43000,         # 2K under budget
    notes="Training investment paid off. Adoption increased to 72%. Optimized infrastructure costs."
)
agent.record_actual_value(actual_q3)

# Show current status
print("\n" + "="*80)
print("CURRENT VALUE REALIZATION STATUS")
print("="*80)

status = agent.calculate_value_realization_status()
print(f"\nStatus: {status['status']}")
print(f"\nBenefits (YTD 9 months):")
print(f"  Forecast: ${status['total_forecast_benefit']:,.2f}")
print(f"  Actual:   ${status['total_actual_benefit']:,.2f}")
print(f"  Variance: ${status['benefit_variance']:,.2f}")
print(f"  Achievement: {status['benefit_achievement_rate']:.1f}%")

print(f"\nCosts (YTD 9 months):")
print(f"  Forecast: ${status['total_forecast_cost']:,.2f}")
print(f"  Actual:   ${status['total_actual_cost']:,.2f}")
print(f"  Variance: ${status['cost_variance']:,.2f}")
print(f"  Performance: {status['cost_performance']:.1f}%")

# Generate full tracking report
print(agent.generate_value_tracking_report())

# Export with actuals
agent.export_to_json("value_tracking_example.json")

print("\n" + "="*80)
print("KEY TAKEAWAYS")
print("="*80)
print("""
✅ Overall Status: On Track (after Q2 dip, recovered in Q3)
✅ YTD Benefits: 102.7% of forecast ($308K actual vs $300K forecast)
✅ YTD Costs: 98.5% of budget ($133K actual vs $135K forecast)

📊 Insights:
   • Q1: Strong start with 15% benefit overperformance
   • Q2: Temporary dip due to adoption plateau
   • Q3: Recovery after training investment
   
💡 Actions Taken:
   • Increased training programs (Q2 response)
   • Infrastructure optimization (Q3)
   • Regular adoption monitoring
   
🎯 On Track to Achieve Baseline NPV

This example demonstrates how to:
1. Set baseline NPV from forecast
2. Record quarterly actuals
3. Monitor variance and status
4. Take corrective actions
5. Validate NPV achievement
""")
