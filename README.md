# LATAM Challenge

## Context 
- Data ingestion and storage using advance analytic.
- Expose HTTP API to be consumed.

## Objectives
- Develop a cloud system to ingest, store and expose data, using IaC, deploying CI/CD flows. Develop quality tests, monitoring, alerts to ensure the system is working properly.

## Architecture

The proposal architecture tries to be the simplest and easiest to scale. It's using a Pub/Sub component, which is in charge to handle the requests and put in the right subscriptions and topics, allowing us to process all the data without losing anything. Also, it gives us the possibility to create and organize the data in different topics and subscriptions, helping us to scale with order if it's necessary. 

![alt text](./img/arch.png)

Once the data is in the subscription, we have a microservice ([pubsubapp](./pubsubapp/README.md)) that is in charge to pull the data and store it in the right tables. This microservice is living in a Kubernetes cluster inside one VPC to add an extra layer of security. The processed data will be stored in Cloud Table because it's designed to process high volumes of data, create datasets and tables to organize our input data and has the advantage of BigQuery for analytic purposes. 

In the presentation layer, we have a microservice ([app](./app/README.md)), which is in charge to retrieve data from BigTable and show the information via HTTP. To manage our APIs, define policies for publications and usage restrictions for our microservices, we are using API Gateway to easily do all these operations through its central interface.

##### Next Steps

1. Implement in a real scenario.
2. Discuss volume and traffic expected. 
3. Use policies to define control access.
4. Budget expectations. 

#### Part 1: [IaC Infraestructure](./infra/README.md)

#### Part 2: Applications and CI/CD flows

- [pubsub README](./pubsubapp/README.md)
- [app README](./app/README.md)

#### Part 3: [Integration test and quality control](./scripts/README.md)

#### Part 4: Metrics and monitoring

Having an effective monitoring system collects data, aggregates it, stores it, visualizes metrics, and alerts you about any current and future problem in your systems. When you select the right tool, you avoid inconsistency, misleading information, and waste of time.

DataDog is an easy tool to implement in most of the cloud solutions, and easy to manage and create new boards using Terraform. Having the control with Terraform allow us to avoid duplication, easy to deploy and scale.

With DataDog, we can create the following monitors and read the following metrics: 

1. Networking monitor
    1. Packet lost
    2. Availability 
    3. Throughput 
    4. Connectivity

2. Data Monitor 
    1. Ingestion rate
    2. Failure detection
    3. Error rate 
    4. Request rate
    5. Average response

3. Application Monitor
    1. CPU
    2. Memory
    3. Disk usage
    4. Number of nodes
    5. Number of pods
    6. Service failures and restarts
    7. Execution time
    8. Request rate
    9. Average response time

##### DataDog Implementation

Using the infra repository previously defined and the Terraform pipeline described in [IaC Infraestructure](./infra/README.md), we are able to create our DataDog implementation. 

##### Next Steps

1. Create Terraform scaffolding.
2. Create GitHub workflow to execute DataDog Terraform.
2. Terraform monitors. 

#### Parte 5: Alertas y SRE (Opcional)

Defining service level indicators without knowing the volume, usage, requirements, importance of the data, and the expectations is quite difficult; but, based on different books, papers and experience, I can propose the following:  

- Users want to have access to their data as soon as possible, ensuring the ingestion latency is behind 50 milliseconds. This makes the user feel comfortable and confident with the process and the system.

- Having a system that works smoothly creates engagement and less frustration. Having an early failure detection and right metrics brings the possibility to identify the root cause easily. Defining 10 errors per request in a minute gives us enough time to analyze our metrics, logs, and gives us the right time to tackle the problem easily.

- Analyzing data quickly and precisely is one of our main concerns. It’s necessary to have a low batch throughput in less than 50 milliseconds to keep the flow of the process straightforward.

- An application capable of displaying the results quickly, simply and with fewer downtimes generates thrust. Monitoring the traffic and computing resources (CPU / Memory) are quite important metrics that we need to have in place. To achieve these metrics, the right auto-scaling rules must be set at 60%, giving enough time for the system to scale. If something is not working properly, there is enough flexibility to step in and correct it.

SLOs
- Ensuring our data is ingested and processed in less than 50 milliseconds gives our application a time response of less than .1 seconds. On average, users do not perceive this amount of time as an interruption. 
- Having the right metrics and monitoring tools gives us the ability to analyze and find improvement areas as well as the capacity to have a 95% performance over the year.

##### Next Steps

1. Based in the SLAs, SLIs and SLOs and the monitoring tools, we can start creating an [alert system with DataDog](https://docs.datadoghq.com/monitors/), sending emails, Slack messages, etc .... 
