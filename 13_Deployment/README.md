# 13_Deployment

Build, release, and deployment documentation.

## Build Commands

```bash
# iOS release
flutter build ipa --release --dart-define=ANTHROPIC_API_KEY=$KEY

# Android release
flutter build appbundle --release --dart-define=ANTHROPIC_API_KEY=$KEY
```

## Subfolders

- `Docker/` — Dockerfile templates
- `Kubernetes/` — K8s manifests
- `Terraform/` — Cloud infrastructure
- `GitHub_Actions/` — CI/CD workflows
