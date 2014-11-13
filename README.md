Spot-Price-Analysis
===================

Amazon Web Services allows you to *bid* for computing capacity (EC2 VMs). If your maximum bid is more than the current bid price, you keep your instance. If your maximum bid is *less* than the current bid price, then your VM is destroyed.

The advantage is that the bid prices are far cheaper than the usual on-demand price. 70-90% discounts are common.

Here's a quick example of bid vs. on-demand prices for some commonly-used AWS instance types in the us-east-1 (Northern Virginia) region:

* TO DO: Add table here

m3.medium - .23
c3.large - .12
r3.xlarge - 0.15
g2.2xlarge - .14


**Outline**

* Intro to AWS spot prices. Quick teaser on average discounts

Analyzing AWS spot instance pricing for fun and profit. 

If you're here, chances are you know about AWS spot instances. There's a few fun tricks I've found:

* Spot instances are *identical* to EC2 instances. The only difference is the way they are priced and billed.
* Not all AZs are the same price. This is a bit insane, considering that 



## Part 1: An overview

* Explain what spot instances are. Link to YouTube videos.
* Go over high-level discounts. Then discounts per region. Per AZ. Per time of day. Per biz hour / weekday.
* Mention that the field of research here is bidding, agent-based systems. 
* Quant finance is a resource to learn more
* Cost to run per day assuming an infinite bid.

## Part 2: Comparison with other cloud providers

* Azure
* GCE
* Figure out CPU per scaling factor for each

## Part 3: Predictions

* Show the results, not the algo
* Algos to look at: logistic regression, others. Depends on pricing strategy
* When do price spikes happen? Can they be predicted?
	* Do price spikes happen across AZs? Regions? Instance types?
	* 'Spike' defined as above some threshold, IQR, absolute value.
* For a given price, X, how many hours will it last for each instance type?
	* Split per AZ, per region
	* Split by biz hour, weekday

## Part 4: Strategy and Uses

* Public good. Science. 
* Offer to share
* 


### Questions to Explore

* how much does the price vary per instance? Inter-quartile range? 
* Are prices normally distributed? If not, why not?
* What's the cheapest instance to get for CPU-heavy work?
* What's the cheapest setup for RAM-heavy work?
* What's the cheapest setup for I/O heavy work?
* What are the deepest discounts to expect from spot instances?
* How much of a discount is this compared to GCE or Azure, since they don't have this feature?
* For a couple of prototypical workloads (use Netflix for an example), walk through the cost differential
* What factors matter when picking instances?
* What regions and AZs matter?
* Which are the cheapest regions?
	* How about AZs? How much does AZ choice matter?
* What days and times of day matter? What patterns exist?
* What are bad deals? Are GPU instances as bad as feared because of Bitcoin miners?
* What are the gaps in the analysis
	* Not clear how many instances exist of each type, especially for the specialized ones.




