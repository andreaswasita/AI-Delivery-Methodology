# Sample Datasets for AI Hackathons

Quick access to datasets for rapid prototyping.

## 📊 Public Datasets

### Document Analysis & NLP

| Dataset | Description | Size | Link |
|---------|-------------|------|------|
| **Enron Emails** | 500K corporate emails for text analysis | 1.7GB | [Download](https://www.cs.cmu.edu/~enron/) |
| **Amazon Reviews** | Product reviews with ratings | 35GB | [Kaggle](https://www.kaggle.com/datasets/snap/amazon-fine-food-reviews) |
| **News Articles** | News category classification | 200MB | [Kaggle](https://www.kaggle.com/datasets/rmisra/news-category-dataset) |
| **Wikipedia Abstracts** | Article summaries for knowledge extraction | 2GB | [Hugging Face](https://huggingface.co/datasets/wikipedia) |
| **Contract Understanding** | Legal contract analysis (CUAD) | 50MB | [GitHub](https://github.com/TheAtticusProject/cuad) |

### Computer Vision

| Dataset | Description | Size | Link |
|---------|-------------|------|------|
| **COCO Dataset** | Object detection, segmentation | 25GB | [COCO](https://cocodataset.org/) |
| **ImageNet** | Image classification (1000 classes) | 150GB | [ImageNet](https://www.image-net.org/) |
| **Fashion-MNIST** | Clothing classification | 30MB | [GitHub](https://github.com/zalandoresearch/fashion-mnist) |
| **Face Detection** | Labeled faces in the wild | 200MB | [LFW](http://vis-www.cs.umass.edu/lfw/) |
| **Medical Images** | X-rays, CT scans (ChestX-ray14) | 45GB | [NIH](https://www.nih.gov/news-events/news-releases/nih-clinical-center-provides-one-largest-publicly-available-chest-x-ray-datasets-scientific-community) |

### Time Series & Anomaly Detection

| Dataset | Description | Size | Link |
|---------|-------------|------|------|
| **Credit Card Fraud** | Fraud detection dataset | 150MB | [Kaggle](https://www.kaggle.com/datasets/mlg-ulb/creditcardfraud) |
| **Network Intrusion** | KDD Cup 99 dataset | 75MB | [UCI](https://archive.ics.uci.edu/ml/datasets/kdd+cup+1999+data) |
| **Server Metrics** | Yahoo anomaly detection | 250MB | [Yahoo](https://webscope.sandbox.yahoo.com/) |
| **Stock Prices** | Historical stock data | Varies | [Yahoo Finance API](https://finance.yahoo.com/) |

### Conversational AI

| Dataset | Description | Size | Link |
|---------|-------------|------|------|
| **Cornell Movie Dialogs** | Conversational exchanges | 10MB | [Cornell](https://www.cs.cornell.edu/~cristian/Cornell_Movie-Dialogs_Corpus.html) |
| **Customer Support** | Twitter customer support conversations | 50MB | [Kaggle](https://www.kaggle.com/datasets/thoughtvector/customer-support-on-twitter) |
| **Medical Q&A** | Healthcare question-answer pairs | 20MB | [MedQuAD](https://github.com/abachaa/MedQuAD) |

## 🔧 Synthetic Data Generators

### Python Libraries

```python
# Faker - Generate fake data
from faker import Faker
fake = Faker()

data = {
    "name": fake.name(),
    "email": fake.email(),
    "address": fake.address(),
    "company": fake.company()
}
```

```python
# SDV - Synthetic Data Vault
from sdv.tabular import GaussianCopula

model = GaussianCopula()
model.fit(real_data)
synthetic_data = model.sample(num_rows=1000)
```

### Azure Services

```python
# Azure Form Recognizer Sample Invoices
from azure.ai.formrecognizer import DocumentAnalysisClient
from azure.core.credentials import AzureKeyCredential

# Use Microsoft's sample invoices
sample_invoice_url = "https://raw.githubusercontent.com/Azure-Samples/cognitive-services-REST-api-samples/master/curl/form-recognizer/sample-invoice.pdf"
```

## 🚀 Quick Start Templates

### Load CSV Data

```python
import pandas as pd

# From URL
df = pd.read_csv('https://example.com/data.csv')

# From local file
df = pd.read_csv('../data/sample-data.csv')

# Basic exploration
print(df.head())
print(df.info())
print(df.describe())
```

### Azure Blob Storage

```python
from azure.storage.blob import BlobServiceClient

connection_string = "your_connection_string"
blob_service_client = BlobServiceClient.from_connection_string(connection_string)

# Download dataset
blob_client = blob_service_client.get_blob_client(
    container="datasets",
    blob="hackathon-data.csv"
)

with open("local-data.csv", "wb") as f:
    data = blob_client.download_blob()
    f.write(data.readall())
```

### Azure OpenAI Data Prep

```python
import json

# Prepare training data for fine-tuning
def prepare_openai_dataset(df, prompt_col, completion_col):
    data = []
    for _, row in df.iterrows():
        data.append({
            "messages": [
                {"role": "user", "content": row[prompt_col]},
                {"role": "assistant", "content": row[completion_col]}
            ]
        })
    
    with open('training-data.jsonl', 'w') as f:
        for item in data:
            f.write(json.dumps(item) + '\n')
```

## 🔒 Data Privacy & Compliance

### Anonymization

```python
from presidio_analyzer import AnalyzerEngine
from presidio_anonymizer import AnonymizerEngine

# Detect PII
analyzer = AnalyzerEngine()
results = analyzer.analyze(text="John Smith's email is john@example.com", language='en')

# Anonymize
anonymizer = AnonymizerEngine()
anonymized = anonymizer.anonymize(text=text, analyzer_results=results)
```

### Data Masking

```python
import hashlib

def mask_pii(value):
    return hashlib.sha256(str(value).encode()).hexdigest()[:16]

df['email_masked'] = df['email'].apply(mask_pii)
df['ssn_masked'] = df['ssn'].apply(mask_pii)
```

## 📦 Pre-configured Datasets in Azure

Create these in your Azure storage account:

```bash
# Sample datasets we've prepared
az storage blob upload-batch \
    --account-name <storage-account> \
    --destination hackathon-datasets \
    --source ./sample-datasets/
```

### Available Datasets:

1. **customer-support-tickets.csv** (10K records)
   - Ticket descriptions, categories, resolutions
   - Perfect for text classification

2. **product-images/** (1K images)
   - Product photos with labels
   - Image classification/object detection

3. **financial-transactions.csv** (100K records)
   - Transaction data with fraud labels
   - Anomaly detection practice

4. **medical-notes.csv** (5K records) 
   - De-identified clinical notes
   - NLP and entity extraction

## ⚡ Quick Load Scripts

Save time with these ready-to-use loaders:

```python
# quick_data_loader.py
import pandas as pd
import requests
from io import StringIO

def load_hackathon_data(dataset_name):
    """Quick load common datasets"""
    datasets = {
        'customer-support': 'https://raw.githubusercontent.com/.../customer-support.csv',
        'product-reviews': 'https://raw.githubusercontent.com/.../reviews.csv',
        'fraud-detection': 'https://raw.githubusercontent.com/.../fraud.csv'
    }
    
    url = datasets.get(dataset_name)
    if not url:
        raise ValueError(f"Dataset {dataset_name} not found")
    
    response = requests.get(url)
    return pd.read_csv(StringIO(response.text))

# Usage
df = load_hackathon_data('customer-support')
```

## 🎯 Best Practices

1. **Start Small**: Use 1K-10K samples for initial prototyping
2. **Check License**: Ensure dataset license allows commercial use
3. **Validate Quality**: Check for missing values, outliers
4. **Split Data**: 80/10/10 train/val/test split
5. **Document Source**: Track data provenance for compliance

## 🆘 Need Help?

- Can't find the right dataset? Ask in hackathon Slack
- Data quality issues? Use our data cleaning notebooks
- Privacy concerns? Run our PII detection script first
