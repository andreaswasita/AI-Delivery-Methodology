# AI Model Risk Management Guide
## Model Monitoring, Drift Detection, and Adversarial AI Defense

## Document Information

**Purpose**: Comprehensive framework for managing AI model risks in production  
**Audience**: ML Engineers, Data Scientists, MLOps Teams, Security Teams  
**Technologies**: Azure Machine Learning, Python, Azure Monitor  
**Date**: January 2026

---

## Overview

### Why This Matters

**70% of ML models degrade in performance within 12 months of deployment** due to data drift, concept drift, and adversarial attacks. This guide provides comprehensive strategies and code to monitor, detect, and mitigate these risks.

### What We Cover

1. **Model Performance Monitoring** - Track accuracy, precision, recall in production
2. **Data Drift Detection** - Identify when input data distributions change
3. **Concept Drift Detection** - Detect when the relationship between features and target changes
4. **Model Explainability Monitoring** - Track prediction reasoning over time
5. **Adversarial AI Risks** - Defend against malicious inputs and attacks
6. **Automated Alerting & Response** - Trigger retraining or rollback automatically

---

## Risk Categories

### 1. Data Drift

**What It Is**: Input data distribution changes from training data

**Example Scenarios**:
- Customer demographics shift over time
- Seasonal patterns change
- New product categories introduced
- Market conditions evolve

**Impact**: Model trained on old distribution performs poorly on new data

**Detection Methods**:
- Population Stability Index (PSI)
- Kolmogorov-Smirnov Test
- Jensen-Shannon Divergence
- Wasserstein Distance

---

### 2. Concept Drift

**What It Is**: Relationship between features and target variable changes

**Example Scenarios**:
- Customer preferences evolve
- Economic conditions change behavior
- Regulatory changes alter outcomes
- Competitor actions shift market dynamics

**Impact**: Model's learned patterns no longer valid

**Detection Methods**:
- Performance metric degradation
- Error rate increases
- Prediction distribution changes
- Sequential error analysis

---

### 3. Model Degradation

**What It Is**: Model performance declines over time

**Causes**:
- Data drift
- Concept drift
- Software/infrastructure changes
- Training-serving skew

**Detection Methods**:
- Accuracy/F1 score tracking
- Precision/Recall monitoring
- AUC-ROC trends
- Business metric correlation

---

### 4. Adversarial Attacks

**What It Is**: Malicious inputs designed to fool the model

**Attack Types**:
- **Evasion Attacks**: Crafted inputs to bypass detection
- **Poisoning Attacks**: Corrupt training data
- **Model Inversion**: Extract sensitive training data
- **Model Extraction**: Steal model logic
- **Backdoor Attacks**: Hidden triggers for misclassification

**Detection Methods**:
- Input validation and sanitization
- Anomaly detection on inputs
- Adversarial example detection
- Certified defenses

---

## Azure Machine Learning Model Monitoring

### Setting Up Model Monitoring

```python
# model_monitoring_setup.py
"""
Complete setup for Azure ML model monitoring including drift detection,
performance monitoring, and alerting.
"""

from azureml.core import Workspace, Model, Dataset
from azureml.datadrift import DataDriftDetector, AlertConfiguration
from azureml.core.compute import ComputeTarget, AmlCompute
from datetime import datetime, timedelta
import pandas as pd
import numpy as np

# ============================================================================
# STEP 1: WORKSPACE AND MODEL SETUP
# ============================================================================

def setup_workspace():
    """Connect to Azure ML workspace"""
    ws = Workspace.from_config()
    print(f"Connected to workspace: {ws.name}")
    return ws

def register_baseline_dataset(ws, baseline_data_path, dataset_name):
    """
    Register baseline (training) dataset for drift comparison
    """
    from azureml.core import Dataset
    
    # Create dataset from training data
    datastore = ws.get_default_datastore()
    baseline_dataset = Dataset.Tabular.from_delimited_files(
        path=baseline_data_path
    )
    
    # Register with timestamp
    baseline_dataset = baseline_dataset.register(
        workspace=ws,
        name=dataset_name,
        description=f'Baseline dataset for drift detection - {datetime.now()}',
        tags={'type': 'baseline', 'purpose': 'drift_detection'},
        create_new_version=True
    )
    
    print(f"Registered baseline dataset: {dataset_name}")
    return baseline_dataset

# ============================================================================
# STEP 2: DATA DRIFT DETECTOR SETUP
# ============================================================================

def create_drift_detector(ws, baseline_dataset, target_dataset, features):
    """
    Create data drift detector to compare production data against baseline
    
    Args:
        ws: Azure ML Workspace
        baseline_dataset: Training/baseline dataset
        target_dataset: Production/target dataset
        features: List of feature columns to monitor
    """
    
    # Create drift detector
    drift_detector = DataDriftDetector.create_from_datasets(
        workspace=ws,
        name='customer_churn_drift_detector',
        baseline_data_set=baseline_dataset,
        target_data_set=target_dataset,
        compute_target='cpu-cluster',  # Your compute cluster name
        frequency='Week',  # Day, Week, Month
        feature_list=features,  # Specific features to monitor
        drift_threshold=0.3,  # PSI threshold for drift alert
        latency=24  # Hours to wait for data to arrive
    )
    
    print(f"Created drift detector: {drift_detector.name}")
    return drift_detector

def configure_drift_alerts(drift_detector, alert_emails):
    """
    Configure email alerts when drift is detected
    """
    alert_config = AlertConfiguration(alert_emails)
    drift_detector.update(alert_configuration=alert_config)
    print(f"Configured drift alerts to: {alert_emails}")

# ============================================================================
# STEP 3: PERFORMANCE MONITORING
# ============================================================================

def setup_performance_monitoring(ws, model_name, model_version):
    """
    Set up Application Insights for model performance monitoring
    """
    from azureml.core import Webservice
    from azureml.core.webservice import AksWebservice
    
    # Get deployed model service
    service = Webservice(ws, name=model_name)
    
    # Enable Application Insights
    service.update(enable_app_insights=True)
    
    print(f"Application Insights enabled for: {model_name}")
    print(f"Insights URL: {service.get_logs()}")
    
    return service

# ============================================================================
# STEP 4: CUSTOM DRIFT DETECTION CODE
# ============================================================================

class DriftDetector:
    """
    Custom drift detection using multiple statistical tests
    """
    
    def __init__(self, baseline_data, significance_level=0.05):
        """
        Args:
            baseline_data: Training/baseline DataFrame
            significance_level: Threshold for statistical tests
        """
        self.baseline_data = baseline_data
        self.significance_level = significance_level
        self.baseline_stats = self._calculate_baseline_stats()
    
    def _calculate_baseline_stats(self):
        """Calculate statistics for baseline data"""
        stats = {}
        for column in self.baseline_data.select_dtypes(include=[np.number]).columns:
            stats[column] = {
                'mean': self.baseline_data[column].mean(),
                'std': self.baseline_data[column].std(),
                'min': self.baseline_data[column].min(),
                'max': self.baseline_data[column].max(),
                'percentiles': self.baseline_data[column].quantile([0.25, 0.5, 0.75]).to_dict()
            }
        return stats
    
    def calculate_psi(self, baseline, production, buckets=10):
        """
        Calculate Population Stability Index (PSI)
        
        PSI < 0.1: No significant change
        0.1 <= PSI < 0.2: Moderate change
        PSI >= 0.2: Significant change (drift detected)
        """
        import numpy as np
        
        # Create bins based on baseline
        breakpoints = np.linspace(baseline.min(), baseline.max(), buckets + 1)
        breakpoints[0] = -np.inf
        breakpoints[-1] = np.inf
        
        # Calculate distributions
        baseline_counts = np.histogram(baseline, bins=breakpoints)[0]
        production_counts = np.histogram(production, bins=breakpoints)[0]
        
        # Convert to proportions
        baseline_props = baseline_counts / len(baseline)
        production_props = production_counts / len(production)
        
        # Avoid division by zero
        baseline_props = np.where(baseline_props == 0, 0.0001, baseline_props)
        production_props = np.where(production_props == 0, 0.0001, production_props)
        
        # Calculate PSI
        psi = np.sum((production_props - baseline_props) * 
                     np.log(production_props / baseline_props))
        
        return psi
    
    def ks_test(self, baseline, production):
        """
        Kolmogorov-Smirnov test for distribution comparison
        
        Returns:
            statistic: KS statistic (0-1, higher = more different)
            p_value: Statistical significance
            drift_detected: Boolean
        """
        from scipy import stats
        
        statistic, p_value = stats.ks_2samp(baseline, production)
        drift_detected = p_value < self.significance_level
        
        return {
            'statistic': statistic,
            'p_value': p_value,
            'drift_detected': drift_detected,
            'severity': 'HIGH' if statistic > 0.3 else 'MEDIUM' if statistic > 0.1 else 'LOW'
        }
    
    def wasserstein_distance(self, baseline, production):
        """
        Calculate Wasserstein distance (Earth Mover's Distance)
        Measures the minimum cost to transform one distribution to another
        """
        from scipy import stats
        
        distance = stats.wasserstein_distance(baseline, production)
        
        # Normalize by baseline range
        baseline_range = baseline.max() - baseline.min()
        normalized_distance = distance / baseline_range if baseline_range > 0 else 0
        
        drift_detected = normalized_distance > 0.1  # 10% threshold
        
        return {
            'distance': distance,
            'normalized_distance': normalized_distance,
            'drift_detected': drift_detected,
            'severity': 'HIGH' if normalized_distance > 0.2 else 'MEDIUM' if normalized_distance > 0.1 else 'LOW'
        }
    
    def detect_drift(self, production_data, features=None):
        """
        Comprehensive drift detection across multiple features
        
        Args:
            production_data: Current production DataFrame
            features: List of features to check (None = all numeric)
        
        Returns:
            Dictionary with drift results per feature
        """
        if features is None:
            features = self.baseline_data.select_dtypes(include=[np.number]).columns
        
        drift_results = {}
        
        for feature in features:
            if feature not in production_data.columns:
                continue
            
            baseline_feature = self.baseline_data[feature].dropna()
            production_feature = production_data[feature].dropna()
            
            # Calculate multiple drift metrics
            psi = self.calculate_psi(baseline_feature, production_feature)
            ks_result = self.ks_test(baseline_feature, production_feature)
            ws_result = self.wasserstein_distance(baseline_feature, production_feature)
            
            # Determine overall drift status
            drift_detected = (
                psi >= 0.2 or 
                ks_result['drift_detected'] or 
                ws_result['drift_detected']
            )
            
            drift_results[feature] = {
                'drift_detected': drift_detected,
                'psi': psi,
                'ks_test': ks_result,
                'wasserstein': ws_result,
                'baseline_mean': baseline_feature.mean(),
                'production_mean': production_feature.mean(),
                'mean_shift': abs(production_feature.mean() - baseline_feature.mean()) / baseline_feature.std() if baseline_feature.std() > 0 else 0
            }
        
        return drift_results
    
    def generate_drift_report(self, drift_results):
        """Generate human-readable drift report"""
        print("\n" + "="*80)
        print("DATA DRIFT DETECTION REPORT")
        print("="*80)
        
        drifted_features = [f for f, r in drift_results.items() if r['drift_detected']]
        
        print(f"\nFeatures Monitored: {len(drift_results)}")
        print(f"Drift Detected: {len(drifted_features)} features")
        
        if drifted_features:
            print(f"\n⚠️  DRIFT DETECTED IN: {', '.join(drifted_features)}")
            print("\nDetailed Analysis:")
            
            for feature in drifted_features:
                result = drift_results[feature]
                print(f"\n  {feature}:")
                print(f"    - PSI: {result['psi']:.4f} {'❌ DRIFT' if result['psi'] >= 0.2 else '✓ OK'}")
                print(f"    - KS Statistic: {result['ks_test']['statistic']:.4f} ({result['ks_test']['severity']})")
                print(f"    - Wasserstein: {result['wasserstein']['normalized_distance']:.4f} ({result['wasserstein']['severity']})")
                print(f"    - Mean Shift: {result['mean_shift']:.2f} std devs")
        else:
            print("\n✓ No significant drift detected")
        
        print("\n" + "="*80)
        
        return drifted_features

# ============================================================================
# EXAMPLE USAGE
# ============================================================================

def example_drift_detection():
    """Example of using the drift detector"""
    
    # Load baseline (training) data
    baseline_df = pd.read_csv('training_data.csv')
    
    # Load production data
    production_df = pd.read_csv('production_data_week1.csv')
    
    # Initialize detector
    detector = DriftDetector(baseline_df, significance_level=0.05)
    
    # Detect drift
    drift_results = detector.detect_drift(
        production_df, 
        features=['age', 'income', 'credit_score', 'transaction_amount']
    )
    
    # Generate report
    drifted_features = detector.generate_drift_report(drift_results)
    
    # Take action if drift detected
    if drifted_features:
        print(f"\n⚠️  ACTION REQUIRED: Retrain model or investigate drift in {len(drifted_features)} features")
        # Trigger retraining pipeline
        # trigger_retraining_pipeline()
    
    return drift_results

# ============================================================================
# CONCEPT DRIFT DETECTION
# ============================================================================

class ConceptDriftDetector:
    """
    Detect concept drift by monitoring model performance over time
    """
    
    def __init__(self, baseline_performance, window_size=100, threshold=0.05):
        """
        Args:
            baseline_performance: Expected performance metrics (dict)
            window_size: Number of predictions to analyze
            threshold: Performance degradation threshold (e.g., 5%)
        """
        self.baseline_performance = baseline_performance
        self.window_size = window_size
        self.threshold = threshold
        self.prediction_history = []
    
    def add_prediction(self, prediction, actual, features=None):
        """
        Add a prediction result to the history
        
        Args:
            prediction: Model prediction
            actual: Actual ground truth (if available)
            features: Input features (optional, for analysis)
        """
        self.prediction_history.append({
            'prediction': prediction,
            'actual': actual,
            'features': features,
            'timestamp': datetime.now(),
            'correct': prediction == actual if actual is not None else None
        })
        
        # Keep only recent history
        if len(self.prediction_history) > self.window_size * 2:
            self.prediction_history = self.prediction_history[-self.window_size * 2:]
    
    def calculate_current_performance(self):
        """Calculate performance on recent predictions"""
        if len(self.prediction_history) < self.window_size:
            return None
        
        recent = self.prediction_history[-self.window_size:]
        
        # Filter only predictions with ground truth
        labeled = [p for p in recent if p['actual'] is not None]
        
        if len(labeled) < 10:  # Not enough labeled data
            return None
        
        # Calculate metrics
        correct = sum(1 for p in labeled if p['correct'])
        accuracy = correct / len(labeled)
        
        return {
            'accuracy': accuracy,
            'sample_size': len(labeled),
            'time_range': (labeled[0]['timestamp'], labeled[-1]['timestamp'])
        }
    
    def detect_concept_drift(self):
        """
        Detect if concept drift has occurred
        
        Returns:
            Dict with drift status and details
        """
        current_perf = self.calculate_current_performance()
        
        if current_perf is None:
            return {
                'drift_detected': False,
                'reason': 'Insufficient data',
                'current_performance': None
            }
        
        baseline_accuracy = self.baseline_performance.get('accuracy', 0.9)
        performance_drop = baseline_accuracy - current_perf['accuracy']
        
        drift_detected = performance_drop > self.threshold
        
        return {
            'drift_detected': drift_detected,
            'baseline_accuracy': baseline_accuracy,
            'current_accuracy': current_perf['accuracy'],
            'performance_drop': performance_drop,
            'threshold': self.threshold,
            'severity': 'HIGH' if performance_drop > self.threshold * 2 else 'MEDIUM' if drift_detected else 'LOW',
            'sample_size': current_perf['sample_size'],
            'recommendation': 'RETRAIN MODEL' if drift_detected else 'CONTINUE MONITORING'
        }

# ============================================================================
# INTEGRATED MONITORING PIPELINE
# ============================================================================

def setup_complete_monitoring(ws, model_name, baseline_data, features):
    """
    Complete monitoring setup combining all components
    """
    
    print("Setting up comprehensive model monitoring...")
    
    # 1. Register baseline dataset
    baseline_dataset = register_baseline_dataset(
        ws, 
        baseline_data_path='./data/baseline/',
        dataset_name=f'{model_name}_baseline'
    )
    
    # 2. Create drift detector
    target_dataset = Dataset.Tabular.from_delimited_files(
        path=ws.get_default_datastore().path('production_data/')
    )
    
    drift_detector = create_drift_detector(
        ws, 
        baseline_dataset, 
        target_dataset, 
        features
    )
    
    # 3. Configure alerts
    configure_drift_alerts(
        drift_detector,
        alert_emails=['ml-team@company.com', 'data-science@company.com']
    )
    
    # 4. Enable performance monitoring
    setup_performance_monitoring(ws, model_name, model_version='1')
    
    print("✓ Complete monitoring setup finished")
    
    return {
        'drift_detector': drift_detector,
        'baseline_dataset': baseline_dataset
    }

if __name__ == "__main__":
    # Example: Set up monitoring
    ws = setup_workspace()
    
    # Define features to monitor
    features = [
        'age', 'income', 'credit_score', 'account_balance',
        'transaction_frequency', 'customer_tenure'
    ]
    
    monitoring_components = setup_complete_monitoring(
        ws=ws,
        model_name='customer_churn_model',
        baseline_data='./data/training_data.csv',
        features=features
    )
    
    print("\n✓ Model monitoring is now active!")
    print("  - Data drift detection: Running weekly")
    print("  - Performance monitoring: Real-time via Application Insights")
    print("  - Alerts configured for ML team")
```

---

## Adversarial AI Risk Management

### Understanding Adversarial Attacks

```python
# adversarial_defense.py
"""
Comprehensive framework for detecting and defending against adversarial AI attacks
"""

import numpy as np
import tensorflow as tf
from tensorflow import keras
import pandas as pd
from sklearn.ensemble import IsolationForest
import hashlib

# ============================================================================
# ADVERSARIAL ATTACK TYPES & EXAMPLES
# ============================================================================

class AdversarialAttacks:
    """
    Demonstration of common adversarial attacks
    WARNING: For educational and defense purposes only
    """
    
    @staticmethod
    def fgsm_attack(model, images, labels, epsilon=0.1):
        """
        Fast Gradient Sign Method (FGSM) Attack
        Creates adversarial examples by adding noise in direction of gradient
        
        Args:
            model: Keras model
            images: Input images
            labels: True labels
            epsilon: Perturbation magnitude
        """
        images = tf.cast(images, tf.float32)
        labels = tf.cast(labels, tf.float32)
        
        with tf.GradientTape() as tape:
            tape.watch(images)
            predictions = model(images)
            loss = keras.losses.categorical_crossentropy(labels, predictions)
        
        # Get gradient of loss w.r.t input
        gradient = tape.gradient(loss, images)
        
        # Create adversarial example
        signed_grad = tf.sign(gradient)
        adversarial_images = images + epsilon * signed_grad
        
        # Clip to valid range [0, 1]
        adversarial_images = tf.clip_by_value(adversarial_images, 0, 1)
        
        return adversarial_images.numpy()
    
    @staticmethod
    def detect_adversarial_example(original, perturbed, threshold=0.01):
        """
        Simple detection: Check if perturbation is suspiciously uniform
        """
        diff = np.abs(perturbed - original)
        mean_perturbation = np.mean(diff)
        
        # Adversarial examples often have uniform small perturbations
        is_adversarial = mean_perturbation > threshold and mean_perturbation < threshold * 2
        
        return {
            'is_adversarial': is_adversarial,
            'mean_perturbation': mean_perturbation,
            'max_perturbation': np.max(diff)
        }

# ============================================================================
# INPUT VALIDATION & SANITIZATION
# ============================================================================

class InputValidator:
    """
    Validate inputs to detect anomalies and potential adversarial examples
    """
    
    def __init__(self, training_data, contamination=0.1):
        """
        Args:
            training_data: Normal training data for learning valid input space
            contamination: Expected proportion of outliers
        """
        self.training_data = training_data
        
        # Train anomaly detector on normal data
        self.anomaly_detector = IsolationForest(
            contamination=contamination,
            random_state=42
        )
        self.anomaly_detector.fit(training_data)
        
        # Calculate valid ranges
        self.feature_ranges = {
            i: {
                'min': training_data[:, i].min(),
                'max': training_data[:, i].max(),
                'mean': training_data[:, i].mean(),
                'std': training_data[:, i].std()
            }
            for i in range(training_data.shape[1])
        }
    
    def validate_input(self, input_data):
        """
        Comprehensive input validation
        
        Returns:
            Dict with validation results
        """
        issues = []
        
        # 1. Check for NaN or Inf
        if np.any(np.isnan(input_data)) or np.any(np.isinf(input_data)):
            issues.append("Contains NaN or Inf values")
        
        # 2. Check if within valid ranges
        for i, feature_range in self.feature_ranges.items():
            value = input_data[0, i] if len(input_data.shape) > 1 else input_data[i]
            
            # Check if outside training data range
            if value < feature_range['min'] or value > feature_range['max']:
                issues.append(f"Feature {i} out of range: {value}")
            
            # Check if statistically unusual (>3 std devs)
            z_score = abs(value - feature_range['mean']) / feature_range['std']
            if z_score > 3:
                issues.append(f"Feature {i} unusual (z-score: {z_score:.2f})")
        
        # 3. Anomaly detection
        anomaly_score = self.anomaly_detector.score_samples(input_data.reshape(1, -1))[0]
        is_anomaly = self.anomaly_detector.predict(input_data.reshape(1, -1))[0] == -1
        
        if is_anomaly:
            issues.append(f"Detected as anomaly (score: {anomaly_score:.4f})")
        
        # 4. Overall assessment
        is_valid = len(issues) == 0
        risk_level = 'HIGH' if len(issues) >= 3 else 'MEDIUM' if len(issues) >= 1 else 'LOW'
        
        return {
            'is_valid': is_valid,
            'risk_level': risk_level,
            'anomaly_score': anomaly_score,
            'issues': issues,
            'recommendation': 'REJECT' if risk_level == 'HIGH' else 'FLAG' if risk_level == 'MEDIUM' else 'ACCEPT'
        }
    
    def sanitize_input(self, input_data):
        """
        Sanitize input by clipping to valid ranges
        """
        sanitized = input_data.copy()
        
        for i, feature_range in self.feature_ranges.items():
            # Clip to min/max from training data
            sanitized[:, i] = np.clip(
                sanitized[:, i],
                feature_range['min'],
                feature_range['max']
            )
        
        return sanitized

# ============================================================================
# ADVERSARIAL TRAINING
# ============================================================================

def adversarial_training(model, X_train, y_train, epochs=10, epsilon=0.1):
    """
    Train model with adversarial examples to improve robustness
    
    Args:
        model: Keras model
        X_train: Training data
        y_train: Training labels
        epochs: Number of training epochs
        epsilon: Adversarial perturbation size
    """
    print("Starting adversarial training...")
    
    for epoch in range(epochs):
        print(f"\nEpoch {epoch + 1}/{epochs}")
        
        # Generate adversarial examples
        adversarial_X = AdversarialAttacks.fgsm_attack(
            model, X_train, y_train, epsilon=epsilon
        )
        
        # Combine original and adversarial data
        combined_X = np.concatenate([X_train, adversarial_X], axis=0)
        combined_y = np.concatenate([y_train, y_train], axis=0)
        
        # Shuffle
        indices = np.random.permutation(len(combined_X))
        combined_X = combined_X[indices]
        combined_y = combined_y[indices]
        
        # Train on combined dataset
        history = model.fit(
            combined_X, combined_y,
            batch_size=32,
            epochs=1,
            verbose=1,
            validation_split=0.1
        )
        
        print(f"  Accuracy: {history.history['accuracy'][0]:.4f}")
        print(f"  Val Accuracy: {history.history['val_accuracy'][0]:.4f}")
    
    print("\n✓ Adversarial training complete")
    return model

# ============================================================================
# PREDICTION CONFIDENCE MONITORING
# ============================================================================

class ConfidenceMonitor:
    """
    Monitor prediction confidence to detect potential adversarial attacks
    """
    
    def __init__(self, confidence_threshold=0.7, entropy_threshold=1.5):
        """
        Args:
            confidence_threshold: Minimum confidence for normal predictions
            entropy_threshold: Maximum entropy for normal predictions
        """
        self.confidence_threshold = confidence_threshold
        self.entropy_threshold = entropy_threshold
        self.prediction_history = []
    
    def calculate_entropy(self, probabilities):
        """Calculate prediction entropy (uncertainty)"""
        # Add small value to avoid log(0)
        probabilities = np.clip(probabilities, 1e-10, 1.0)
        entropy = -np.sum(probabilities * np.log(probabilities))
        return entropy
    
    def analyze_prediction(self, probabilities, input_data=None):
        """
        Analyze a prediction for signs of adversarial attack
        
        Args:
            probabilities: Model output probabilities
            input_data: Input features (optional)
        
        Returns:
            Dict with analysis results
        """
        max_confidence = np.max(probabilities)
        predicted_class = np.argmax(probabilities)
        entropy = self.calculate_entropy(probabilities)
        
        flags = []
        
        # Flag 1: Low confidence
        if max_confidence < self.confidence_threshold:
            flags.append(f"Low confidence: {max_confidence:.3f}")
        
        # Flag 2: High entropy (uncertainty)
        if entropy > self.entropy_threshold:
            flags.append(f"High entropy: {entropy:.3f}")
        
        # Flag 3: Multiple high probabilities (confusion)
        high_prob_count = np.sum(probabilities > 0.3)
        if high_prob_count > 2:
            flags.append(f"Multiple high probabilities: {high_prob_count}")
        
        # Flag 4: Probability distribution suspicious
        # (e.g., very uniform when should be peaked)
        prob_std = np.std(probabilities)
        if prob_std < 0.1 and len(probabilities) > 2:
            flags.append(f"Suspicious uniform distribution (std: {prob_std:.3f})")
        
        # Overall risk assessment
        risk_level = 'HIGH' if len(flags) >= 2 else 'MEDIUM' if len(flags) == 1 else 'LOW'
        
        result = {
            'predicted_class': int(predicted_class),
            'confidence': float(max_confidence),
            'entropy': float(entropy),
            'risk_level': risk_level,
            'flags': flags,
            'probabilities': probabilities.tolist(),
            'recommendation': 'MANUAL_REVIEW' if risk_level == 'HIGH' else 'FLAG' if risk_level == 'MEDIUM' else 'ACCEPT'
        }
        
        # Log to history
        self.prediction_history.append(result)
        
        return result

# ============================================================================
# MODEL FINGERPRINTING & EXTRACTION DEFENSE
# ============================================================================

class ModelProtection:
    """
    Protect against model extraction and inversion attacks
    """
    
    def __init__(self, model, query_limit=1000, time_window=3600):
        """
        Args:
            model: Model to protect
            query_limit: Max queries per user per time window
            time_window: Time window in seconds
        """
        self.model = model
        self.query_limit = query_limit
        self.time_window = time_window
        self.query_log = {}
    
    def get_user_hash(self, user_id, ip_address):
        """Create unique hash for user identification"""
        identifier = f"{user_id}:{ip_address}"
        return hashlib.sha256(identifier.encode()).hexdigest()
    
    def check_rate_limit(self, user_hash):
        """
        Check if user has exceeded query rate limit
        """
        current_time = datetime.now().timestamp()
        
        # Initialize user if not seen before
        if user_hash not in self.query_log:
            self.query_log[user_hash] = []
        
        # Remove queries outside time window
        self.query_log[user_hash] = [
            t for t in self.query_log[user_hash]
            if current_time - t < self.time_window
        ]
        
        # Check limit
        if len(self.query_log[user_hash]) >= self.query_limit:
            return {
                'allowed': False,
                'reason': 'Rate limit exceeded',
                'queries_in_window': len(self.query_log[user_hash]),
                'reset_time': min(self.query_log[user_hash]) + self.time_window
            }
        
        # Log this query
        self.query_log[user_hash].append(current_time)
        
        return {
            'allowed': True,
            'queries_in_window': len(self.query_log[user_hash]),
            'remaining': self.query_limit - len(self.query_log[user_hash])
        }
    
    def add_noise_to_prediction(self, probabilities, noise_level=0.01):
        """
        Add small noise to predictions to defend against extraction
        """
        noise = np.random.normal(0, noise_level, size=probabilities.shape)
        noisy_probs = probabilities + noise
        
        # Ensure still valid probabilities
        noisy_probs = np.clip(noisy_probs, 0, 1)
        noisy_probs = noisy_probs / np.sum(noisy_probs)  # Renormalize
        
        return noisy_probs
    
    def protected_predict(self, input_data, user_id, ip_address, add_noise=True):
        """
        Make prediction with protection mechanisms
        """
        user_hash = self.get_user_hash(user_id, ip_address)
        
        # Check rate limit
        rate_check = self.check_rate_limit(user_hash)
        if not rate_check['allowed']:
            return {
                'success': False,
                'error': rate_check['reason'],
                'reset_time': rate_check['reset_time']
            }
        
        # Make prediction
        probabilities = self.model.predict(input_data)[0]
        
        # Add noise if enabled
        if add_noise:
            probabilities = self.add_noise_to_prediction(probabilities)
        
        predicted_class = np.argmax(probabilities)
        confidence = np.max(probabilities)
        
        return {
            'success': True,
            'predicted_class': int(predicted_class),
            'confidence': float(confidence),
            'queries_remaining': rate_check['remaining'],
            # Optionally don't return full probability distribution
            # 'probabilities': probabilities.tolist()
        }

# ============================================================================
# COMPREHENSIVE ADVERSARIAL DEFENSE PIPELINE
# ============================================================================

class AdversarialDefensePipeline:
    """
    Complete pipeline for defending against adversarial attacks
    """
    
    def __init__(self, model, training_data):
        """
        Initialize defense pipeline
        
        Args:
            model: ML model to protect
            training_data: Normal training data for validation
        """
        self.model = model
        self.input_validator = InputValidator(training_data)
        self.confidence_monitor = ConfidenceMonitor()
        self.model_protection = ModelProtection(model)
        
        print("✓ Adversarial defense pipeline initialized")
    
    def secure_predict(self, input_data, user_id, ip_address):
        """
        Make prediction with full security checks
        
        Returns:
            Dict with prediction and security assessment
        """
        # Step 1: Input validation
        validation = self.input_validator.validate_input(input_data)
        
        if validation['risk_level'] == 'HIGH':
            return {
                'success': False,
                'error': 'Input validation failed',
                'reason': 'High-risk input detected',
                'issues': validation['issues']
            }
        
        # Step 2: Sanitize input
        sanitized_input = self.input_validator.sanitize_input(input_data.reshape(1, -1))
        
        # Step 3: Rate limiting & model protection
        prediction = self.model_protection.protected_predict(
            sanitized_input,
            user_id,
            ip_address,
            add_noise=True
        )
        
        if not prediction['success']:
            return prediction
        
        # Step 4: Make full prediction for monitoring
        probabilities = self.model.predict(sanitized_input)[0]
        
        # Step 5: Confidence monitoring
        confidence_analysis = self.confidence_monitor.analyze_prediction(probabilities)
        
        # Step 6: Compile result
        return {
            'success': True,
            'predicted_class': prediction['predicted_class'],
            'confidence': prediction['confidence'],
            'security_checks': {
                'input_validation': validation['risk_level'],
                'confidence_analysis': confidence_analysis['risk_level'],
                'queries_remaining': prediction['queries_remaining']
            },
            'flags': validation['issues'] + confidence_analysis['flags'],
            'recommendation': confidence_analysis['recommendation']
        }

# ============================================================================
# EXAMPLE USAGE
# ============================================================================

def example_adversarial_defense():
    """Complete example of adversarial defense"""
    
    # Load model and data
    from tensorflow.keras.datasets import mnist
    from tensorflow.keras.models import Sequential
    from tensorflow.keras.layers import Dense, Flatten
    from tensorflow.keras.utils import to_categorical
    
    # Load MNIST data
    (X_train, y_train), (X_test, y_test) = mnist.load_data()
    X_train = X_train / 255.0
    X_test = X_test / 255.0
    y_train = to_categorical(y_train)
    y_test = to_categorical(y_test)
    
    # Simple model
    model = Sequential([
        Flatten(input_shape=(28, 28)),
        Dense(128, activation='relu'),
        Dense(10, activation='softmax')
    ])
    model.compile(optimizer='adam', loss='categorical_crossentropy', metrics=['accuracy'])
    model.fit(X_train, y_train, epochs=3, batch_size=32, validation_split=0.1, verbose=0)
    
    print("✓ Model trained")
    
    # Initialize defense pipeline
    training_features = X_train.reshape(X_train.shape[0], -1)[:1000]
    defense_pipeline = AdversarialDefensePipeline(model, training_features)
    
    # Test normal prediction
    print("\n--- Testing Normal Input ---")
    test_input = X_test[0].flatten()
    result = defense_pipeline.secure_predict(
        test_input,
        user_id='user123',
        ip_address='192.168.1.1'
    )
    print(f"Prediction: {result['predicted_class']}, Confidence: {result['confidence']:.3f}")
    print(f"Security: {result['security_checks']}")
    
    # Test adversarial example
    print("\n--- Testing Adversarial Input ---")
    adversarial_input = AdversarialAttacks.fgsm_attack(
        model,
        X_test[0:1],
        y_test[0:1],
        epsilon=0.2
    )[0].flatten()
    
    adv_result = defense_pipeline.secure_predict(
        adversarial_input,
        user_id='user123',
        ip_address='192.168.1.1'
    )
    print(f"Prediction: {adv_result['predicted_class']}, Confidence: {adv_result['confidence']:.3f}")
    print(f"Security: {adv_result['security_checks']}")
    print(f"Flags: {adv_result['flags']}")

if __name__ == "__main__":
    example_adversarial_defense()
```

---

## Automated Alerting & Response

### Setting Up Alerts in Azure Monitor

```python
# azure_monitoring_alerts.py
"""
Configure Azure Monitor alerts for model degradation and drift
"""

from azure.identity import DefaultAzureCredential
from azure.mgmt.monitor import MonitorManagementClient
from azure.mgmt.monitor.models import *
from azureml.core import Workspace
import json

def create_drift_alert(subscription_id, resource_group, workspace_name):
    """
    Create alert when data drift is detected
    """
    credential = DefaultAzureCredential()
    monitor_client = MonitorManagementClient(credential, subscription_id)
    
    ws = Workspace.get(
        name=workspace_name,
        subscription_id=subscription_id,
        resource_group=resource_group
    )
    
    # Define alert rule
    alert_rule = AlertRule Specification(
        name="DataDriftAlert",
        description="Alert when data drift exceeds threshold",
        is_enabled=True,
        condition=ThresholdRuleCondition(
            data_source=RuleMetricDataSource(
                resource_uri=ws.id,
                metric_name="data_drift_magnitude"
            ),
            operator="GreaterThan",
            threshold=0.3,  # Drift threshold
            window_size="PT1H"  # 1 hour window
        ),
        actions=[
            RuleEmailAction(
                send_to_service_owners=False,
                custom_emails=[
                    "ml-team@company.com",
                    "data-science-lead@company.com"
                ]
            ),
            RuleWebhookAction(
                service_uri="https://your-webhook.com/drift-alert",
                properties={
                    "severity": "high",
                    "alert_type": "data_drift"
                }
            )
        ]
    )
    
    # Create alert
    monitor_client.alert_rules.create_or_update(
        resource_group_name=resource_group,
        rule_name="DataDriftAlert",
        parameters=alert_rule
    )
    
    print("✓ Drift alert configured")

def create_performance_alert(subscription_id, resource_group, model_service_name):
    """
    Create alert when model performance degrades
    """
    credential = DefaultAzureCredential()
    monitor_client = MonitorManagementClient(credential, subscription_id)
    
    # Alert for accuracy drop
    alert_rule = MetricAlertResource(
        location="global",
        description="Alert when model accuracy drops below threshold",
        severity=2,  # Warning
        enabled=True,
        scopes=[
            f"/subscriptions/{subscription_id}/resourceGroups/{resource_group}/providers/Microsoft.MachineLearningServices/workspaces/..."
        ],
        evaluation_frequency="PT5M",  # Evaluate every 5 minutes
        window_size="PT15M",  # Look at 15 minute window
        criteria=MetricAlertSingleResourceMultipleMetricCriteria(
            all_of=[
                MetricCriteria(
                    name="AccuracyDrop",
                    metric_name="model_accuracy",
                    operator="LessThan",
                    threshold=0.85,  # Alert if accuracy < 85%
                    time_aggregation="Average"
                )
            ]
        ),
        actions=[
            ActionGroup(
                action_group_id="/subscriptions/.../actionGroups/MLTeam"
            )
        ]
    )
    
    monitor_client.metric_alerts.create_or_update(
        resource_group_name=resource_group,
        rule_name="ModelAccuracyAlert",
        parameters=alert_rule
    )
    
    print("✓ Performance alert configured")

def create_anomaly_alert(subscription_id, resource_group, app_insights_id):
    """
    Create alert for anomalous prediction patterns
    """
    # Query for anomalous prediction rates
    query = """
    requests
    | where timestamp > ago(1h)
    | where name contains 'predict'
    | summarize 
        RequestCount = count(),
        AvgConfidence = avg(toint(customDimensions.confidence)),
        LowConfidenceCount = countif(toint(customDimensions.confidence) < 70)
    | where LowConfidenceCount > RequestCount * 0.2  // More than 20% low confidence
    """
    
    alert_rule = ScheduledQueryRule(
        location="global",
        description="Alert on high rate of low-confidence predictions",
        enabled=True,
        scopes=[app_insights_id],
        evaluation_frequency="PT5M",
        window_size="PT15M",
        criteria=ScheduledQueryRuleCriteria(
            all_of=[
                Condition(
                    query=query,
                    time_aggregation="Total",
                    operator="GreaterThan",
                    threshold=100,  # More than 100 low-confidence predictions
                    failing_periods=ConsecutiveFailingPeriods(
                        number_of_evaluation_periods=2,
                        min_failing_periods_to_alert=2
                    )
                )
            ]
        ),
        actions=ActionGroups(
            action_groups=["/subscriptions/.../actionGroups/MLTeam"]
        )
    )
    
    print("✓ Anomaly alert configured")

# Example: Set up all alerts
if __name__ == "__main__":
    subscription_id = "your-subscription-id"
    resource_group = "your-resource-group"
    workspace_name = "your-workspace"
    
    create_drift_alert(subscription_id, resource_group, workspace_name)
    create_performance_alert(subscription_id, resource_group, "model-service")
    create_anomaly_alert(subscription_id, resource_group, "app-insights-id")
    
    print("\n✓ All monitoring alerts configured!")
```

---

## Automated Retraining Pipeline

```python
# automated_retraining.py
"""
Automated pipeline triggered by drift detection or performance degradation
"""

from azureml.core import Workspace, Experiment, ScriptRunConfig, Environment
from azureml.pipeline.core import Pipeline, PipelineData
from azureml.pipeline.steps import PythonScriptStep
from azureml.core.runconfig import RunConfiguration

def create_retraining_pipeline(ws, drift_threshold=0.3):
    """
    Create automated retraining pipeline triggered by drift
    """
    
    # Create run configuration
    run_config = RunConfiguration()
    run_config.environment = Environment.get(ws, name="AzureML-sklearn-1.0")
    
    # Step 1: Data validation
    data_validation_step = PythonScriptStep(
        name="Validate Data",
        script_name="validate_data.py",
        arguments=[
            '--drift-threshold', drift_threshold
        ],
        compute_target='cpu-cluster',
        runconfig=run_config,
        allow_reuse=False
    )
    
    # Step 2: Retrain model
    retrain_step = PythonScriptStep(
        name="Retrain Model",
        script_name="train_model.py",
        compute_target='gpu-cluster',
        runconfig=run_config,
        allow_reuse=False
    )
    retrain_step.run_after(data_validation_step)
    
    # Step 3: Evaluate new model
    evaluate_step = PythonScriptStep(
        name="Evaluate Model",
        script_name="evaluate_model.py",
        arguments=[
            '--baseline-accuracy', 0.85
        ],
        compute_target='cpu-cluster',
        runconfig=run_config,
        allow_reuse=False
    )
    evaluate_step.run_after(retrain_step)
    
    # Step 4: Deploy if better
    deploy_step = PythonScriptStep(
        name="Deploy Model",
        script_name="deploy_model.py",
        compute_target='cpu-cluster',
        runconfig=run_config,
        allow_reuse=False
    )
    deploy_step.run_after(evaluate_step)
    
    # Create pipeline
    pipeline = Pipeline(
        workspace=ws,
        steps=[data_validation_step, retrain_step, evaluate_step, deploy_step]
    )
    
    return pipeline

def trigger_retraining(ws, pipeline, reason="manual"):
    """
    Trigger the retraining pipeline
    """
    print(f"Triggering retraining pipeline: {reason}")
    
    experiment = Experiment(ws, 'model-retraining')
    pipeline_run = experiment.submit(pipeline)
    
    print(f"Pipeline submitted: {pipeline_run.id}")
    print(f"Monitor at: {pipeline_run.get_portal_url()}")
    
    return pipeline_run

# Webhook handler for automated triggering
def drift_webhook_handler(request):
    """
    Azure Function to handle drift detection webhook
    """
    import azure.functions as func
    import json
    
    # Parse webhook payload
    payload = json.loads(request.get_body())
    
    drift_magnitude = payload.get('drift_magnitude', 0)
    affected_features = payload.get('features', [])
    
    if drift_magnitude > 0.3:
        # Connect to workspace
        ws = Workspace.from_config()
        
        # Create and trigger pipeline
        pipeline = create_retraining_pipeline(ws)
        run = trigger_retraining(
            ws, 
            pipeline, 
            reason=f"Drift detected: {drift_magnitude:.3f} in {len(affected_features)} features"
        )
        
        return func.HttpResponse(
            json.dumps({
                'status': 'retraining_triggered',
                'run_id': run.id,
                'reason': f'Drift magnitude {drift_magnitude:.3f}'
            }),
            status_code=200
        )
    
    return func.HttpResponse(
        json.dumps({'status': 'no_action_needed'}),
        status_code=200
    )
```

---

## Best Practices Checklist

### Model Monitoring

- [x] **Baseline dataset registered** for drift comparison
- [x] **Data drift detection configured** with appropriate thresholds
- [x] **Performance metrics tracked** in production (accuracy, latency, throughput)
- [x] **Feature importance monitored** for unexpected changes
- [x] **Prediction distribution tracked** for concept drift
- [x] **Application Insights enabled** for real-time telemetry
- [x] **Automated alerts configured** for drift and degradation
- [x] **Dashboard created** for stakeholder visibility

### Adversarial Defense

- [x] **Input validation implemented** with range and anomaly checks
- [x] **Rate limiting configured** to prevent extraction attacks
- [x] **Confidence monitoring enabled** to flag suspicious predictions
- [x] **Adversarial training considered** for critical models
- [x] **Model predictions logged** for audit trail
- [x] **Prediction confidence thresholds** set for manual review
- [x] **Regular security audits** scheduled
- [x] **Incident response plan** documented

### Retraining Strategy

- [x] **Retraining triggers defined** (drift threshold, performance drop, time-based)
- [x] **Automated retraining pipeline** created and tested
- [x] **A/B testing framework** for comparing old vs new models
- [x] **Rollback procedure** documented and tested
- [x] **Model versioning** implemented
- [x] **Champion/challenger deployment** strategy defined

---

## Documentation & Reporting

### Monitoring Dashboard Template

```python
# monitoring_dashboard.py
"""
Create Power BI or custom dashboard for model monitoring
"""

def generate_monitoring_report(drift_results, performance_metrics, period='weekly'):
    """
    Generate monitoring report for stakeholders
    """
    report = {
        'period': period,
        'summary': {
            'models_monitored': 5,
            'drift_detected': len([f for f, r in drift_results.items() if r['drift_detected']]),
            'average_accuracy': np.mean([m['accuracy'] for m in performance_metrics]),
            'alerts_triggered': 2
        },
        'drift_details': drift_results,
        'performance_trends': performance_metrics,
        'recommendations': []
    }
    
    # Add recommendations
    if report['summary']['drift_detected'] > 0:
        report['recommendations'].append("URGENT: Retrain models with drifted features")
    
    if report['summary']['average_accuracy'] < 0.85:
        report['recommendations'].append("INVESTIGATE: Model performance below threshold")
    
    return report
```

---

## Resources & References

**Azure Documentation**:
- [Azure ML Model Monitoring](https://docs.microsoft.com/en-us/azure/machine-learning/how-to-monitor-models)
- [Data Drift Detection](https://docs.microsoft.com/en-us/azure/machine-learning/how-to-monitor-datasets)
- [Application Insights for ML](https://docs.microsoft.com/en-us/azure/machine-learning/how-to-enable-app-insights)

**Research Papers**:
- "A Survey on Data Drift Adaptation" (2023)
- "Adversarial Machine Learning" - Goodfellow et al.
- "Certified Defenses Against Adversarial Examples" - Cohen et al.

**Tools**:
- [Evidently AI](https://github.com/evidentlyai/evidently) - Open source ML monitoring
- [Alibi Detect](https://github.com/SeldonIO/alibi-detect) - Drift detection library
- [Adversarial Robustness Toolbox](https://github.com/Trusted-AI/adversarial-robustness-toolbox)

---

**Document Version:** 1.0  
**Last Updated:** January 12, 2026  
**Owner:** AI Delivery Methodology Team

*This guide is part of the AI Delivery Methodology. For related materials, see:*
- *[Test & Evaluate Phase Checklist](../checklists/test-evaluate-phase-checklist.md)*
- *[Operate & Care Phase Guide](../guides/operate-care-phase-complete-guide.md)*
- *[Risk Register Template](../templates/05-risk-register.md)*
