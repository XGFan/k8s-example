helm install stable/traefik --name traefik \
--set dashboard.enabled=true,serviceType=NodePort,dashboard.domain=192.168.33.101.nip.io,rbac.enabled=true,externalIP=192.168.33.101 \
--namespace kube-system
#https://hub.helm.sh/charts/stable/traefik