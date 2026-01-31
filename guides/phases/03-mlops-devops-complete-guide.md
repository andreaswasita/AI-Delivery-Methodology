# MLOps & DevOps Complete Guide
## Production-Grade ML Engineering for Scalable AI Systems

## Document Information

**Purpose**: Comprehensive MLOps/DevOps framework for scaling AI delivery  
**Audience**: ML Engineers, DevOps Engineers, Platform Teams, Solution Architects  
**Technologies**: Azure DevOps, Azure ML, GitHub Actions, Docker, Kubernetes  
**Date**: January 2026

---

## Overview

### The MLOps Challenge

**87% of data science projects never make it to production.** The gap between experimentation and production is caused by:

- Lack of automated pipelines for model training and deployment
- Manual processes that don't scale
- Inconsistent environments between dev, test, and production
- Poor model versioning and lineage tracking
- Insufficient monitoring and governance

This guide provides **production-ready MLOps patterns** to bridge the gap from experimentation to scalable production.

---

## MLOps Maturity Model

### Level 0: Manual Process
- Manual model training
- Manual deployment
- No pipeline automation
- Script-based processes
- No versioning

### Level 1: ML Pipeline Automation
- Automated training pipeline
- Experimental tracking
- Model registry
- Basic versioning
- Manual deployment

### Level 2: CI/CD Pipeline Automation
- Automated build and test
- Automated deployment
- Continuous training
- Model validation gates
- Basic monitoring

### Level 3: Full MLOps Automation
- Continuous training and deployment
- A/B testing automation
- Feature store integration
- Advanced monitoring and alerting
- Automated retraining triggers
- Full audit trail

### Level 4: MLOps at Scale
- Multi-model orchestration
- Feature store at scale
- Auto-scaling infrastructure
- Advanced governance
- Portfolio management
- Cross-project reuse

**Goal**: Reach Level 3-4 for production AI systems

---

## MLOps Architecture

### Core Components

```
┌─────────────────────────────────────────────────────────────────┐
│                     MLOps Platform Architecture                  │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐            │
│  │  Git Repo   │  │  Azure      │  │  Model      │            │
│  │  (Code,     │→ │  DevOps/    │→ │  Registry   │            │
│  │   Config)   │  │  GitHub     │  │             │            │
│  └─────────────┘  └─────────────┘  └─────────────┘            │
│                           ↓                ↓                     │
│                    ┌──────────────────────────┐                 │
│                    │   Training Pipeline      │                 │
│                    │  - Data Validation       │                 │
│                    │  - Feature Engineering   │                 │
│                    │  - Model Training        │                 │
│                    │  - Model Validation      │                 │
│                    └──────────────────────────┘                 │
│                           ↓                                      │
│                    ┌──────────────────────────┐                 │
│                    │   Deployment Pipeline    │                 │
│                    │  - Model Packaging       │                 │
│                    │  - Integration Tests     │                 │
│                    │  - Deployment to Staging │                 │
│                    │  - Smoke Tests           │                 │
│                    │  - Production Deployment │                 │
│                    └──────────────────────────┘                 │
│                           ↓                                      │
│  ┌──────────────────────────────────────────────────┐          │
│  │            Production Environment                 │          │
│  │  - Model Serving (AKS/ACI)                       │          │
│  │  - Monitoring & Logging                          │          │
│  │  - A/B Testing                                   │          │
│  │  - Drift Detection                               │          │
│  └──────────────────────────────────────────────────┘          │
│                           ↓                                      │
│                    ┌──────────────────────────────┐            │
│                    │   Feedback Loop              │            │
│                    │  - Performance Metrics       │            │
│                    │  - Drift Alerts              │            │
│                    │  - Trigger Retraining        │            │
│                    └──────────────────────────────┘            │
└─────────────────────────────────────────────────────────────────┘
```

---

## CI/CD Pipeline Templates

### 1. Azure DevOps - Training Pipeline

```yaml
# azure-pipelines-training.yml
# Automated ML model training pipeline with validation gates

name: Model-Training-Pipeline-$(Date:yyyyMMdd)$(Rev:.r)

trigger:
  branches:
    include:
    - main
    - develop
  paths:
    include:
    - src/training/*
    - src/data/*
    - config/training_config.yaml

variables:
  azureSubscription: 'Azure-ML-Service-Connection'
  resourceGroup: 'rg-aiplatform-prod'
  workspaceName: 'mlw-aiplatform-prod'
  experimentName: 'customer_churn_experiment'
  computeTarget: 'gpu-cluster'
  minimumAccuracy: 0.85
  modelName: 'customer-churn-model'

stages:
- stage: DataValidation
  displayName: 'Data Quality & Validation'
  jobs:
  - job: ValidateData
    displayName: 'Validate Training Data'
    pool:
      vmImage: 'ubuntu-latest'
    steps:
    - task: UsePythonVersion@0
      inputs:
        versionSpec: '3.9'
        addToPath: true
    
    - task: Bash@3
      displayName: 'Install Dependencies'
      inputs:
        targetType: 'inline'
        script: |
          python -m pip install --upgrade pip
          pip install -r requirements.txt
          pip install azureml-sdk pandas numpy scikit-learn great-expectations
    
    - task: AzureCLI@2
      displayName: 'Run Data Validation'
      inputs:
        azureSubscription: $(azureSubscription)
        scriptType: 'bash'
        scriptLocation: 'inlineScript'
        inlineScript: |
          python src/data_validation/validate_data.py \
            --workspace-name $(workspaceName) \
            --resource-group $(resourceGroup) \
            --dataset-name training_dataset \
            --expectations-file config/data_expectations.json
    
    - task: PublishTestResults@2
      displayName: 'Publish Data Validation Results'
      inputs:
        testResultsFormat: 'JUnit'
        testResultsFiles: '**/data-validation-results.xml'
        failTaskOnFailedTests: true

- stage: ModelTraining
  displayName: 'Model Training & Experimentation'
  dependsOn: DataValidation
  condition: succeeded()
  jobs:
  - job: TrainModel
    displayName: 'Train ML Model'
    pool:
      vmImage: 'ubuntu-latest'
    steps:
    - task: UsePythonVersion@0
      inputs:
        versionSpec: '3.9'
    
    - task: Bash@3
      displayName: 'Install Azure ML SDK'
      inputs:
        targetType: 'inline'
        script: |
          pip install azureml-sdk azureml-core azureml-mlflow
    
    - task: AzureCLI@2
      displayName: 'Submit Training Job to Azure ML'
      inputs:
        azureSubscription: $(azureSubscription)
        scriptType: 'bash'
        scriptLocation: 'inlineScript'
        inlineScript: |
          python src/training/submit_training.py \
            --workspace-name $(workspaceName) \
            --resource-group $(resourceGroup) \
            --experiment-name $(experimentName) \
            --compute-target $(computeTarget) \
            --config config/training_config.yaml
      env:
        BUILD_BUILDNUMBER: $(Build.BuildNumber)
    
    - task: Bash@3
      displayName: 'Wait for Training Completion'
      inputs:
        targetType: 'inline'
        script: |
          python src/training/wait_for_completion.py \
            --workspace-name $(workspaceName) \
            --resource-group $(resourceGroup) \
            --experiment-name $(experimentName) \
            --timeout 7200
    
    - task: Bash@3
      displayName: 'Get Training Metrics'
      inputs:
        targetType: 'inline'
        script: |
          python src/training/get_metrics.py \
            --workspace-name $(workspaceName) \
            --resource-group $(resourceGroup) \
            --experiment-name $(experimentName) \
            --output metrics.json
    
    - task: PublishPipelineArtifact@1
      displayName: 'Publish Training Metrics'
      inputs:
        targetPath: 'metrics.json'
        artifact: 'training-metrics'

- stage: ModelValidation
  displayName: 'Model Validation & Quality Gates'
  dependsOn: ModelTraining
  condition: succeeded()
  jobs:
  - job: ValidateModel
    displayName: 'Validate Model Performance'
    pool:
      vmImage: 'ubuntu-latest'
    steps:
    - task: DownloadPipelineArtifact@2
      displayName: 'Download Training Metrics'
      inputs:
        artifact: 'training-metrics'
        path: $(System.DefaultWorkingDirectory)
    
    - task: UsePythonVersion@0
      inputs:
        versionSpec: '3.9'
    
    - task: Bash@3
      displayName: 'Validate Model Metrics'
      inputs:
        targetType: 'inline'
        script: |
          python src/validation/validate_metrics.py \
            --metrics-file metrics.json \
            --minimum-accuracy $(minimumAccuracy) \
            --minimum-precision 0.80 \
            --minimum-recall 0.80
    
    - task: AzureCLI@2
      displayName: 'Run Fairness Assessment'
      inputs:
        azureSubscription: $(azureSubscription)
        scriptType: 'bash'
        scriptLocation: 'inlineScript'
        inlineScript: |
          python src/validation/fairness_assessment.py \
            --workspace-name $(workspaceName) \
            --resource-group $(resourceGroup) \
            --model-name $(modelName) \
            --sensitive-features age,gender \
            --fairness-threshold 0.8
    
    - task: AzureCLI@2
      displayName: 'Run Explainability Analysis'
      inputs:
        azureSubscription: $(azureSubscription)
        scriptType: 'bash'
        scriptLocation: 'inlineScript'
        inlineScript: |
          python src/validation/explainability_analysis.py \
            --workspace-name $(workspaceName) \
            --resource-group $(resourceGroup) \
            --model-name $(modelName)
    
    - task: PublishTestResults@2
      displayName: 'Publish Validation Results'
      inputs:
        testResultsFormat: 'JUnit'
        testResultsFiles: '**/validation-results.xml'
        failTaskOnFailedTests: true

- stage: ModelRegistration
  displayName: 'Model Registration'
  dependsOn: ModelValidation
  condition: succeeded()
  jobs:
  - job: RegisterModel
    displayName: 'Register Model in Model Registry'
    pool:
      vmImage: 'ubuntu-latest'
    steps:
    - task: AzureCLI@2
      displayName: 'Register Model'
      inputs:
        azureSubscription: $(azureSubscription)
        scriptType: 'bash'
        scriptLocation: 'inlineScript'
        inlineScript: |
          python src/registration/register_model.py \
            --workspace-name $(workspaceName) \
            --resource-group $(resourceGroup) \
            --model-name $(modelName) \
            --experiment-name $(experimentName) \
            --tags "build_id=$(Build.BuildId)" \
                   "build_number=$(Build.BuildNumber)" \
                   "branch=$(Build.SourceBranchName)" \
                   "commit=$(Build.SourceVersion)"
    
    - task: Bash@3
      displayName: 'Generate Model Card'
      inputs:
        targetType: 'inline'
        script: |
          python src/documentation/generate_model_card.py \
            --workspace-name $(workspaceName) \
            --resource-group $(resourceGroup) \
            --model-name $(modelName) \
            --output model-card.md
    
    - task: PublishPipelineArtifact@1
      displayName: 'Publish Model Card'
      inputs:
        targetPath: 'model-card.md'
        artifact: 'model-card'
    
    - task: Bash@3
      displayName: 'Notify Team'
      inputs:
        targetType: 'inline'
        script: |
          echo "Model $(modelName) registered successfully!"
          echo "Build: $(Build.BuildNumber)"
          echo "Ready for deployment approval"
```

---

### 2. Azure DevOps - Deployment Pipeline

```yaml
# azure-pipelines-deployment.yml
# Automated model deployment with canary and blue/green strategies

name: Model-Deployment-Pipeline-$(Date:yyyyMMdd)$(Rev:.r)

trigger: none  # Triggered manually or by training pipeline

pr: none

variables:
  azureSubscription: 'Azure-ML-Service-Connection'
  resourceGroup: 'rg-aiplatform-prod'
  workspaceName: 'mlw-aiplatform-prod'
  modelName: 'customer-churn-model'
  aksCluster: 'aks-ml-prod'
  namespace: 'ml-models'

stages:
- stage: BuildContainer
  displayName: 'Build Model Container'
  jobs:
  - job: BuildDockerImage
    displayName: 'Build Docker Image'
    pool:
      vmImage: 'ubuntu-latest'
    steps:
    - task: Docker@2
      displayName: 'Build Model Serving Image'
      inputs:
        command: 'build'
        repository: '$(modelName)'
        dockerfile: 'src/deployment/Dockerfile'
        tags: |
          $(Build.BuildId)
          latest
        arguments: '--build-arg MODEL_NAME=$(modelName)'
    
    - task: Docker@2
      displayName: 'Push to Container Registry'
      inputs:
        command: 'push'
        repository: '$(modelName)'
        tags: |
          $(Build.BuildId)
          latest

- stage: DeployToStaging
  displayName: 'Deploy to Staging Environment'
  dependsOn: BuildContainer
  condition: succeeded()
  jobs:
  - deployment: DeployStaging
    displayName: 'Deploy to Staging'
    environment: 'ML-Staging'
    pool:
      vmImage: 'ubuntu-latest'
    strategy:
      runOnce:
        deploy:
          steps:
          - task: AzureCLI@2
            displayName: 'Deploy Model to ACI (Staging)'
            inputs:
              azureSubscription: $(azureSubscription)
              scriptType: 'bash'
              scriptLocation: 'inlineScript'
              inlineScript: |
                python src/deployment/deploy_to_aci.py \
                  --workspace-name $(workspaceName) \
                  --resource-group $(resourceGroup) \
                  --model-name $(modelName) \
                  --service-name $(modelName)-staging \
                  --environment staging
          
          - task: Bash@3
            displayName: 'Run Smoke Tests'
            inputs:
              targetType: 'inline'
              script: |
                python tests/smoke_tests.py \
                  --endpoint $(staging-endpoint) \
                  --test-data tests/data/smoke_test_data.json
          
          - task: Bash@3
            displayName: 'Run Integration Tests'
            inputs:
              targetType: 'inline'
              script: |
                pytest tests/integration/ \
                  --endpoint $(staging-endpoint) \
                  --junitxml=test-results.xml
          
          - task: PublishTestResults@2
            displayName: 'Publish Test Results'
            inputs:
              testResultsFormat: 'JUnit'
              testResultsFiles: '**/test-results.xml'
              failTaskOnFailedTests: true

- stage: DeployToProduction
  displayName: 'Deploy to Production'
  dependsOn: DeployToStaging
  condition: succeeded()
  jobs:
  - deployment: DeployProduction
    displayName: 'Deploy to Production (Canary)'
    environment: 'ML-Production'
    pool:
      vmImage: 'ubuntu-latest'
    strategy:
      canary:
        increments: [10, 25, 50, 100]
        preDeploy:
          steps:
          - task: Bash@3
            displayName: 'Pre-deployment Checks'
            inputs:
              targetType: 'inline'
              script: |
                echo "Running pre-deployment validation..."
                python src/deployment/pre_deployment_checks.py \
                  --workspace-name $(workspaceName) \
                  --model-name $(modelName)
        
        deploy:
          steps:
          - task: AzureCLI@2
            displayName: 'Deploy to AKS (Canary)'
            inputs:
              azureSubscription: $(azureSubscription)
              scriptType: 'bash'
              scriptLocation: 'inlineScript'
              inlineScript: |
                python src/deployment/deploy_to_aks.py \
                  --workspace-name $(workspaceName) \
                  --resource-group $(resourceGroup) \
                  --model-name $(modelName) \
                  --aks-cluster $(aksCluster) \
                  --namespace $(namespace) \
                  --deployment-type canary \
                  --traffic-percentage $(strategy.increment)
        
        routeTraffic:
          steps:
          - task: Bash@3
            displayName: 'Route Traffic to Canary'
            inputs:
              targetType: 'inline'
              script: |
                kubectl set image deployment/$(modelName) \
                  model=$(containerRegistry)/$(modelName):$(Build.BuildId) \
                  --namespace $(namespace)
                
                # Update traffic routing
                kubectl patch service $(modelName) \
                  -p '{"spec":{"selector":{"version":"canary"}}}' \
                  --namespace $(namespace)
        
        postRouteTraffic:
          steps:
          - task: Bash@3
            displayName: 'Monitor Canary Deployment'
            inputs:
              targetType: 'inline'
              script: |
                python src/deployment/monitor_canary.py \
                  --namespace $(namespace) \
                  --deployment $(modelName) \
                  --duration 300 \
                  --error-threshold 0.05 \
                  --latency-threshold 500
          
          - task: Bash@3
            displayName: 'Compare Canary vs Baseline'
            inputs:
              targetType: 'inline'
              script: |
                python src/deployment/compare_deployments.py \
                  --baseline-deployment $(modelName)-stable \
                  --canary-deployment $(modelName)-canary \
                  --metrics accuracy,latency,error_rate \
                  --duration 600
        
        on:
          failure:
            steps:
            - task: Bash@3
              displayName: 'Rollback Canary Deployment'
              inputs:
                targetType: 'inline'
                script: |
                  echo "Canary deployment failed! Rolling back..."
                  kubectl rollout undo deployment/$(modelName) \
                    --namespace $(namespace)
          
          success:
            steps:
            - task: Bash@3
              displayName: 'Promote Canary to Stable'
              inputs:
                targetType: 'inline'
                script: |
                  echo "Canary validation successful! Promoting to stable..."
                  kubectl label deployment $(modelName) version=stable \
                    --overwrite --namespace $(namespace)

- stage: PostDeployment
  displayName: 'Post-Deployment Activities'
  dependsOn: DeployToProduction
  condition: succeeded()
  jobs:
  - job: PostDeploy
    displayName: 'Post-Deployment Tasks'
    pool:
      vmImage: 'ubuntu-latest'
    steps:
    - task: AzureCLI@2
      displayName: 'Configure Monitoring'
      inputs:
        azureSubscription: $(azureSubscription)
        scriptType: 'bash'
        scriptLocation: 'inlineScript'
        inlineScript: |
          python src/monitoring/configure_monitoring.py \
            --workspace-name $(workspaceName) \
            --model-name $(modelName) \
            --enable-app-insights true \
            --enable-drift-detection true \
            --drift-threshold 0.3
    
    - task: Bash@3
      displayName: 'Update Documentation'
      inputs:
        targetType: 'inline'
        script: |
          python src/documentation/update_deployment_docs.py \
            --model-name $(modelName) \
            --version $(Build.BuildNumber) \
            --endpoint $(production-endpoint)
    
    - task: Bash@3
      displayName: 'Notify Stakeholders'
      inputs:
        targetType: 'inline'
        script: |
          python src/notification/send_notification.py \
            --type deployment_success \
            --model $(modelName) \
            --version $(Build.BuildNumber) \
            --recipients ml-team@company.com
```

---

### 3. GitHub Actions - Complete ML Workflow

```yaml
# .github/workflows/ml-workflow.yml
# End-to-end ML workflow using GitHub Actions

name: ML Model CI/CD

on:
  push:
    branches: [ main, develop ]
    paths:
      - 'src/**'
      - 'config/**'
      - 'tests/**'
  pull_request:
    branches: [ main ]
  workflow_dispatch:
    inputs:
      deploy_to_prod:
        description: 'Deploy to production'
        required: true
        default: 'false'

env:
  AZURE_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
  RESOURCE_GROUP: rg-aiplatform-prod
  WORKSPACE_NAME: mlw-aiplatform-prod
  MODEL_NAME: customer-churn-model
  PYTHON_VERSION: '3.9'

jobs:
  code-quality:
    name: Code Quality Checks
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: ${{ env.PYTHON_VERSION }}
      
      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install flake8 pylint black isort mypy pytest pytest-cov
          pip install -r requirements.txt
      
      - name: Run Black (formatting)
        run: black --check src/ tests/
      
      - name: Run isort (import sorting)
        run: isort --check-only src/ tests/
      
      - name: Run Flake8 (linting)
        run: flake8 src/ tests/ --max-line-length=100
      
      - name: Run Pylint
        run: pylint src/ --fail-under=8.0
      
      - name: Run MyPy (type checking)
        run: mypy src/ --ignore-missing-imports
      
      - name: Run Unit Tests
        run: |
          pytest tests/unit/ \
            --cov=src \
            --cov-report=xml \
            --cov-report=html \
            --junitxml=test-results.xml
      
      - name: Upload Coverage to Codecov
        uses: codecov/codecov-action@v3
        with:
          file: ./coverage.xml
          flags: unittests
      
      - name: Publish Test Results
        uses: EnricoMi/publish-unit-test-result-action@v2
        if: always()
        with:
          files: test-results.xml

  security-scan:
    name: Security Scanning
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      
      - name: Run Bandit (security linting)
        run: |
          pip install bandit
          bandit -r src/ -f json -o bandit-report.json
      
      - name: Run Safety (dependency checking)
        run: |
          pip install safety
          safety check --json > safety-report.json
      
      - name: Upload Security Reports
        uses: actions/upload-artifact@v3
        with:
          name: security-reports
          path: |
            bandit-report.json
            safety-report.json

  data-validation:
    name: Data Quality Validation
    runs-on: ubuntu-latest
    needs: code-quality
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: ${{ env.PYTHON_VERSION }}
      
      - name: Install dependencies
        run: |
          pip install -r requirements.txt
          pip install great-expectations pandas-profiling
      
      - name: Azure Login
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}
      
      - name: Run Data Validation
        run: |
          python src/data_validation/validate_data.py \
            --workspace-name ${{ env.WORKSPACE_NAME }} \
            --resource-group ${{ env.RESOURCE_GROUP }} \
            --expectations config/data_expectations.json
      
      - name: Generate Data Profile Report
        run: |
          python src/data_validation/profile_data.py \
            --output data-profile.html
      
      - name: Upload Data Profile
        uses: actions/upload-artifact@v3
        with:
          name: data-profile
          path: data-profile.html

  train-model:
    name: Train ML Model
    runs-on: ubuntu-latest
    needs: [code-quality, data-validation]
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: ${{ env.PYTHON_VERSION }}
      
      - name: Install Azure ML SDK
        run: |
          pip install azureml-sdk azureml-core azureml-mlflow
      
      - name: Azure Login
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}
      
      - name: Submit Training Job
        id: train
        run: |
          python src/training/submit_training.py \
            --workspace-name ${{ env.WORKSPACE_NAME }} \
            --resource-group ${{ env.RESOURCE_GROUP }} \
            --experiment-name ${{ env.MODEL_NAME }}_experiment \
            --config config/training_config.yaml \
            --build-id ${{ github.run_number }}
      
      - name: Wait for Training Completion
        run: |
          python src/training/wait_for_completion.py \
            --workspace-name ${{ env.WORKSPACE_NAME }} \
            --resource-group ${{ env.RESOURCE_GROUP }} \
            --experiment-name ${{ env.MODEL_NAME }}_experiment \
            --timeout 7200
      
      - name: Get Training Metrics
        id: metrics
        run: |
          python src/training/get_metrics.py \
            --workspace-name ${{ env.WORKSPACE_NAME }} \
            --resource-group ${{ env.RESOURCE_GROUP }} \
            --experiment-name ${{ env.MODEL_NAME }}_experiment \
            --output metrics.json
          
          # Export metrics for next jobs
          echo "accuracy=$(jq -r .accuracy metrics.json)" >> $GITHUB_OUTPUT
          echo "precision=$(jq -r .precision metrics.json)" >> $GITHUB_OUTPUT
      
      - name: Upload Training Metrics
        uses: actions/upload-artifact@v3
        with:
          name: training-metrics
          path: metrics.json

  validate-model:
    name: Validate Model Quality
    runs-on: ubuntu-latest
    needs: train-model
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      
      - name: Download Training Metrics
        uses: actions/download-artifact@v3
        with:
          name: training-metrics
      
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: ${{ env.PYTHON_VERSION }}
      
      - name: Install dependencies
        run: pip install -r requirements.txt
      
      - name: Validate Metrics Against Thresholds
        run: |
          python src/validation/validate_metrics.py \
            --metrics-file metrics.json \
            --minimum-accuracy 0.85 \
            --minimum-precision 0.80 \
            --minimum-recall 0.80
      
      - name: Azure Login
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}
      
      - name: Run Fairness Assessment
        run: |
          python src/validation/fairness_assessment.py \
            --workspace-name ${{ env.WORKSPACE_NAME }} \
            --resource-group ${{ env.RESOURCE_GROUP }} \
            --model-name ${{ env.MODEL_NAME }} \
            --sensitive-features age,gender \
            --fairness-threshold 0.8
      
      - name: Run Explainability Analysis
        run: |
          python src/validation/explainability_analysis.py \
            --workspace-name ${{ env.WORKSPACE_NAME }} \
            --resource-group ${{ env.RESOURCE_GROUP }} \
            --model-name ${{ env.MODEL_NAME }}

  register-model:
    name: Register Model
    runs-on: ubuntu-latest
    needs: validate-model
    if: github.ref == 'refs/heads/main'
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: ${{ env.PYTHON_VERSION }}
      
      - name: Install Azure ML SDK
        run: pip install azureml-sdk
      
      - name: Azure Login
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}
      
      - name: Register Model in Registry
        run: |
          python src/registration/register_model.py \
            --workspace-name ${{ env.WORKSPACE_NAME }} \
            --resource-group ${{ env.RESOURCE_GROUP }} \
            --model-name ${{ env.MODEL_NAME }} \
            --experiment-name ${{ env.MODEL_NAME }}_experiment \
            --tags "build_id=${{ github.run_number }}" \
                   "branch=${{ github.ref_name }}" \
                   "commit=${{ github.sha }}"
      
      - name: Generate Model Card
        run: |
          python src/documentation/generate_model_card.py \
            --workspace-name ${{ env.WORKSPACE_NAME }} \
            --resource-group ${{ env.RESOURCE_GROUP }} \
            --model-name ${{ env.MODEL_NAME }} \
            --output model-card.md
      
      - name: Upload Model Card
        uses: actions/upload-artifact@v3
        with:
          name: model-card
          path: model-card.md

  deploy-staging:
    name: Deploy to Staging
    runs-on: ubuntu-latest
    needs: register-model
    environment:
      name: staging
      url: ${{ steps.deploy.outputs.endpoint }}
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      
      - name: Azure Login
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}
      
      - name: Deploy to ACI (Staging)
        id: deploy
        run: |
          python src/deployment/deploy_to_aci.py \
            --workspace-name ${{ env.WORKSPACE_NAME }} \
            --resource-group ${{ env.RESOURCE_GROUP }} \
            --model-name ${{ env.MODEL_NAME }} \
            --service-name ${{ env.MODEL_NAME }}-staging \
            --environment staging
      
      - name: Run Smoke Tests
        run: |
          python tests/smoke_tests.py \
            --endpoint ${{ steps.deploy.outputs.endpoint }} \
            --test-data tests/data/smoke_test_data.json
      
      - name: Run Integration Tests
        run: |
          pytest tests/integration/ \
            --endpoint ${{ steps.deploy.outputs.endpoint }} \
            --junitxml=test-results.xml

  deploy-production:
    name: Deploy to Production
    runs-on: ubuntu-latest
    needs: deploy-staging
    if: github.event.inputs.deploy_to_prod == 'true' || github.ref == 'refs/heads/main'
    environment:
      name: production
      url: ${{ steps.deploy.outputs.endpoint }}
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      
      - name: Azure Login
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}
      
      - name: Deploy to AKS (Production)
        id: deploy
        run: |
          python src/deployment/deploy_to_aks.py \
            --workspace-name ${{ env.WORKSPACE_NAME }} \
            --resource-group ${{ env.RESOURCE_GROUP }} \
            --model-name ${{ env.MODEL_NAME }} \
            --aks-cluster aks-ml-prod \
            --namespace ml-models \
            --deployment-type blue-green
      
      - name: Run Production Smoke Tests
        run: |
          python tests/smoke_tests.py \
            --endpoint ${{ steps.deploy.outputs.endpoint }} \
            --test-data tests/data/smoke_test_data.json
      
      - name: Configure Monitoring
        run: |
          python src/monitoring/configure_monitoring.py \
            --workspace-name ${{ env.WORKSPACE_NAME }} \
            --model-name ${{ env.MODEL_NAME }} \
            --enable-app-insights true \
            --enable-drift-detection true
      
      - name: Create GitHub Release
        uses: actions/create-release@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          tag_name: v${{ github.run_number }}
          release_name: Model Release ${{ github.run_number }}
          body: |
            ## Model Deployment
            - Model: ${{ env.MODEL_NAME }}
            - Version: ${{ github.run_number }}
            - Commit: ${{ github.sha }}
            - Endpoint: ${{ steps.deploy.outputs.endpoint }}
          draft: false
          prerelease: false
```

---

## Model Registry Setup Guide

### Azure ML Model Registry Configuration

```python
# src/model_registry/setup_registry.py
"""
Complete model registry setup with versioning, tagging, and governance
"""

from azureml.core import Workspace, Model
from azureml.core.model import Model as AMLModel
import json
from datetime import datetime

class ModelRegistry:
    """
    Centralized model registry management
    """
    
    def __init__(self, workspace):
        self.workspace = workspace
    
    def register_model(
        self,
        model_path,
        model_name,
        description=None,
        tags=None,
        properties=None,
        datasets=None
    ):
        """
        Register a model with comprehensive metadata
        
        Args:
            model_path: Path to model files
            model_name: Name for the model
            description: Model description
            tags: Dictionary of tags (e.g., framework, use_case)
            properties: Dictionary of properties (e.g., metrics)
            datasets: List of dataset IDs used for training
        
        Returns:
            Registered Model object
        """
        
        # Default tags
        default_tags = {
            'framework': 'scikit-learn',
            'registered_by': 'CI/CD',
            'registration_date': datetime.now().isoformat()
        }
        
        if tags:
            default_tags.update(tags)
        
        # Register model
        model = Model.register(
            workspace=self.workspace,
            model_path=model_path,
            model_name=model_name,
            description=description or f"Model: {model_name}",
            tags=default_tags,
            properties=properties,
            datasets=datasets
        )
        
        print(f"✓ Model registered: {model.name} (version {model.version})")
        print(f"  ID: {model.id}")
        print(f"  Tags: {model.tags}")
        
        return model
    
    def get_latest_model(self, model_name):
        """Get the latest version of a model"""
        models = Model.list(self.workspace, name=model_name, latest=True)
        if models:
            return models[0]
        return None
    
    def get_model_by_version(self, model_name, version):
        """Get a specific version of a model"""
        try:
            model = Model(self.workspace, name=model_name, version=version)
            return model
        except Exception as e:
            print(f"Model not found: {e}")
            return None
    
    def promote_model(self, model_name, version, stage='production'):
        """
        Promote a model to a specific stage (staging/production)
        """
        model = self.get_model_by_version(model_name, version)
        
        if model is None:
            raise ValueError(f"Model {model_name} version {version} not found")
        
        # Update tags to indicate stage
        model.add_tags({
            'stage': stage,
            'promoted_date': datetime.now().isoformat()
        })
        
        print(f"✓ Model promoted to {stage}: {model_name} v{version}")
        
        return model
    
    def compare_models(self, model_name, version1, version2, metrics):
        """
        Compare two model versions based on metrics
        """
        model1 = self.get_model_by_version(model_name, version1)
        model2 = self.get_model_by_version(model_name, version2)
        
        comparison = {
            'model_name': model_name,
            'version1': version1,
            'version2': version2,
            'metrics': {}
        }
        
        for metric in metrics:
            val1 = float(model1.properties.get(metric, 0))
            val2 = float(model2.properties.get(metric, 0))
            
            comparison['metrics'][metric] = {
                'version1': val1,
                'version2': val2,
                'difference': val2 - val1,
                'percent_change': ((val2 - val1) / val1 * 100) if val1 != 0 else 0
            }
        
        return comparison
    
    def get_production_model(self, model_name):
        """Get the current production model"""
        models = Model.list(self.workspace, name=model_name, tags=[['stage', 'production']])
        if models:
            # Sort by version and return latest production
            models_sorted = sorted(models, key=lambda m: m.version, reverse=True)
            return models_sorted[0]
        return None
    
    def list_all_models(self, tags=None):
        """List all models with optional tag filtering"""
        models = Model.list(self.workspace, tags=tags)
        
        model_list = []
        for model in models:
            model_list.append({
                'name': model.name,
                'version': model.version,
                'id': model.id,
                'created_time': model.created_time,
                'tags': model.tags,
                'properties': model.properties
            })
        
        return model_list
    
    def archive_old_versions(self, model_name, keep_latest_n=5):
        """
        Archive old model versions, keeping only the latest N
        """
        models = Model.list(self.workspace, name=model_name)
        models_sorted = sorted(models, key=lambda m: m.version, reverse=True)
        
        # Keep production models
        production_models = [m for m in models_sorted if m.tags.get('stage') == 'production']
        
        # Archive old non-production models
        to_archive = []
        non_prod_count = 0
        
        for model in models_sorted:
            if model.tags.get('stage') != 'production':
                non_prod_count += 1
                if non_prod_count > keep_latest_n:
                    model.add_tags({'archived': 'true', 'archived_date': datetime.now().isoformat()})
                    to_archive.append(f"{model.name} v{model.version}")
        
        if to_archive:
            print(f"✓ Archived {len(to_archive)} old model versions")
        
        return to_archive

# Example usage
if __name__ == "__main__":
    ws = Workspace.from_config()
    registry = ModelRegistry(ws)
    
    # Register a model
    model = registry.register_model(
        model_path='./outputs/model.pkl',
        model_name='customer-churn-model',
        description='Customer churn prediction model',
        tags={
            'framework': 'scikit-learn',
            'algorithm': 'RandomForest',
            'use_case': 'churn_prediction'
        },
        properties={
            'accuracy': '0.92',
            'precision': '0.89',
            'recall': '0.91',
            'f1_score': '0.90'
        }
    )
    
    # Compare models
    comparison = registry.compare_models(
        'customer-churn-model',
        version1=1,
        version2=2,
        metrics=['accuracy', 'precision', 'recall']
    )
    print(json.dumps(comparison, indent=2))
    
    # Promote to production
    registry.promote_model('customer-churn-model', version=2, stage='production')
```

---

## Automated Testing Framework

### ML Testing Suite

```python
# tests/ml_test_framework.py
"""
Comprehensive ML testing framework covering:
- Data validation tests
- Model training tests
- Model performance tests
- Deployment tests
"""

import pytest
import numpy as np
import pandas as pd
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score
import requests
import json

class MLTestFramework:
    """
    Complete ML testing framework
    """
    
    # ========================================================================
    # DATA TESTS
    # ========================================================================
    
    @staticmethod
    def test_data_schema(df, expected_schema):
        """
        Test that dataframe matches expected schema
        """
        assert set(df.columns) == set(expected_schema.keys()), \
            f"Schema mismatch. Expected: {expected_schema.keys()}, Got: {df.columns}"
        
        for col, dtype in expected_schema.items():
            assert df[col].dtype == dtype, \
                f"Column {col} has wrong type. Expected: {dtype}, Got: {df[col].dtype}"
    
    @staticmethod
    def test_data_quality(df, quality_rules):
        """
        Test data quality rules
        
        Args:
            df: DataFrame to test
            quality_rules: Dict with rules like:
                {
                    'column_name': {
                        'null_threshold': 0.1,  # Max 10% nulls
                        'min_value': 0,
                        'max_value': 100
                    }
                }
        """
        for col, rules in quality_rules.items():
            if col not in df.columns:
                pytest.fail(f"Column {col} not found in dataframe")
            
            # Check null percentage
            if 'null_threshold' in rules:
                null_pct = df[col].isnull().sum() / len(df)
                assert null_pct <= rules['null_threshold'], \
                    f"{col}: Null percentage {null_pct:.2%} exceeds threshold {rules['null_threshold']:.2%}"
            
            # Check value ranges (for numeric columns)
            if df[col].dtype in [np.int64, np.float64]:
                if 'min_value' in rules:
                    assert df[col].min() >= rules['min_value'], \
                        f"{col}: Minimum value {df[col].min()} below threshold {rules['min_value']}"
                
                if 'max_value' in rules:
                    assert df[col].max() <= rules['max_value'], \
                        f"{col}: Maximum value {df[col].max()} above threshold {rules['max_value']}"
    
    @staticmethod
    def test_data_distribution(df, column, expected_distribution):
        """
        Test that data distribution matches expectations
        """
        actual_dist = df[column].value_counts(normalize=True).to_dict()
        
        for category, expected_pct in expected_distribution.items():
            actual_pct = actual_dist.get(category, 0)
            # Allow 10% deviation
            assert abs(actual_pct - expected_pct) <= 0.1, \
                f"{column}/{category}: Distribution {actual_pct:.2%} deviates from expected {expected_pct:.2%}"
    
    # ========================================================================
    # MODEL TRAINING TESTS
    # ========================================================================
    
    @staticmethod
    def test_model_training_time(training_function, max_time_seconds=3600):
        """
        Test that model training completes within time limit
        """
        import time
        start_time = time.time()
        model = training_function()
        elapsed_time = time.time() - start_time
        
        assert elapsed_time <= max_time_seconds, \
            f"Training took {elapsed_time:.0f}s, exceeds limit of {max_time_seconds}s"
        
        return model
    
    @staticmethod
    def test_model_reproducibility(training_function, n_runs=3):
        """
        Test that model training is reproducible
        """
        results = []
        for i in range(n_runs):
            model, metrics = training_function(seed=42)
            results.append(metrics['accuracy'])
        
        # All runs should produce identical results
        assert len(set(results)) == 1, \
            f"Model training not reproducible. Results: {results}"
    
    # ========================================================================
    # MODEL PERFORMANCE TESTS
    # ========================================================================
    
    @staticmethod
    def test_model_accuracy(model, X_test, y_test, min_accuracy=0.85):
        """
        Test that model meets minimum accuracy threshold
        """
        y_pred = model.predict(X_test)
        accuracy = accuracy_score(y_test, y_pred)
        
        assert accuracy >= min_accuracy, \
            f"Accuracy {accuracy:.3f} below threshold {min_accuracy:.3f}"
        
        return accuracy
    
    @staticmethod
    def test_model_performance_suite(model, X_test, y_test, thresholds):
        """
        Test comprehensive performance metrics
        
        Args:
            thresholds: Dict with thresholds like:
                {
                    'accuracy': 0.85,
                    'precision': 0.80,
                    'recall': 0.80,
                    'f1': 0.80
                }
        """
        y_pred = model.predict(X_test)
        
        metrics = {
            'accuracy': accuracy_score(y_test, y_pred),
            'precision': precision_score(y_test, y_pred, average='weighted'),
            'recall': recall_score(y_test, y_pred, average='weighted'),
            'f1': f1_score(y_test, y_pred, average='weighted')
        }
        
        failures = []
        for metric_name, threshold in thresholds.items():
            if metrics[metric_name] < threshold:
                failures.append(
                    f"{metric_name}: {metrics[metric_name]:.3f} < {threshold:.3f}"
                )
        
        assert len(failures) == 0, f"Performance tests failed:\n" + "\n".join(failures)
        
        return metrics
    
    @staticmethod
    def test_model_fairness(model, X_test, y_test, sensitive_feature, fairness_threshold=0.8):
        """
        Test that model is fair across demographic groups
        """
        from fairlearn.metrics import demographic_parity_ratio
        
        y_pred = model.predict(X_test)
        dp_ratio = demographic_parity_ratio(
            y_test, y_pred,
            sensitive_features=sensitive_feature
        )
        
        assert dp_ratio >= fairness_threshold, \
            f"Fairness ratio {dp_ratio:.3f} below threshold {fairness_threshold:.3f}"
        
        return dp_ratio
    
    # ========================================================================
    # DEPLOYMENT TESTS
    # ========================================================================
    
    @staticmethod
    def test_endpoint_availability(endpoint_url, timeout=10):
        """
        Test that model endpoint is available
        """
        try:
            response = requests.get(f"{endpoint_url}/health", timeout=timeout)
            assert response.status_code == 200, \
                f"Health check failed with status {response.status_code}"
        except requests.exceptions.RequestException as e:
            pytest.fail(f"Endpoint not available: {e}")
    
    @staticmethod
    def test_endpoint_prediction(endpoint_url, test_data, expected_shape):
        """
        Test that endpoint returns predictions with correct shape
        """
        response = requests.post(
            f"{endpoint_url}/predict",
            json=test_data,
            headers={'Content-Type': 'application/json'}
        )
        
        assert response.status_code == 200, \
            f"Prediction request failed with status {response.status_code}"
        
        predictions = response.json()
        assert len(predictions) == expected_shape, \
            f"Expected {expected_shape} predictions, got {len(predictions)}"
    
    @staticmethod
    def test_endpoint_latency(endpoint_url, test_data, max_latency_ms=500):
        """
        Test that endpoint responds within latency threshold
        """
        import time
        
        start_time = time.time()
        response = requests.post(
            f"{endpoint_url}/predict",
            json=test_data,
            headers={'Content-Type': 'application/json'}
        )
        latency_ms = (time.time() - start_time) * 1000
        
        assert response.status_code == 200, "Prediction request failed"
        assert latency_ms <= max_latency_ms, \
            f"Latency {latency_ms:.0f}ms exceeds threshold {max_latency_ms}ms"
        
        return latency_ms
    
    @staticmethod
    def test_endpoint_load(endpoint_url, test_data, n_requests=100, max_error_rate=0.05):
        """
        Test that endpoint handles load with acceptable error rate
        """
        import concurrent.futures
        
        def make_request():
            try:
                response = requests.post(
                    f"{endpoint_url}/predict",
                    json=test_data,
                    headers={'Content-Type': 'application/json'},
                    timeout=5
                )
                return response.status_code == 200
            except:
                return False
        
        with concurrent.futures.ThreadPoolExecutor(max_workers=10) as executor:
            results = list(executor.map(lambda _: make_request(), range(n_requests)))
        
        success_rate = sum(results) / len(results)
        error_rate = 1 - success_rate
        
        assert error_rate <= max_error_rate, \
            f"Error rate {error_rate:.2%} exceeds threshold {max_error_rate:.2%}"
        
        return success_rate

# ============================================================================
# PYTEST FIXTURES AND TEST CASES
# ============================================================================

@pytest.fixture
def sample_data():
    """Fixture providing sample test data"""
    return pd.DataFrame({
        'feature1': np.random.rand(100),
        'feature2': np.random.rand(100),
        'target': np.random.choice([0, 1], 100)
    })

@pytest.fixture
def trained_model():
    """Fixture providing a trained model"""
    from sklearn.ensemble import RandomForestClassifier
    from sklearn.datasets import make_classification
    
    X, y = make_classification(n_samples=100, n_features=5, random_state=42)
    model = RandomForestClassifier(random_state=42)
    model.fit(X, y)
    return model, X, y

# Example test cases
class TestDataQuality:
    def test_schema(self, sample_data):
        expected_schema = {
            'feature1': np.float64,
            'feature2': np.float64,
            'target': np.int64
        }
        MLTestFramework.test_data_schema(sample_data, expected_schema)
    
    def test_no_missing_values(self, sample_data):
        quality_rules = {
            'feature1': {'null_threshold': 0.0},
            'feature2': {'null_threshold': 0.0},
            'target': {'null_threshold': 0.0}
        }
        MLTestFramework.test_data_quality(sample_data, quality_rules)

class TestModelPerformance:
    def test_accuracy_threshold(self, trained_model):
        model, X, y = trained_model
        MLTestFramework.test_model_accuracy(model, X, y, min_accuracy=0.7)
    
    def test_comprehensive_metrics(self, trained_model):
        model, X, y = trained_model
        thresholds = {
            'accuracy': 0.7,
            'precision': 0.65,
            'recall': 0.65,
            'f1': 0.65
        }
        metrics = MLTestFramework.test_model_performance_suite(model, X, y, thresholds)
        print(f"Model metrics: {metrics}")

# Run tests with: pytest tests/ml_test_framework.py -v
```

---

## Best Practices

### 1. **Pipeline Versioning**
- Version control all pipeline code (YAML, Python scripts)
- Use semantic versioning for models (MAJOR.MINOR.PATCH)
- Tag pipeline runs with build numbers and commit SHAs

### 2. **Environment Management**
- Use Docker containers for reproducible environments
- Pin all dependency versions in requirements.txt
- Separate dev, staging, and production environments

### 3. **Automated Testing**
- Unit tests for all code (>80% coverage)
- Integration tests for pipelines
- Performance tests for models
- Load tests for endpoints

### 4. **Monitoring & Alerting**
- Monitor training job failures
- Alert on pipeline failures
- Track model performance in production
- Set up drift detection

### 5. **Security**
- Scan code for vulnerabilities (Bandit, Safety)
- Scan containers for vulnerabilities
- Use managed identities (no hardcoded credentials)
- Implement RBAC for model registry access

---

## Resources

**Documentation**:
- [Azure ML Pipelines](https://docs.microsoft.com/en-us/azure/machine-learning/concept-ml-pipelines)
- [GitHub Actions for ML](https://docs.github.com/en/actions)
- [MLOps Principles](https://ml-ops.org/)

**Tools**:
- Azure DevOps
- GitHub Actions
- Jenkins
- MLflow
- Kubeflow

---

**Document Version:** 1.0  
**Last Updated:** January 12, 2026  
**Owner:** AI Delivery Methodology Team
