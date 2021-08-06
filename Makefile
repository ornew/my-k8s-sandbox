registry/up:
	docker run \
		--name registry.local \
		-d --restart=always -p "5000:5000" \
		registry:2

registry/down:
	docker stop registry.local

kind/registry/apply:
	docker network connect "kind" "registry.local" || true
	kubectl apply -f ./kind/registry.yaml

kind/up:
	kind create cluster --name sandbox --config=kind/config.yaml

kind/down:
	kind delete cluster --name sandbox

ops/infra/flux-system/flux-system.yaml:
	mkdir -p $(@D)
	flux install --export > $@

ops/infra/istio-system/istio-system.yaml: ./istiooperator.yaml
	mkdir -p $(@D)
	istioctl manifest generate \
		-f ./istiooperator.yaml \
		> $@

secret.yaml:
	flux create secret git k8s-sandbox \
		--url=ssh://git@github.com/ornew/k8s-sandbox \
		--ssh-key-algorithm=ecdsa \
		--ssh-ecdsa-curve=p521 \
		--export > secret.yaml
