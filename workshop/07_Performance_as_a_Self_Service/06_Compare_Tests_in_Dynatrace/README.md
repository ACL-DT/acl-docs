# Compare Builds in Dynatrace

In this lab you'll learn how to leverage Dynatrace to identify the difference between two performance tests. Literally, a couple of clicks can tell you the reason why one build was slower compared to another one. 

## Step 1: Open Dynatrace from Jenkins Pipeline
1. In the Performance Signature for a selected **failed build**, click on **open in Dynatrace**. (This opens the correct timeframe.)
1. Go to **Diagnostic tools** and click on **Top web requests**.
1. (optional) Filter on a Management Zone.

## Step 2: Narrow down the Requests based on Request Attributes
1. Click on **Add filter**.
1. Create filter for: `Request attribute` > `LTN`.
1. Click on **Apply**.

## Step 3. Open Comparison View
1. Select the timeframe of a *bad build*.
1. Click on **...** and select **Comparison** as shown below:
![compare_builds](../assets/compare_builds.png)

## Step 4. Compare Response Time Hotspots
1. Select the timeframe of the *good build* by selecting *compare with*: `custom time frame`
1. Click on **Compare response time hotspots**.
![compare_hotspots](../assets/compare_hotspots.png)
1. There you can see that the *Active wait time* increased.
![compare_overview](../assets/compare_overview.png)
1. Click on **View method hotspots** to identify the root cause.
![method_hotspot](../assets/method_hotspot.png)

---

[Previous Step: Run Performance Tests](../05_Run_Performance_Tests) :arrow_backward: :arrow_forward: [Next Step: Retry Performance Test](../07_Retry_Performance_Test)

:arrow_up_small: [Back to overview](../)