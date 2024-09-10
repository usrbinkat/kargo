kubectl run -n kube-system diskops \
  --image=ghcr.io/containercraft/devcontainer:latest \
  --privileged=true \
  --overrides='
{
  "apiVersion": "v1",
  "spec": {
    "hostPID": true,
    "hostIPC": true,
    "hostNetwork": true,
    "containers": [
      {
        "name": "diskops",
        "image": "ghcr.io/containercraft/devcontainer:latest",
        "command": ["/bin/bash", "-c", "sleep infinity"],
        "securityContext": {
          "privileged": true,
          "capabilities": {
            "add": ["SYS_ADMIN", "NET_ADMIN"]
          },
          "runAsUser": 0
        },
        "volumeMounts": [
          { "name": "dev", "mountPath": "/mnt/root/dev" },
          { "name": "sys", "mountPath": "/mnt/root/sys" },
          { "name": "proc", "mountPath": "/mnt/root/proc" },
          { "name": "root", "mountPath": "/mnt/root" }
        ],
        "resources": {
          "limits": {
            "cpu": "1",
            "memory": "1Gi"
          }
        }
      }
    ],
    "volumes": [
      { "name": "dev", "hostPath": { "path": "/dev" }},
      { "name": "sys", "hostPath": { "path": "/sys" }},
      { "name": "proc", "hostPath": { "path": "/proc" }},
      { "name": "root", "hostPath": { "path": "/" }}
    ],
    "restartPolicy": "Never"
  }
}' --restart=Never -i --tty
