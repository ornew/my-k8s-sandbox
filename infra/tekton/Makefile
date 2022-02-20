.PHONY: ../../clusters/dev/tekton-pipelines/tekton.yaml

check/dev:
	kustomize build base > tmp.base.yaml
	kustomize build dev > tmp.dev.yaml
	diff tmp.base.yaml tmp.dev.yaml

check/clean:
	rm tmp.*.yaml

../../clusters/dev/tekton-pipelines/tekton.yaml: base/kustomization.yaml dev/kustomization.yaml
	mkdir -p $(@D)
	kustomize build dev > $@
