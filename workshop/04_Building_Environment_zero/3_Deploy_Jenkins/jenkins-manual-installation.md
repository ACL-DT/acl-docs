## Manual Installation
1. Jenkins will be the CI/CD pipeline tool of choice for this workshop. We'll deploy Jenkins as a Kubernetes service and use persistent volumes for the workspace and jobs directory, so that these data is persisted, if the pod is restarted. Jenkins will subsequentially start a pod for each build that is triggered. To save bandwidth, we create one more persistent volume that acts as a maven cache volume and is mounted automatically in each pod that runs a maven build.

1. Create Jenkins PVCs

    ```
    (bastion)$ kubectl create -f manifests-env-zero/k8s-jenkins-pvcs.yml
    ```

    Expected output:

    ![](../assets/kubectl-create-jenkinspvcs.png)

1. Update the following values in the `manifests-env-zero/k8s-jenkins-deployment.yml` with following values:
    - your GitHub orginzation
    - the email address of your GitHub user
    - the IP address of the Docker registry we've deployed in the previous step
    - the Dynatrace tenant URL (without https, as specified in [Gathering Facts](../1_Gathering_Facts))
    - an API Token form your Dynatrace tenant.

    ![](../assets/jenkins-env-vars.png)

    After updating the file, it should look something like this.

    ![](../assets/jenkins-env-vars-changed.png)

1. Create the Jenkins service and deployment

    ```
    (bastion)$ kubectl create -f manifests-env-zero/k8s-jenkins-deployment.yml
    ```

    Expected output:

    ![](../assets/kubectl-create-jenkinsdeployment.png)


1. Give Jenkins `clusteradmin` rights, so she can query for running pods and spawn pods when needed.

    ```
    (bastion)$ kubectl apply -f manifests-env-zero/k8s-jenkins-rbac.yml
    ```
---