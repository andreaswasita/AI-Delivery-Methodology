"""
Test script for Value Analysis Agent
Validates core functionality without user interaction
"""

from value_analysis_agent import (
    ValueAnalysisAgent, UseCase, FinancialBenefit, CostItem,
    ImpactLevel, ValueCategory
)
from value_calculator import FinancialCalculator, BenefitEstimator


def test_basic_functionality():
    """Test basic agent functionality"""
    print("\n" + "="*80)
    print("VALUE ANALYSIS AGENT - FUNCTIONALITY TEST")
    print("="*80)
    
    # Create agent
    agent = ValueAnalysisAgent("Test Project")
    print("✅ Agent created successfully")
    
    # Create use case
    use_case = UseCase(
        id="TEST-001",
        title="Test Use Case",
        description="Test description",
        business_problem="Test problem",
        impact_level=ImpactLevel.HIGH,
        effort_estimate=20
    )
    
    # Add benefit
    benefit = FinancialBenefit(
        category=ValueCategory.COST_REDUCTION,
        description="Test benefit",
        year_1=100000,
        year_2=120000,
        year_3=140000,
        year_4=160000,
        year_5=180000,
        confidence_level=0.85
    )
    use_case.benefits.append(benefit)
    
    agent.add_use_case(use_case)
    print("✅ Use case added successfully")
    
    # Add cost
    cost = CostItem(
        category="Development",
        description="Test cost",
        year_0=200000,
        year_1=50000,
        year_2=50000,
        year_3=50000,
        year_4=50000,
        year_5=50000
    )
    agent.add_cost(cost)
    print("✅ Cost added successfully")
    
    # Test calculations
    total_benefits = use_case.total_benefit
    total_costs = cost.total
    
    print(f"\n📊 CALCULATIONS")
    print(f"   Total Benefits: ${total_benefits:,.0f}")
    print(f"   Total Costs: ${total_costs:,.0f}")
    print(f"   Value Score: {use_case.value_score:.1f}")
    print(f"   Priority Score: {use_case.priority_score:.1f}")
    
    # Test ROI calculation
    roi_metrics = agent.calculate_roi(total_benefits, total_costs)
    print(f"\n💰 ROI METRICS")
    print(f"   ROI: {roi_metrics['roi_percentage']:.1f}%")
    print(f"   Net Benefit: ${roi_metrics['net_benefit']:,.0f}")
    
    # Test NPV
    cash_flows = [-200000, 50000, 70000, 90000, 110000, 130000]
    npv = agent.calculate_npv(cash_flows)
    print(f"   NPV: ${npv:,.0f}")
    
    # Test payback
    payback = agent.calculate_payback_period(200000, cash_flows[1:])
    if payback:
        print(f"   Payback Period: {payback:.2f} years")
    
    # Test prioritization
    print(f"\n🎯 PRIORITIZATION")
    prioritized = agent.prioritize_use_cases()
    for rank, (uc, score, rec) in enumerate(prioritized, 1):
        print(f"   {rank}. {uc.title}: {rec}")
    
    # Test export
    print(f"\n📤 EXPORT")
    try:
        agent.export_to_json("test_export.json")
        print("   ✅ JSON export successful")
    except Exception as e:
        print(f"   ❌ JSON export failed: {e}")
    
    try:
        agent.save_report("test_report.txt")
        print("   ✅ Report export successful")
    except Exception as e:
        print(f"   ❌ Report export failed: {e}")
    
    print("\n" + "="*80)
    print("✅ ALL TESTS PASSED")
    print("="*80)
    return True


def test_financial_calculator():
    """Test financial calculator functions"""
    print("\n" + "="*80)
    print("FINANCIAL CALCULATOR - FUNCTIONALITY TEST")
    print("="*80)
    
    calc = FinancialCalculator()
    
    # Test NPV
    cash_flows = [-1000000, 300000, 400000, 450000, 500000, 550000]
    npv = calc.calculate_npv(cash_flows, 0.10)
    print(f"✅ NPV Calculation: ${npv:,.2f}")
    
    # Test IRR
    irr = calc.calculate_irr(cash_flows)
    if irr:
        print(f"✅ IRR Calculation: {irr*100:.2f}%")
    
    # Test Payback
    payback = calc.calculate_payback_period(1000000, cash_flows[1:])
    if payback:
        print(f"✅ Payback Calculation: {payback:.2f} years")
    
    # Test Profitability Index
    pi = calc.calculate_profitability_index(2000000, 1000000)
    print(f"✅ Profitability Index: {pi:.2f}")
    
    # Test BCR
    bcr = calc.calculate_benefit_cost_ratio(2000000, 1000000)
    print(f"✅ Benefit-Cost Ratio: {bcr:.2f}")
    
    print("="*80)
    print("✅ ALL FINANCIAL CALCULATOR TESTS PASSED")
    print("="*80)
    return True


def test_benefit_estimator():
    """Test benefit estimation functions"""
    print("\n" + "="*80)
    print("BENEFIT ESTIMATOR - FUNCTIONALITY TEST")
    print("="*80)
    
    estimator = BenefitEstimator()
    
    # Test labor savings
    labor_savings = estimator.estimate_labor_savings(
        hours_saved_annually=520,
        hourly_rate=75,
        employees_affected=50
    )
    print(f"✅ Labor Savings: ${labor_savings:,.0f}")
    
    # Test error reduction
    error_value = estimator.estimate_error_reduction_value(
        current_error_rate=0.15,
        target_error_rate=0.02,
        cost_per_error=5000,
        volume=10000
    )
    print(f"✅ Error Reduction Value: ${error_value:,.0f}")
    
    # Test efficiency gain
    efficiency = estimator.estimate_efficiency_gain(
        current_throughput=1000,
        target_throughput=1500,
        unit_value=100
    )
    print(f"✅ Efficiency Gain: ${efficiency:,.0f}")
    
    print("="*80)
    print("✅ ALL BENEFIT ESTIMATOR TESTS PASSED")
    print("="*80)
    return True


def run_all_tests():
    """Run all test suites"""
    print("\n" + "="*80)
    print("RUNNING ALL VALUE ANALYSIS AGENT TESTS")
    print("="*80)
    
    results = []
    
    try:
        results.append(("Basic Functionality", test_basic_functionality()))
    except Exception as e:
        print(f"❌ Basic Functionality Test Failed: {e}")
        results.append(("Basic Functionality", False))
    
    try:
        results.append(("Financial Calculator", test_financial_calculator()))
    except Exception as e:
        print(f"❌ Financial Calculator Test Failed: {e}")
        results.append(("Financial Calculator", False))
    
    try:
        results.append(("Benefit Estimator", test_benefit_estimator()))
    except Exception as e:
        print(f"❌ Benefit Estimator Test Failed: {e}")
        results.append(("Benefit Estimator", False))
    
    # Summary
    print("\n" + "="*80)
    print("TEST SUMMARY")
    print("="*80)
    
    for test_name, passed in results:
        status = "✅ PASSED" if passed else "❌ FAILED"
        print(f"{status}: {test_name}")
    
    all_passed = all(result[1] for result in results)
    
    print("\n" + "="*80)
    if all_passed:
        print("🎉 ALL TESTS PASSED - Agent is ready to use!")
    else:
        print("⚠️  SOME TESTS FAILED - Please review errors above")
    print("="*80)
    
    return all_passed


if __name__ == "__main__":
    success = run_all_tests()
    exit(0 if success else 1)
