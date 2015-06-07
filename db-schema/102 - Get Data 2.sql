select
	Region
	,AZ
	,PriceDate
	,InstanceCode
	,InstanceCategory
	,Price
	,OnDemandPrice
	,ComputeUnits = convert(smallint, ComputeUnits)
	,MemoryInGB = convert(smallint, MemoryInGB)
	,HddInGB
	,SsdInGB
	,StorageInGB
from [dbo].[SpotPriceInfo]

