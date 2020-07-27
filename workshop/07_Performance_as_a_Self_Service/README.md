# Performance as a Self-Service

Performance as a self-service aims on moving from manual sporadic execution and analysis of performance tests to a fully automated on-demand self-service model for developers. This provides early performance feedback and results in better performing software that gets deployed into production.

In this module you will learn how to write a load test with jMeter and how to integrate it into a Jenkins pipeline. The Jenkins pipeline will use a Performance Signature Validation Plugin to verify the load test result against pre-defined values characterizing the performance of the service. 

To achieve this goal, you will learn how to:
* Write a jMeter load test with proper header information for Dynatrace: [Lab](./01_Write_Load_Test_Script)
* Define request attributes in Dynatrace based on header data: [Lab](./02_Define_Request_Attributes)
* Define a performance signature for carts service: [Lab](./03_Define_Performance_Signature)
* Build a Jenkins pipeline that offers performance validation as a self-service: [Lab](./04_Define_Performance_Pipeline)
* Compare the result of load tests in Dynatrace: [Lab](./06_Compare_Tests_in_Dynatrace)


# Prerequisites

* Before starting with this module, please complete the following modules:
    * Building Environment zero
    * Developing Microservices
    * Monitoring as a Service

* Access to the *Bastion host*

