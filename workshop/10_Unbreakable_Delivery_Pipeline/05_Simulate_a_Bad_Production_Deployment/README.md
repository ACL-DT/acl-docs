# Simulate a Bad Production Deployment

In this lab you'll create a deployment of the front-end service that passes the quality gate in the staging pipeline and will get deployed to production. Besides, the entire traffic will be be routed to this new version using a prepared deployment pipeline. 
  
## Step 1: Adjust sensitivity of anomaly detection
1. Go to **Transaction & services** and select the **front-end.production** service.
1. Click on the **...** button in the top right corner and select **Edit**.
1. Go to **Anomaly Detection** and disable the switch for *Use global anomaly detection settings*.
    * In the `Detect increases in failure rate` dropdown, select `using fixed thresholds`.
    * Alert if `2`% custom error rate threshold is exceeded during any 5-minute period.
    * Sensitivity: `High`
1. Go back to the **front-end- [production]** service.

## Step 2: Run job template in the Ansible Tower
1. Go to Ansible Tower.
1. Start the job template **canary** to trigger a canary release of version 2 of the front-end service.

## Step 3: Now we need to wait until a problem appears in Dynatrace.
1. When Dynatrace opens a problem notification, it automatically invokes the remediation action as defined in the canary playbook. In fact, the remediation action refers to the **remediation** playbook, which then triggers the **canary-reset** playbook. Consequently, you see the executed playbooks when navigating to *Ansible Tower* and *Jobs*. Moreover, the failure rate of the front-end service must decrease since new traffic is routed to the previous version of front-end.

## (optional) Troubleshooting: If front-end does not show up in Dynatrace
1. Make sure to be in the istio folder in bastion.
    ```
    (bastion)$ pwd
    ~/repositories/k8s-deploy-production/istio
    ```
1. Restart the pilot and re-create the virtual service for sockshop.
   ```
   (bastion)$ kubectl get pods -n istio-system
   (bastion)$ kubectl delete pod <the name of your istio-pilot> -n istio-system
   (bastion)$ kubectl delete -f ./virtual_service.yml
   (bastion)$ kubectl create -f ./virtual_service.yml
   ```

## (optional) Route traffic to the new front-end version
1. Go to your **Jenkins** and click on **k8s-deploy-production.canary**.
1. Click on **master** and **Build with Parameters**:
    * VERSION1: 0
    * VERSION2: 100
    * REMEDIATIONURL: *empty*
1. Hit **Build** and wait until the pipeline shows: *Success*.

---
[Previous Step: Setup Self Healing for Production](../03_Setup_Self_Healing_for_Production) :arrow_backward:

:arrow_up_small: [Back to overview](../)
