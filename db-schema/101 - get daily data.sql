use SpotAnalysis
go

select
	Region
	,AZ
	,InstanceCode
	,InstanceCategory
	,ComputeUnits
	,MemoryInGB
	,HddInGb
	,SSDInGB
	,StorageInGB
	,Price = avg(Price)
	,OnDemandPrice = avg(OnDemandPrice)
from dbo.SpotPriceDay
group by Region
	,AZ
	,InstanceCode
	,InstanceCategory
	,ComputeUnits
	,MemoryInGB
	,HddInGb
	,SSDInGB
	,StorageInGB