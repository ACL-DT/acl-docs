## Manual Installation

1. Navigate to the manifest directory for Ansible Tower
    ```
    $ cd ~/manifests-ansible-tower
    ```

1. Create the resources with the following commands.
    ```
    $ kubectl create -f ns.yml
    $ kubectl create -f dep.yml
    $ kubectl create -f svc.yml
    ```
    This will create a new namespace `tower`, a deployment, as well as a service called `ansible-tower`. 

1. Retrieve the public (external) IP of your Ansible Tower installation.
    ```
    $ kubectl get svc -n tower

    Output
    NAME            TYPE           CLUSTER-IP      EXTERNAL-IP      PORT(S)         AGE
    ansible-tower   LoadBalancer   XX.XX.XXX.XXX   XX.XXX.XXX.XXX   443:32096/TCP   18m
    ```

1. Open your favourite browser and navigate to `https://external-ip` (please note the _https_). You login credentials are:
    - Username: admin
    - Password: dynatrace

1. Submit the Ansible Tower license when prompted.
    ![ansible license prompt](../assets/ansible-license.png)


    In case you don't have your license yet, you can get a free license here: https://www.ansible.com/license 

1. You should see the default Dashboard of Ansible Tower:
![ansible tower dashboard](../assets/ansible-tower-initial.png)

---

:arrow_forward: [Next Step: Setup Tower](../02_Setup_Tower)

:arrow_up_small: [Back to overview](../)
