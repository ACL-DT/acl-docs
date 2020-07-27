# Integration Ansible Tower Runbook in Dynatrace

Let us integration the defined _remediation runbook_ in Dynatrace in a way, that it will be called each time Dynatrace detects a problem. Please note that in a more enterprise scenario, you might want to define _Alerting profiles_ to be able to control in a more fine-grained way when to call a remediation runbook.

1. Setup a **Problem Notification** in Dynatrace
    - Navigate to _Settings -> Integration -> Problem notifications_
    - Select `Set up Notifications` and then click `Ansible Tower`.

    ![notifications](../assets/setup-notifications.png)
    ![integration](../assets/ansible-integration.png)

1. Enter your Ansible Tower job template URL and Ansible Tower credentials.
    - Name: e.g., "remediation playbook"
    - Ansible Tower job template URL: copy & paste the Ansible Tower job URL from your Ansible Tower remediation job template, e.g., `https://XX.XXX.XX.XXX/#/templates/job_template/18`
    - Username: your Ansible Tower username `admin`
    - Password: your Ansible Tower password `dynatrace`
    - Set the alert profile to `Sockshop Error Profile'
    - Click "Send test notification" --> a green banner should appear
    - Save the integration

    ![integration successful](../assets/ansible-integration-successful.png)

1. Login (or navigate back) to your Ansible Tower instance and check what happenend when setting up the integration.
    - Navigate to _Jobs_ and click on your _remediation-user0_ job
    - You can see all tasks from the playbook that have been triggered by the integration.

    ![integration run](../assets/ansible-integration-run.png)

1. Apply anomaly detection rules

Both problem and anomaly detection in Dynatrace leverage AI technology. This means that the AI learns how each and every microservice behaves and baselines them. Therefore, in a demo scenario like we have right now, we have to override the AI engine with user-defined values to allow the creation of problems due to an artificial increase of a failure rate. (Please note if we would have the application running and simulate end-user traffic for a couple of days there would be no need for this step.)

In your Dynatrace tenant, navigate to "Transaction & services" and filter by: *Tag:app:carts* and *Tag:environment:production* 

![services](../assets/dynatrace-services.png)

Click on the **ItemsController** and then on the three dots ( <kbd>...</kbd> ) next to the service name. Click on *Edit*. 
![service-edit](../assets/dynatrace-service-edit.png)

On the next screen, edit the anomaly detection settings as seen in the following screenshot.
- **Globaly anomaly detection** has to be **turned off**
- Detect increases in **failure rate** using **fixed thresholds**
- Alert if **10 %** custom failure rate threshold is exceed during any 5-minute period.
- Sensitivity: **High**

![anomaly detection](../assets/anomaly-detection.png)

---

[Previous Step: Setup Tower](../02_Setup_Tower) :arrow_backward: :arrow_forward: [Next Step: Run Playbook](../04_Run_Playbook)

:arrow_up_small: [Back to overview](../)
