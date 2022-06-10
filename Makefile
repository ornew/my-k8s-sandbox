clusters/dev/flux.yaml: config/flux/kustomization.yaml
	mkdir -p $(@D)
	kubectl kustomize config/flux > $@

example/gen/secret.yaml:
	flux create secret git k8s-sandbox \
		--url=ssh://git@github.com/ornew/k8s-sandbox \
		--ssh-key-algorithm=ecdsa \
		--ssh-ecdsa-curve=p521 \
		--export > secret.yaml

tenants/system/dev/tekton-pipelines/tekton.yaml: config/tekton/base/kustomization.yaml config/tekton/dev/kustomization.yaml
	mkdir -p $(@D)
	kubectl kustomize config/tekton/dev > $@

diff/tekton:
	t=$$(mktemp -d) \
	&& kubectl kustomize config/tekton/base > $$t/base.yaml \
	&& kubectl kustomize config/tekton/dev > $$t/dev.yaml \
	&& diff -y --suppress-common-lines $$t/base.yaml $$t/dev.yaml

up:
	limactl start --name=k8s-sandbox-control-plane-1 config/lima/control-plane.yaml --tty=false

ssh:
	$$(limactl show-ssh k8s-sandbox-control-plane-1 -f cmd) -L 30080:127.0.0.1:30080

#registry/up:
#	docker run \
#		--name registry.local \
#		-d --restart=always -p "5000:5000" \
#		registry:2
#
#registry/down:
#	docker stop registry.local
#
#kind/up-registry:
#	docker network connect "kind" "registry.local" || true
#	kubectl apply -f ./infra/kind/registry.yaml

#conftest/tenants/dev:
#	conftest test --policy ./infra/opa/policy --fail-on-warn tenants/dev
