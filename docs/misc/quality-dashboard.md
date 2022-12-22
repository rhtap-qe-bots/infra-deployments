---
title: Quality Dashboard
---

Quality dashboard is managed by `components/quality-dashboard`.

By default the frontend is using StoneSoup Staging cluster for backend. If you want to use backend on your cluster you need to set secrets for `rds-endpoint`, `POSTGRES_PASSWORD` and `github-token` in `quality-dashboard` namespace and also push `components/quality-dashboard/frontend/kustomization.yaml`(the route to backend is changed by script `hack/util-set-quality-dashboard-backend-route.sh` in development and preview cluster modes).

More information about quality-dashboard you can found in repo: `https://github.com/redhat-appstudio/quality-dashboard`.