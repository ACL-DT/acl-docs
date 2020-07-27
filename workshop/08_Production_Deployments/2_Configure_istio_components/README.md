# Configure Istio Components 

## ***Skip this lab if auto installation was installation method applied***

In this lab, we enable Istio's automatic sidecar injection for one k8s namespace, we create and configure mandatory Istio components, and allow mesh external traffic to leave the service mesh.

## Data needed
* Dynatrace environment URL
* PaaS Token

## Allow connections to external services

**Note:** This is not required when in the previous step you opted for *Automatic Installation*

1. We'll define `ServiceEntry`s that add entries to Istio's internal service registry and allow for connection to services that are external to the service mesh, e.g. mesh-external hosted databases for the `carts` and `orders` service.

    ```
    (bastion)$ kubectl apply -f repositories/k8s-deploy-production/istio/service_entries_sockshop.yml
    ```

    `service_entries_sockshop.yml`:
    ```
    ---
    apiVersion: networking.istio.io/v1alpha3
    kind: ServiceEntry
    metadata:
    name: catalogue-db
    spec:
    hosts:
    - sockshop-catalogue-db.ckbkxcwrvff7.eu-west-1.rds.amazonaws.com
    ports:
    - number: 3306
        name: tcp
        protocol: TCP
    resolution: DNS
    location: MESH_EXTERNAL
    ---
    apiVersion: networking.istio.io/v1alpha3
    kind: ServiceEntry
    metadata:
    name: carts-orders-db
    spec:
    hosts:
    - "*.mongodb.net"
    addresses:
    - 18.214.93.113
    - 18.215.19.51
    - 54.82.134.106
    ports:
    - number: 27017
        name: tcp
        protocol: TCP
    location: MESH_EXTERNAL
    ```

1. Last but not least, we need to configure `ServiceEntry`s for the Dynatrace OneAgent, so the language specific components that run inside the pods can communicate with the Dynatrace servers.

    In order to do this, run the following commands:
    
    ```
    cd ~/repositories/k8s-deploy-production/istio/
    ./istioconfig.sh <TENANT URL> <PAAS TOKEN>
    E.G. ./istioconfig.sh dhgf1234.live.dynatrace.com gjhs84539gjdf34
    ```
    
    Ensure ```service_entry_oneagent.yml``` is filled in with your tenant and active gate component links.

    ```
    nano ~/repositories/k8s-deploy-production/istio/service_entry_oneagent.yml
    ```

    Apply the configuration.

    ```
    (bastion)$ pwd
    ~/repositories/k8s-deploy-production
    (bastion)$ kubectl apply -f istio/service_entry_oneagent.yml
    ```

    If there is issues, please refer to [Istio Manual Config](./IstioManualConfig.md)
---

[Previous Step: Install Istio](../1_Install_istio) :arrow_backward: :arrow_forward: [Next Step: Deploy to Production](../3_Deploy_to_production)

:arrow_up_small: [Back to overview](../)
