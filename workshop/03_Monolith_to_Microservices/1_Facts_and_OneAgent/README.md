# Gathering Facts and Installing the OneAgent Operator

During this section we will gather all the information that we will lateron use during the labs. We will run a script that places all this information in a credentials file which other scripts can then pick up

## Data needed
* Credentials for `bastion host`
* Access to a `Dynatrace Tenant`.
* A `Dynatrace API token`. More information can be found [here](dynatrace_api_token.md)
* A `Dynatrace PAAS token`.
* A `Github account`
* A `Github organization` which we will use to fork the sockshop repositories. More information can be found [here](github_org.md)
* A `Github PAT` (Personal Access Token) which we will use to authenticate with Github. More information can be found [here](github_pat.md)

## Step 1 - Gathering Facts

1. After you have gathered all the information that you need, execute the following command on your bastion host from your home directory:
    ```
    (bastion)$ cd ~
    (bastion)$ ./defineCredentials.sh
    ```
1. This will ask you for the following information:
    * Dynatrace Tenant (both without https)
        - For SaaS: abc123456.live.dynatrace.com
        - For Managed: mydomain/e/1234567890123456789
    * Dynatrace API Token
    * Dynatrace PaaS Token
    * GitHub User Name
    * GitHub Personal Access Token
    * GitHub User Email
    * GitHub Organization
1. Confirm the details

## Step 2 - Deploying the OneAgent Operator

Dynatrace can be a great help in rearchitecting a monolithic application to a microservices one. It will give you insights on how many calls are being made to this potential new microservice, which is imperative in microservices design as the overhead of communication might be a deal breaker.

We will cover the intristics of the OneAgent Operator in a future section and at this point we will focus only on getting the OneAgent installed.

For that we have provided a OneAgent Operator installation script which will perform all the necesary steps for you.

On your bastion, execute the following:

```bash
(bastion)$ cd ~
(bastion)$ ./deployOneAgentOperator.sh
```

This script will take information you have entered in the previous step and use it to automatically deploy the OneAgent. Automation at its finest!

For more information about installing the OneAgent operator visit this [page.](https://www.dynatrace.com/support/help/technology-support/cloud-platforms/kubernetes/installation-and-operation/full-stack/deploy-oneagent-on-kubernetes/)

---

[Previous Step: Check Prerequisites](../0_Check_Prerequisites) :arrow_backward: :arrow_forward: [Next Step: Lift and shift Ticket Monster](../2_Lift-and-Shift_TicketMonster)

:arrow_up_small: [Back to overview](../)
