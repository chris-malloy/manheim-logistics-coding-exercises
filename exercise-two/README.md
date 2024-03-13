# Manheim Logistics Coding Exercise Two

## Walkthrough

This module sets up an ECS Cluster, Service, and Task definition, along with a pre-configured load balancer that supports http and https traffic on ports 80 and 443, respectively. A load balancer rule acts as a redirector to ensure connections are established only on 443. Fargate launch type is used for simplicity's sake to set up a quick ECS environment. An am IAM role was created to be used as the ECS task role. As a demonstration, this grants full s3 access, but in a real production environment this should be locked down to the least permissive policy possible.
