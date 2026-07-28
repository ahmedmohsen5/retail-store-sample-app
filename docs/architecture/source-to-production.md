# Source-to-Production Flow

```mermaid
flowchart LR
    Developer[Developer] -->|Feature Branch and Pull Request| GitHub[GitHub Repository]

    GitHub --> CI[GitHub Actions CI]
    CI --> Validation[Lint, Tests and Security Checks]

    Validation -->|Failed| Block[Block Build and Release]
    Validation -->|Passed| Build[Build OCI Image]

    Build -->|Immutable SHA Tag| ECR[Amazon ECR]
    CI -->|Update Approved Image Reference| GitOps[GitOps Repository or Folder]

    GitOps --> ArgoCD[Argo CD]
    ArgoCD -->|Synchronise Desired State| EKS[Amazon EKS]
    ECR -->|Pull Approved Image| EKS

    EKS --> Prometheus[Prometheus]
    Prometheus --> Grafana[Grafana]
```

## Sources of Truth

- Application source: GitHub.
- Container artifacts: Amazon ECR.
- Deployment desired state: GitOps.
- Runtime platform: Amazon EKS.
- Monitoring evidence: Prometheus and Grafana.

## Release Rule

No image may be released or deployed unless required CI validation succeeds.