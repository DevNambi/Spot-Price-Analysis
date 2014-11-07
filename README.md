Spot-Price-Analysis
===================

As you're undoubtedly aware, Amazon Web Services allows you to *bid* on EC2 instances. If your maximum bid is more than the current bid price, you keep your instance. If you don't, it gets taken away from you.

The advantage is that the bid prices are often far, far cheaper than the usual on-demand price.

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
* What are bad deals? Are GPU instances as bad as they claim?
* What are the gaps in the analysis
	* Not clear how many instances exist of each type, especially for the specialized ones.
