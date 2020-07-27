# Manual Installation

1. Go to your `home` directory on the bastion host and install Istio's custom resource definitions (CRDs). It might take a few seconds to setup all resources for Istio.

    ```
    (bastion)$ cd
    (bastion)$ kubectl apply -f manifests-istio/crds.yaml
    ```

1. For this session we'll install Istio without mutual TLS authentication between the sidecars

    ```
    (bastion)$ kubectl apply -f manifests-istio/istio-demo.yaml
    ```

1. Verify the installation

    ```
    (bastion)$ kubectl get services -n istio-system
    istio-citadel            ClusterIP      10.11.255.107   <none>           8060/TCP,9093/TCP                                2m
    istio-egressgateway      ClusterIP      10.11.247.47    <none>           80/TCP,443/TCP                                   2m
    istio-galley             ClusterIP      10.11.241.172   <none>           443/TCP,9093/TCP                                 2m
    istio-ingressgateway     LoadBalancer   10.11.255.81    35.224.227.175   80:31380/TCP,443:31390/TCP,31400:31400/TCP,...   2m
    istio-pilot              ClusterIP      10.11.254.45    <none>           15010/TCP,15011/TCP,8080/TCP,9093/TCP            2m
    istio-policy             ClusterIP      10.11.241.98    <none>           9091/TCP,15004/TCP,9093/TCP                      2m
    istio-sidecar-injector   ClusterIP      10.11.241.182   <none>           443/TCP                                          2m
    istio-telemetry          ClusterIP      10.11.244.132   <none>           9091/TCP,15004/TCP,9093/TCP,42422/TCP            2m
    prometheus               ClusterIP      10.11.245.189   <none>           9090/TCP                                         2m
    ```

    ```
    (bastion)$ kubectl get pods -n istio-system
    NAME                                      READY     STATUS      RESTARTS   AGE
    istio-citadel-6d7f9c545b-w2sxx            1/1       Running     0          1m
    istio-cleanup-secrets-q95mt               0/1       Completed   0          1m
    istio-egressgateway-866885bb49-c9rnj      1/1       Running     0          1m
    istio-galley-6d74549bb9-4d9lg             1/1       Running     0          1m
    istio-ingressgateway-6c6ffb1mc8-zk54w     1/1       Running     0          1m
    istio-pilot-595545c7c6-8hngq              2/2       Running     0          1m
    istio-policy-688f99c9c4-9r6l8             2/2       Running     7          1m
    istio-security-post-install-cvzmw         0/1       Completed   5          1m
    istio-sidecar-injector-74855c54b9-9thls   1/1       Running     0          1m
    istio-telemetry-69b794ff59-2rn5x          2/2       Running     0          1m
    istio-tracing-ff94688bb-b5zdl             1/1       Running     0          1m
    prometheus-f556886b8-7xfbj                1/1       Running     0          1m
    ```