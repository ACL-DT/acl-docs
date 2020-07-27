# Simulate Early Pipeline Break

In this lab you'll release a service to staging that is not tested based on performance tests. Intentionally, the service is slowed down to fail at the e2e check in the staging pipeline.

## Step 1: Introduce a Slowdown into the Carts Service

1. Make sure you are in the master branch.
    ```
    (local)$ git checkout master
    ```
1. In the directory of `carts\`, open the file: `carts\src\main\resources\application.properties`.
1. Change the value of `delayInMillis` from `0` to `1100` and save.
1. Commit/Push the changes to your GitHub Repository *carts*.

## Step 2: Create a new Release

1. Go to **Jenkins** and **sockshop**.
1. Click on **create-release-branch** pipeline and **Schedule a build with parameters**.
1. For the parameter **SERVICE**, enter the name of the service you want to create a release for (**carts**)

    The pipeline does the following:
    1. Reads the current version of the microservice.
    1. Creates a release branch with the name release/**version**.
    1. Increments the current version by 1. 
    1. Commits/Pushes the new version to the Git repository.

![pipeline_release_branch_1](../assets/pipeline_release_branch_1.png)
![pipeline_release_branch_2](../assets/pipeline_release_branch_2.png)

## Step 3. Build the new Release in Jenkins
1. After the **create-release-branch** pipeline has finished, go to **Jenkins** and **sockshop**.
1. Click on **carts** pipeline and **Scan Multibranch Pipeline Now**.
1. Hit **F5** and you should see the new branch, which gets built and deployed to staging. 
1. (trigger build manually) Click on the newly detected release branch and click on **Build Now**.

## Step 4: Follow the Jenkins Build Pipelines

1. Open the current build by clicking on the **#no**.
1. In the Console Output wait for *Starting building: k8s-deploy-staging* and click on that link.
1. The pipeline should fail due to a too high response time. 
1. Click on **Performance Report** to see the average response time of the URI: *_cart - add to cart*

![break_early](../assets/break_early.png)

## Step 5: Remove the Slowdown in the Carts Service

1. Make sure you are in the master branch.
    ```
    (local)$ git checkout master
    ```
1. In the directory of `carts\`, open the file: `carts\src\main\resources\application.properties`.
1. Change the value of `delayInMillis` from `1100` to `0` and save.
1. Commit/Push the changes to your GitHub Repository *carts*.

## Step 6: Create a new Release

1. Go to **Jenkins** and **sockshop**.
1. Click on **create-release-branch** pipeline and **Schedule a build with parameters**.
1. For the parameter **SERVICE**, enter the name of the service you want to create a release for (**carts**)

## Step 7. Build the new Release in Jenkins

1. Go to **Jenkins** and **sockshop**.
1. Click on **carts** pipeline and **Scan Multibranch Pipeline Now**.
1. Regresh your browser to see the new branch, which gets built and deployed to staging.
1. (trigger build manually) Click on the latest created release and then select **Build Now**.


---
[Previous Step: Harden Staging Pipeline with Quality Gate](../01_Harden_Staging_Pipeline_with_Quality_Gate) :arrow_backward: :arrow_forward: [Next Step: Setup Self Healing for Production](../03_Setup_Self_Healing_for_Production)

:arrow_up_small: [Back to overview](../)
