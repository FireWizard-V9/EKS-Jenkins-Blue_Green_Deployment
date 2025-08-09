EKS Blue-Green Deployment with Jenkins, Terraform, and RBAC

This project demonstrates a Blue-Green Deployment strategy for a Spring Boot application with MySQL on AWS EKS, fully automated through a Jenkins Declarative Pipeline.

Infrastructure is provisioned using Terraform, including:

    EKS Cluster + Node Groups

    EC2 instances for Jenkins, SonarQube, Nexus

    VPC, IAM roles, Security Groups

    RBAC for secure Jenkins–K8s access

Pipeline Workflow:

    Git checkout from GitHub

    Maven compile & build

    Trivy filesystem scan

    SonarQube code quality analysis

    Build JAR & deploy artifact to Nexus

    Build & push Docker image to Docker Hub

    Trivy image scan

    Deploy MySQL to Kubernetes (ClusterIP)

    Deploy Blue or Green app pods (Spring Boot)

    Switch LoadBalancer traffic between environments

    Verify deployment status

Blue-Green Architecture:

    Blue and Green pods run in parallel

    LoadBalancer service routes traffic to one environment

    MySQL pod remains unchanged

    RBAC controls Jenkins API access
