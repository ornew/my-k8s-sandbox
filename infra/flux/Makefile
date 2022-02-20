.PHONY: ../../clusters/dev/flux-system/flux-system.yaml
../../clusters/dev/flux-system/flux-system.yaml:
	mkdir -p $(@D)
	flux install --export > $@

example/gen/secret.yaml:
	flux create secret git k8s-sandbox \
		--url=ssh://git@github.com/ornew/k8s-sandbox \
		--ssh-key-algorithm=ecdsa \
		--ssh-ecdsa-curve=p521 \
		--export > secret.yaml
