# Fork GitHub Repositories

## Data needed
* Access to your bastion host
* GitHub user, email address and Personal Access Token
* A Github Organization to fork the repos to (created earlier)

## Steps

1. Connect to the bastion host ussing ssh and your credentials.

1. Execute the `~/forkGitHubRepositories.sh` script in your home directory.

    ```
    (bastion)$ cd ~
    (bastion)$ ./forkGitHubRepositories.sh
    ```

    This script `clone`s all needed repositories and uses the [`hub`](https://hub.github.com/) command to fork those repositories to the passed GitHub organization. After that, the script deletes all repositories and `clone`s them again from the new URL.

1. Ensure that all repositories have been cloned in the `~/repositories' folder on the bastion host - we need them later.

    ```
    (bastion)$ ls -1 ~/repositories/
    carts
    catalogue
    front-end
    jenkins-release-branch
    k8s-deploy-production
    k8s-deploy-staging
    orders
    payment
    queue-master
    shipping
    sockshop-infrastructure
    user
    ```

---

:arrow_forward: [Next Step: Deploy Docker Registry](../2_Deploy_Docker_Registry)

:arrow_up_small: [Back to overview](../)
