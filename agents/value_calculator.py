"""
Value Calculator Module
Provides advanced financial calculations for value analysis
"""

from typing import List, Dict, Tuple, Optional
import math


class FinancialCalculator:
    """Advanced financial calculations for AI project value analysis"""
    
    @staticmethod
    def calculate_npv(cash_flows: List[float], discount_rate: float) -> float:
        """
        Calculate Net Present Value
        
        Args:
            cash_flows: List of cash flows [Year0, Year1, ..., YearN]
            discount_rate: Discount rate (e.g., 0.10 for 10%)
            
        Returns:
            Net Present Value
        """
        npv = 0
        for year, cash_flow in enumerate(cash_flows):
            npv += cash_flow / ((1 + discount_rate) ** year)
        return npv
    
    @staticmethod
    def calculate_irr(cash_flows: List[float], initial_guess: float = 0.1, 
                     max_iterations: int = 100, tolerance: float = 1e-6) -> Optional[float]:
        """
        Calculate Internal Rate of Return using Newton-Raphson method
        
        Args:
            cash_flows: List of cash flows [Year0, Year1, ..., YearN]
            initial_guess: Starting guess for IRR
            max_iterations: Maximum iterations
            tolerance: Convergence tolerance
            
        Returns:
            IRR as decimal (e.g., 0.15 for 15%) or None if not found
        """
        rate = initial_guess
        
        for _ in range(max_iterations):
            # Calculate NPV
            npv = sum(cf / ((1 + rate) ** i) for i, cf in enumerate(cash_flows))
            
            # Calculate derivative (dNPV/dr)
            npv_derivative = sum(-i * cf / ((1 + rate) ** (i + 1)) 
                               for i, cf in enumerate(cash_flows))
            
            if abs(npv_derivative) < 1e-10:
                return None  # Cannot converge
            
            # Newton-Raphson update
            new_rate = rate - npv / npv_derivative
            
            if abs(new_rate - rate) < tolerance:
                return new_rate
            
            rate = new_rate
        
        return None  # Did not converge
    
    @staticmethod
    def calculate_payback_period(initial_investment: float, 
                                annual_cash_flows: List[float]) -> Optional[float]:
        """
        Calculate simple payback period
        
        Args:
            initial_investment: Initial investment (positive number)
            annual_cash_flows: Annual net cash flows [Year1, Year2, ...]
            
        Returns:
            Payback period in years (with fractional year) or None if never pays back
        """
        cumulative = -initial_investment
        
        for year, cash_flow in enumerate(annual_cash_flows, start=1):
            cumulative += cash_flow
            if cumulative >= 0:
                # Linear interpolation for fractional year
                previous_cumulative = cumulative - cash_flow
                fraction = abs(previous_cumulative) / cash_flow if cash_flow != 0 else 0
                return year - 1 + fraction
        
        return None  # Never pays back
    
    @staticmethod
    def calculate_discounted_payback(initial_investment: float,
                                    annual_cash_flows: List[float],
                                    discount_rate: float) -> Optional[float]:
        """
        Calculate discounted payback period
        
        Args:
            initial_investment: Initial investment
            annual_cash_flows: Annual net cash flows
            discount_rate: Discount rate
            
        Returns:
            Discounted payback period in years or None
        """
        cumulative = -initial_investment
        
        for year, cash_flow in enumerate(annual_cash_flows, start=1):
            discounted_cf = cash_flow / ((1 + discount_rate) ** year)
            cumulative += discounted_cf
            
            if cumulative >= 0:
                # Linear interpolation
                previous_cumulative = cumulative - discounted_cf
                fraction = abs(previous_cumulative) / discounted_cf if discounted_cf != 0 else 0
                return year - 1 + fraction
        
        return None
    
    @staticmethod
    def calculate_profitability_index(total_pv_benefits: float, 
                                     initial_investment: float) -> float:
        """
        Calculate Profitability Index (PI)
        PI = PV of future cash flows / Initial investment
        
        Args:
            total_pv_benefits: Present value of all future benefits
            initial_investment: Initial investment
            
        Returns:
            Profitability Index (PI > 1 is favorable)
        """
        if initial_investment == 0:
            return 0
        return total_pv_benefits / initial_investment
    
    @staticmethod
    def calculate_benefit_cost_ratio(total_benefits: float, total_costs: float) -> float:
        """
        Calculate Benefit-Cost Ratio
        
        Args:
            total_benefits: Total benefits
            total_costs: Total costs
            
        Returns:
            Benefit-Cost Ratio (>1 means benefits exceed costs)
        """
        if total_costs == 0:
            return 0
        return total_benefits / total_costs
    
    @staticmethod
    def sensitivity_analysis(base_npv: float, 
                            variable_name: str,
                            base_value: float,
                            variations: List[float],
                            npv_calculator) -> Dict[float, float]:
        """
        Perform sensitivity analysis on a variable
        
        Args:
            base_npv: Base case NPV
            variable_name: Name of variable being analyzed
            base_value: Base value of the variable
            variations: List of % changes (e.g., [-0.2, -0.1, 0, 0.1, 0.2])
            npv_calculator: Function that calculates NPV given new value
            
        Returns:
            Dictionary mapping variation % to NPV
        """
        results = {}
        for variation in variations:
            new_value = base_value * (1 + variation)
            new_npv = npv_calculator(new_value)
            results[variation] = new_npv
        
        return results
    
    @staticmethod
    def monte_carlo_simulation(base_case: Dict[str, float],
                              distributions: Dict[str, Tuple[str, float, float]],
                              npv_calculator,
                              num_simulations: int = 1000) -> Dict:
        """
        Run Monte Carlo simulation for risk analysis
        
        Args:
            base_case: Base case values for all variables
            distributions: Variable distributions 
                          {var_name: (distribution_type, param1, param2)}
                          e.g., {'benefits': ('normal', 1000000, 100000)}
            npv_calculator: Function to calculate NPV
            num_simulations: Number of Monte Carlo iterations
            
        Returns:
            Dictionary with statistics (mean, std, percentiles, etc.)
        """
        import random
        
        npv_results = []
        
        for _ in range(num_simulations):
            scenario = base_case.copy()
            
            # Sample from distributions
            for var_name, (dist_type, param1, param2) in distributions.items():
                if dist_type == 'normal':
                    # Normal distribution (mean, std_dev)
                    scenario[var_name] = random.gauss(param1, param2)
                elif dist_type == 'uniform':
                    # Uniform distribution (min, max)
                    scenario[var_name] = random.uniform(param1, param2)
                elif dist_type == 'triangular':
                    # Triangular (min, mode, max) - param2 is max, param1 is mode
                    min_val = param1 * 0.7  # Assume min is 70% of mode
                    scenario[var_name] = random.triangular(min_val, param2, param1)
            
            # Calculate NPV for this scenario
            npv = npv_calculator(scenario)
            npv_results.append(npv)
        
        # Calculate statistics
        npv_results.sort()
        mean_npv = sum(npv_results) / len(npv_results)
        variance = sum((x - mean_npv) ** 2 for x in npv_results) / len(npv_results)
        std_dev = math.sqrt(variance)
        
        return {
            'mean': mean_npv,
            'std_dev': std_dev,
            'min': npv_results[0],
            'max': npv_results[-1],
            'percentile_5': npv_results[int(len(npv_results) * 0.05)],
            'percentile_25': npv_results[int(len(npv_results) * 0.25)],
            'median': npv_results[int(len(npv_results) * 0.50)],
            'percentile_75': npv_results[int(len(npv_results) * 0.75)],
            'percentile_95': npv_results[int(len(npv_results) * 0.95)],
            'probability_positive': sum(1 for x in npv_results if x > 0) / len(npv_results)
        }


class RiskAdjustmentCalculator:
    """Calculate risk-adjusted values"""
    
    @staticmethod
    def calculate_certainty_equivalent(expected_value: float, 
                                      risk_premium: float) -> float:
        """
        Calculate certainty equivalent value
        
        Args:
            expected_value: Expected value without risk adjustment
            risk_premium: Risk premium (e.g., 0.05 for 5% discount)
            
        Returns:
            Certainty equivalent value
        """
        return expected_value * (1 - risk_premium)
    
    @staticmethod
    def apply_confidence_weighting(values: List[float], 
                                  confidences: List[float]) -> float:
        """
        Calculate confidence-weighted average
        
        Args:
            values: List of values
            confidences: List of confidence levels (0-1)
            
        Returns:
            Confidence-weighted value
        """
        if not values or not confidences or len(values) != len(confidences):
            return 0
        
        total_weight = sum(confidences)
        if total_weight == 0:
            return 0
        
        weighted_sum = sum(v * c for v, c in zip(values, confidences))
        return weighted_sum / total_weight
    
    @staticmethod
    def calculate_value_at_risk(sorted_outcomes: List[float], 
                               confidence_level: float = 0.95) -> float:
        """
        Calculate Value at Risk (VaR)
        
        Args:
            sorted_outcomes: Sorted list of possible outcomes
            confidence_level: Confidence level (e.g., 0.95 for 95%)
            
        Returns:
            Value at Risk at given confidence level
        """
        if not sorted_outcomes:
            return 0
        
        index = int(len(sorted_outcomes) * (1 - confidence_level))
        return sorted_outcomes[index]


class BenefitEstimator:
    """Estimate and categorize benefits"""
    
    @staticmethod
    def estimate_labor_savings(hours_saved_annually: float,
                              hourly_rate: float,
                              employees_affected: int) -> float:
        """
        Estimate annual labor cost savings
        
        Args:
            hours_saved_annually: Hours saved per employee per year
            hourly_rate: Loaded hourly rate (including benefits)
            employees_affected: Number of employees affected
            
        Returns:
            Annual labor savings
        """
        return hours_saved_annually * hourly_rate * employees_affected
    
    @staticmethod
    def estimate_efficiency_gain(current_throughput: float,
                                target_throughput: float,
                                unit_value: float) -> float:
        """
        Estimate value from efficiency gains
        
        Args:
            current_throughput: Current units processed
            target_throughput: Target units after AI implementation
            unit_value: Value per unit
            
        Returns:
            Annual value from efficiency gain
        """
        additional_units = target_throughput - current_throughput
        return additional_units * unit_value
    
    @staticmethod
    def estimate_error_reduction_value(current_error_rate: float,
                                      target_error_rate: float,
                                      cost_per_error: float,
                                      volume: int) -> float:
        """
        Estimate value from error reduction
        
        Args:
            current_error_rate: Current error rate (0-1)
            target_error_rate: Target error rate after AI
            cost_per_error: Average cost per error
            volume: Annual transaction volume
            
        Returns:
            Annual savings from error reduction
        """
        current_errors = volume * current_error_rate
        target_errors = volume * target_error_rate
        errors_avoided = current_errors - target_errors
        return errors_avoided * cost_per_error
    
    @staticmethod
    def estimate_customer_lifetime_value_increase(current_clv: float,
                                                  improvement_rate: float,
                                                  affected_customers: int) -> float:
        """
        Estimate value from CLV improvement
        
        Args:
            current_clv: Current customer lifetime value
            improvement_rate: Expected improvement (e.g., 0.15 for 15%)
            affected_customers: Number of customers affected
            
        Returns:
            Total CLV increase
        """
        clv_increase_per_customer = current_clv * improvement_rate
        return clv_increase_per_customer * affected_customers
    
    @staticmethod
    def estimate_revenue_from_ai_feature(addressable_market_size: int,
                                        conversion_rate: float,
                                        price_per_customer: float) -> float:
        """
        Estimate new revenue from AI feature
        
        Args:
            addressable_market_size: Total addressable market
            conversion_rate: Expected conversion rate
            price_per_customer: Revenue per customer
            
        Returns:
            Estimated annual revenue
        """
        customers = addressable_market_size * conversion_rate
        return customers * price_per_customer


if __name__ == "__main__":
    # Example usage
    calc = FinancialCalculator()
    
    # Example: Calculate NPV
    cash_flows = [-1000000, 300000, 400000, 450000, 500000, 550000]
    npv = calc.calculate_npv(cash_flows, 0.10)
    print(f"NPV: ${npv:,.2f}")
    
    # Example: Calculate IRR
    irr = calc.calculate_irr(cash_flows)
    if irr:
        print(f"IRR: {irr*100:.2f}%")
    
    # Example: Calculate payback
    payback = calc.calculate_payback_period(1000000, cash_flows[1:])
    if payback:
        print(f"Payback Period: {payback:.2f} years")
