# PVC Auto-Resizer fork

Designed for troubleshooting and testing purposes.

## Usage

Build and push the Docker image:

```bash
docker build --platform linux/amd64 -t pvcauto:local . && \
docker tag pvcauto:local pdishark/pvc-autoresizer && \
docker push pdishark/pvc-autoresizer
```

Restart the pods to apply the changes and watch the logs:

```bash
kubectl rollout restart -n kube-system deployment pvc-autoresizer-controller && \
kubectl rollout status -n kube-system deployment pvc-autoresizer-controller && \
kubectl logs -f -n kube-system -l app.kubernetes.io/name=pvc-autoresizer
```
