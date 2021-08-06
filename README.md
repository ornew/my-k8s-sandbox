# My local k8s sandbox

This repository is part of my manifest for local k8s development.

Each component can be installed individually.

However, most manifests use HelmRelease and Kustomization,
so Flux must be installed at a minimum.

## Flux

```
make ops/infra/flux-system/flux-system.yaml
kubectl apply -k ops/infra/flux-system
```

## Local Registry

https://kind.sigs.k8s.io/docs/user/local-registry/

```
make registry/up
make kind/registry/apply
```

Check

```
docker pull gcr.io/google-samples/hello-app:1.0
docker tag gcr.io/google-samples/hello-app:1.0 localhost:5000/hello-app:1.0
docker push localhost:5000/hello-app:1.0
kubectl create deployment hello-server --image=localhost:5000/hello-app:1.0
kubectl logs deploy/hello-server
```

## Tekton

```
kubectl apply -k ops/infra/tekton-pipelines
```

## Istio

```
kubectl apply -k ops/infra/monitoring
```

```
make ops/infra/istio-system/istio-system.yaml
kubectl apply -k ops/infra/istio-system
```
