../../clusters/dev/istio-system/istio-system.yaml: ./istiooperator.yaml
	mkdir -p $(@D)
	istioctl manifest generate \
		-f ./istiooperator.yaml \
		> $@
