# LATAM Challenge

## Context 
- Data ingestion and storage using advance analytic.
- Expose HTTP API to be consumed.

## Objectives
- Develop a cloud system to ingest, store and expose data, using IaC, deploying CI/CD flows. Develop quality tests, monitoring, alerts to ensure the system is working properly.

## Architecture
- Add Architecture


#### Part 1: [IaC Infraestructure](./infra/README.md)

#### Part 2: Applications and CI/CD flows

- Add Readme [pubsub](./pubsubapp/README.md)
- Add Readme [app](./app/README.md)

#### Parte 3: [Integration test and quality control](./scripts/README.md)

- Create Test app
- Create Test Pubsub
- Add README

#### Part 4: Metrics and monitoring

Having an effective monitoring system collects data, aggregates it, stores it, visualizes metrics, and alerts you about any current and future problem in your systems. When you select the right tool you avoid inconsistency, misleading information and waste of time.

DataDog is an easy tool to implement in most of the cloud solutions, and easy to manage and create new boards using Terraform. Having the control with terraform allow us to avoid duplication, easy to deploy and scale.

With DataDog we can create the following monitors and read the following metrics: 

1. Networking monitor
    1. Packet lost
    2. Availability 
    3. Throughput 
    4. Connectivity

2. Data Monitor 
    1. Ingestion rate
    2. Failure Detection
    3. Error rate 
    4. Request rate
    5. Average response

3. Application Monitor
    1. CPU
    2. Memory
    3. Disk Usage
    4. Number of nodes
    5. Number of pods
    6. Service Failures and restarts
    7. Execution time
    8. Request rate
    9. Average response time

##### DataDog Implementation

Using the infra repository previously defined and the terraform pipeline described in [IaC Infraestructure](./infra/README.md) we are able to create our DataDog implementation. 

##### Next Steps

1. Create terraform scaffolding.
2. Create GitHub workflow to execute DataDog terraform.
2. Terraform monitors. 

#### Parte 5: Alertas y SRE (Opcional)

Defining service level indicators without knowing the volume, usage, requirements, how critical is the data, and the expectations is quite difficult but based on different books, papers and experience. I can propose the following  

- Users want to have access to their data as soon as possible, ensuring the ingestion latency is behind 50 milliseconds. Makes the user feel comfortable and confident with the process and the system.

- Having a system who works smoothly creates engagement and less frustration. Having an early failure detection and right metrics brings the possibility to identify the root cause easily. Defining 10 errors per request in a minute give us enough time to analyze our metrics, logs and give us the right time to tackle the problem easily.

- Analyzing data fast and precise is one of our main concerns. It’s necessary to have a low batch throughput in less than 50 milliseconds to keep the flow of the process straightforward.

- An application capable of display the results fast, simple and with fewer downtimes generates thrust. Monitoring the traffic, and compute resources (CPU / Memory) are quite important metrics that we need to have in place. To achieve it the right auto-scaling rules must be set in a 60%, giving enough time to the system to scale and if something is not working properly have the flexibility to step in and correct it.

SLOs
- Ensuring our data is ingested and processed in less than 50 milliseconds gives us a time response of our application less than .1 seconds. That is the average amount of time that the users cannot experience interruptions.
- Having the right metrics and monitoring tools give us the ability to analyze and find improvement areas and being able to have a 95% performance over the year.

##### Next Steps

1. Based in the SLAs, SLIs and SLOs and the monitoring tools, we can start creating an [alert system with DataDog](https://docs.datadoghq.com/monitors/), sending mails, slack mesasages, etc .... 
