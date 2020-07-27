# Define Performance Signature for Carts Service

In this lab you'll learn how to define the performance signature for the carts service. In more details, this lab focuses on validating the performance of the service based on the:
* Average response time
* Percentile of response time
* Number of requests and requests/minute
* Server-side failure rate 

For further performance metrics, [please see this page in the Dynatrace documentation.](https://www.dynatrace.com/support/help/shortlink/api-metrics).

## Step 1: View a timeseries for Response Time
1. Switch to the `carts/` directory and open the file `carts/monspec/carts_perfsig.json`.
1. In this file you will find the JSON array: **"timeseries"**
1. Review the following query to retrieve timeseries data for the **average response time** of the carts service. 
    ```
    {
        "timeseriesId": "com.dynatrace.builtin:service.responsetime",
        "aggregation": "avg",
        "tags" : "app:carts,environment:dev"
	},
    ```
1. Upper limit and lower limits set:
    ```
        ...
        "tags" : "app:carts,environment:dev",
        "upperWarning": 800,
        "upperSevere": 1200
    },
    ```
<!-- 
1. Add the following query to retrieve timeseries data for the **percentile of response time** of the carts service. 
    ```
    {
        "timeseriesId"  : "com.dynatrace.builtin:service.responsetime",
        "aggregation"   : "percentile",
        "tags"          : "app:carts,environment:dev"
    },
    ```
1. Specify the upper limit.
    ```
        ...
        "tags"         : "app:carts,environment:dev",
        "upperLimit"   : 800.0,
        "lowerLimit"   : 600.0
    },
    ```
1. After these steps, the **timeseries** array should look as follows: 
    ```
    "timeseries" : [
        {
            "timeseriesId"  : "com.dynatrace.builtin:service.responsetime",
            "aggregation"   : "avg",
            "tags"          : "app:carts,environment:dev",
            "upperLimit"    : 800.0,
            "lowerLimit"    : 600.0
        },
        {
            "timeseriesId"  : "com.dynatrace.builtin:service.responsetime",
            "aggregation"   : "percentile",
            "tags"          : "app:carts,environment:dev",
            "upperLimit"    : 3000.0,
            "lowerLimit"    : 2800.0
        },
    ]
    ```
<!-- 
## Step 2: Add a timeseries for Requests
1. Add the following query to retrieve timeseries data for the **number of requests** of the carts service. 
    ```
    {
        "timeseriesId" : "com.dynatrace.builtin:service.requests",
        "aggregation"  : "count",
        "tags"         : "app:carts,environment:dev",
    },
    ```
1. Specify the lower limit (number of requests).
    ```
        ...
        "tags"          : "app:carts,environment:dev",
        "lowerLimit"    : 1
    },
    ```

## Step 3: Add a timeseries for Requests per Minute
1. Add the following query to retrieve timeseries data for the **requests per minute** of the carts service. 
    ```
    {
        "timeseriesId"  : "com.dynatrace.builtin:service.requestspermin",
        "aggregation"   : "count",
        "tags"          : "app:carts,environment:dev"
    }
    ```
1. Specify the lower limit.
    ```
        ...
        "tags"          : "app:carts,environment:dev",
        "lowerLimit"    : 1
    },
    ```
-->
## Step 2: View a timeseries for Failure Rate
1. Review the following query to retrieve timeseries data for the **failure rate** of the carts service. 
    ```
    {
        "timeseriesId" : "com.dynatrace.builtin:service.failurerate",
        "aggregation" : "avg",
        "tags" : "app:carts,environment:dev",
    }
    ```
1. Upper and lower limits set:
    ```
        ...
        "tags" : "app:carts,environment:dev",
        "upperSevere" : 5.0,
        "upperWarning" : 0.5
    },
    ```
<!--
## Step 3: Save changes and push to repository
1. Save the file. 
1. Commit/Push the changes to your GitHub Repository *carts*.
-->
## Performance Signature for Carts should look like this:
```
{
	"spec_version": "2.0",
	"timeseries": [
		{
			"timeseriesId": "com.dynatrace.builtin:service.responsetime",
			"aggregation": "avg",
			"tags" : "app:carts,environment:dev",
			"upperWarning": 800,
			"upperSevere": 1200
		},
		{
			"timeseriesId" : "com.dynatrace.builtin:service.failurerate",
			"aggregation" : "avg",
			"tags" : "app:carts,environment:dev",
			"upperSevere" : 5.0,
			"upperWarning" : 0.0
        }
    ]
}

```

---

[Previous Step: Define Request Attributes](../02_Define_Request_Attributes) :arrow_backward: :arrow_forward: [Next Step: Define Performance Pipeline](../04_Define_Performance_Pipeline)

:arrow_up_small: [Back to overview](../)
