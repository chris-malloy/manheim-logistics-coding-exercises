# Manheim Logistics Coding Exercise Two

## Walkthrough

This module sets up an ECS Cluster, Service, and Task definition, along with a pre-configured load balancer that supports http and https traffic on ports 80 and 443, respectively. A load balancer rule acts as a redirector to ensure connections are established only on 443. Fargate launch type is used for simplicity's sake to set up a quick ECS environment. The task role ARN has been defaulted to empty stri
