# Harden Staging Pipeline with Quality Gate

In this lab you'll add an additional quality gate to your CI pipeline. In other words, an end-to-end check will verify the functionality of the sockshop application in the staging environment.

## Step 1: Add e2e Test to Staging Pipeline
1. Uncomment the following snippet in the Jenkins pipeline of `k8s-deploy-staging`.

    ```bash
    stage('Staging Warm Up') {
      steps {
        echo "Waiting for the service to start..."
        container('kubectl') {
          script {
            def status = waitForDeployment (
              deploymentName: "${env.APP_NAME}",
              environment: 'staging'
            )
            if(status !=0 ){
              currentBuild.result = 'FAILED'
              error "Deployment did not finish before timeout."
            }
          }
        }
        echo "Running one iteration with one VU to warm up service"
        container('jmeter') {
          script {
            def status = executeJMeter (
              scriptName: "jmeter/front-end_e2e_load.jmx",
              resultsDir: "e2eCheck_${env.APP_NAME}_warmup_${env.VERSION}_${BUILD_NUMBER}",
              serverUrl: "front-end.staging",
              serverPort: 8080,
              checkPath: '/health',
              vuCount: 1,
              loopCount: 1,
              LTN: "e2eCheck_${BUILD_NUMBER}_warmup",
              funcValidation: false,
              avgRtValidation: 4000
            )
            if (status != 0) {
              currentBuild.result = 'FAILED'
              error "Warm up round in staging failed."
            }
          }
        }
        sleep 60
      }
    }

    stage('Run production ready e2e check in staging') {
      steps {
        echo "Waiting for the service to start..."
        sleep 150
        recordDynatraceSession (
          envId: 'Dynatrace Tenant',
          testCase: 'loadtest',
          tagMatchRules: tagMatchRules
        ) 
        {
          container('jmeter') {
            script {
              def status = executeJMeter ( 
                scriptName: "jmeter/front-end_e2e_load.jmx",
                resultsDir: "e2eCheck_${env.APP_NAME}",
                serverUrl: "front-end.staging", 
                serverPort: 8080,
                checkPath: '/health',
                vuCount: 10,
                loopCount: 5,
                LTN: "e2eCheck_${BUILD_NUMBER}",
                funcValidation: false,
                avgRtValidation: 4000
              )
              if (status != 0) {
                currentBuild.result = 'FAILED'
                error "Production ready e2e check in staging failed."
              }
            }
          }
        }
        perfSigDynatraceReports(
          envId: 'Dynatrace Tenant', 
          nonFunctionalFailure: 1, 
          specFile: "monspec/e2e_perfsig.json"
        )
      }
    }
    ```

## Step 2: Review Performance Signature

1. Examine the file `monspec\e2e_perfsig.json` outlined below.

    ```bash
    {
    	"spec_version": "2.0",
    	"timeseries": [
            {
                "timeseriesId" : "com.dynatrace.builtin:service.responsetime",
                "aggregation" : "avg",
                "tags" : "app:carts,environment:staging",
                "upperSevere": 800.0,
                "upperWarning" : 600.0
            },
            {
                "timeseriesId" : "com.dynatrace.builtin:service.failurerate",
                "aggregation" : "avg",
                "tags" : "app:carts,environment:staging",
                "upperSevere": 5.0,
                "upperWarning" : 0.5
            },
            {
                "timeseriesId" : "com.dynatrace.builtin:service.responsetime",
                "aggregation" : "avg",
                "tags" : "app:front-end,environment:staging",
                "upperSevere": 800.0,
                "upperWarning" : 600.0
            }
        ]
    }
    ```

1. Note the additional timeseries for the `front-end` service. The `staging` environment will be the target for our testing.

## Step 3: Add a timeseries metric for Service Method addToCart

In some cases it is not sufficient to look at the Service level for performance degradations. This is certainly so in large tests that hit many endpoints of a service. This could lead to the results being skewed as very fast responses on one service method could average out the (perhaps fewer in number) slow requests on the degraded service methods.

To remediate this, we will add another timeseries metric to our Performance Signature.

1. Open the file `monspec\e2e_perfsig.json`.
1. Add another metric evaluation at the end of the file as shown below (make sure to add commas where needed)

    ```bash
    {
        "timeseriesId" : "com.dynatrace.builtin:servicemethod.responsetime",
        "aggregation" : "avg",
        "entityIds" : "",
        "upperSevere" : 800.0,
        "upperWarning" : 600.0
    }
    ```

1. For the `entityIds` key, add the Entity Id of the Add To Cart Service Method. The easiest way to retrieve it is by navigating to the `ItemsController` service in `staging` inside Dynatrace.
  ![](../assets/itemscontroller-staging.png)
1. Click on `View requests`
1. Scroll down to the bottom of the page to `Top Contributors` and click on `addToCart` 
  ![](../assets/itemscontroller-contributors.png)
1. If `addToCart` does not appear as a top contributing request, run the following command:

    ```bash
      (bastion)$ cd
      (bastion)$ timeout 3s ./add-to-cart.sh http://$http://$(kubectl -n staging get svc carts -o json | jq -r .status.loadBalancer.ingress[].ip)/carts/1/items
    ```

1. Make `addToCart` a `Key Request`. This is required to retrieve method-level metrics from the API.
  ![](../assets/itemscontroller-addtocart-keyrequest.png)
1. In the address bar of your browser window you can find the Entity Id of the `addToCart` Service Method
  ![](../assets/itemscontroller-addtocart-servicemethod.png)
1. Copy this value into the performance signature file
1. The file should look like this

    ```bash
    {
      "spec_version": "2.0",
      "timeseries": [
        {
            "timeseriesId" : "com.dynatrace.builtin:service.responsetime",
            "aggregation" : "avg",
            "tags" : "app:carts,environment:staging",
            "upperSevere": 800.0,
            "upperWarning" : 600.0
        },
        {
            "timeseriesId" : "com.dynatrace.builtin:service.failurerate",
            "aggregation" : "avg",
            "tags" : "app:carts,environment:staging",
            "upperSevere" : 5.0,
            "upperWarning" : 0.5
        },
        {
            "timeseriesId" : "com.dynatrace.builtin:service.responsetime",
            "aggregation" : "avg",
            "tags" : "app:front-end,environment:staging",
            "upperSevere" : 800.0,
            "upperWarning" : 600.0
        },
        {
            "timeseriesId" : "com.dynatrace.builtin:servicemethod.responsetime",
            "aggregation" : "avg",
            "entityIds" : "SERVICE_METHOD-xxxxxxxxxxxxxxxx",
            "upperSevere" : 800.0,
            "upperWarning" : 600.0
        }
      ]
    }
    ```

1. Commit/Push the changes to your GitHub repository *k8s-deploy-staging*.

---

:arrow_forward: [Next Step: Simulate Early Pipeline Break](../02_Simulate_Early_Pipeline_Break)
