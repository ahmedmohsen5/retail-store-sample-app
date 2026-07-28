# ADR-001: DevOps Platform Design

## Status

Accepted

## Context

The retail microservices application needs a production-style DevOps lifecycle
that remains affordable and manageable as a portfolio project.

## Decision

- GitHub Actions for CI/CD.
- Amazon ECR for container images.
- Terraform for AWS infrastructure.
- Amazon EKS for Kubernetes.
- Helm for application packaging.
- Argo CD for GitOps.
- Prometheus and Grafana for observability.
- Immutable commit-SHA image tags.
- Secrets stored outside Git.
- One training cluster with environment namespaces for the MVP.

## Business Reason

The platform must demonstrate reliable delivery while limiting cloud cost,
manual effort, deployment risk and operational overhead.

## DevOps Reason

The design provides automation, repeatability, traceability, observability,
controlled releases and Git-based recovery.

## Consequences

### Positive

- Auditable delivery flow.
- Repeatable infrastructure.
- Traceable releases.
- Lower CI platform maintenance.
- Easier rollback.

### Negative

- Namespace isolation is weaker than separate AWS accounts or clusters.
- GitHub Actions introduces dependency on GitHub-hosted CI.
- GitOps adds repository and reconciliation responsibilities.

## Future Review

After completing the MVP, evaluate:

- Separate AWS accounts.
- Separate production cluster.
- Dedicated GitOps repository.
- Self-hosted GitHub Actions runners.