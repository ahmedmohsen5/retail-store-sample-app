# Retail Store DevOps Implementation Blueprint

## CI/CD Tool

Selected tool: GitHub Actions.

Reasons:

- Native integration with the GitHub repository.
- Pull-request validation.
- Pipeline as Code under `.github/workflows`.
- AWS authentication through OIDC.
- No Jenkins controller or agents to maintain for the MVP.

Jenkins may be evaluated later when self-hosted execution is a documented
requirement.

## Environment Responsibilities

### Development

- Fast feedback and integration testing.
- Local Docker Compose.
- Automated CI checks.
- Development deployment may use the `retail-development` namespace.

### Staging

- Production-like validation.
- Uses images that passed CI and security checks.
- Validates Helm, GitOps, monitoring, integration and rollback.
- Namespace: `retail-staging`.

### Production

- Stable approved releases only.
- Deployment from an immutable Git commit or release tag.
- Protected deployment approval.
- Namespace: `retail-production` for the portfolio MVP.

## Image Naming

ECR repository pattern:

`retail-<service>`

Immutable deployment tag:

`sha-<short-commit>`

Release tag:

`v<major>.<minor>.<patch>`

Examples:

- `retail-catalog:sha-a1b2c3d`
- `retail-catalog:v1.0.0`

Do not use `latest` as the deployment source of truth.

## Configuration Boundaries

Container images contain:

- Application code.
- Runtime dependencies.
- Environment-independent defaults.

Helm and GitOps contain:

- Replica counts.
- Resource requests and limits.
- Service URLs.
- Environment-specific non-secret configuration.

Secrets contain:

- Passwords.
- Tokens.
- API keys.
- Private certificates.

Secrets must not be committed to Git.

## Branching Strategy

- `main`: stable and production-ready.
- `develop`: integration branch when used.
- `feature/*`: application features.
- `fix/*`: defect fixes.
- `docs/*`: documentation and architecture.

## Pull Request Rules

- No direct push to `main`.
- No direct push to `develop`.
- Required CI checks must pass.
- At least one approval before production changes.
- Use squash merge for a clear history.
- Production releases use Git tags.

## AWS Cost Controls

- Run only one training EKS cluster at a time.
- Use namespaces for environment separation during the MVP.
- Destroy temporary resources after validation.
- Avoid NAT Gateway unless a documented requirement needs it.
- Configure AWS Budget alerts.
- Advanced improvements must not block the MVP.

## Success Criteria

- Every selected tool solves a documented requirement.
- Source code and DevOps configuration are separated.
- No secret is stored in Git.
- Every deployment maps to a Git commit and immutable image.
- Infrastructure and deployment can be reproduced.
- CI blocks failing or unsafe releases.
- Rollback and destroy procedures are documented.