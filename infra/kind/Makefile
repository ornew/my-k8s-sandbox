registry/up:
	docker run \
		--name registry.local \
		-d --restart=always -p "5000:5000" \
		registry:2

registry/down:
	docker stop registry.local

kind/up-registry:
	docker network connect "kind" "registry.local" || true
	kubectl apply -f ./registry.yaml

kind/up:
	kind create cluster --name sandbox --config=config.yaml

kind/down:
	kind delete cluster --name sandbox
