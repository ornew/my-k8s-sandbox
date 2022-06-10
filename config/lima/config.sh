set -ex
vm=k8s-sandbox-control-plane-1
mkdir -p ~/.lima/$vm/conf
c=~/.lima/$vm/conf/kubeconfig.yaml
limactl shell $vm sudo cat /etc/kubernetes/admin.conf > $c

a=~/.kube/config

yq ea '
(
  select(fi == 0)
    | del(.clusters[] | select(.name == "sandbox") )
    | del(.users[] | select(.name == "sandbox-admin") )
    | del(.contexts[] | select(.name == "sandbox@admin") )
)
*+ (
select(fi == 1)
  | .clusters[0].name = "sandbox"
  | .users[0].name = "sandbox-admin"
  | .contexts[0].name = "sandbox@admin"
  | .contexts[0].context.cluster = "sandbox"
  | .contexts[0].context.user = "sandbox-admin"
  | .current-context = "sandbox@admin"
)' $a $c > config.yaml
mv config.yaml $a
