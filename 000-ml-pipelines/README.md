1. Kubernetes
2. Dockers
3. [Architecting a Machine Learning Pipeline](https://towardsdatascience.com/architecting-a-machine-learning-pipeline-a847f094d1c7)

## Pipelines

1. Problem Definition
2. Data Ingestion
3. Data Preparation
4. Data Segregation
   4.1 Training Set
   4.2 Validation Set
   4.3 Test Set
5. Model Training
6. Candidate Model Evaluation
7. Model Deployment
8. Performance Monitoring

## Project Options
1. Netflix's recommendation engines
2. Uber's arrival time estimation
3. LinkedIn's connections suggestions
4. Airbnb's search engines

## System Requirements

1. features and predictions are time sensitive

## Components

1. Data 
   1.1 Collection
   1.2 Verification
   1.3 Cleaning
2. Low-level
   2.1 Machine Resource Management
   2.2 Process Management Tool
3. ML Code
   3.1 Feature Extraction
   3.2 Static vs. Dynamic Training (Offline vs Oneline)
   3.3 Static vs. Dynamic Inference
4. Configuration
5. Deployment
6. Monitoring
7. Analysis Tools
8. Serving Infrastructure

## The main objectives to build a system that:

1. Reduces latency
2. Is integrated but loosely coupled with the other parts of the system, e.g. data stores, reporting, graphical user interface
3. Can scale both horizontally and vertically
4. Is message drive i.e. the system communicates via asynchronous, non-blocking message passing
5. Provide efficient computation with regards to workload management
6. Is fault-tolerant and self-healing i.e. breakdown management
7. Support batch and real-time processing