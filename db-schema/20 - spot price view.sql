use SpotAnalysis
go

-- drop view dbo.SpotPriceInfo

create view dbo.SpotPriceInfo
as
select
	h.Region
	,h.AZ
	--,h.PriceDate
	,PriceDate = dateadd(hh,r.TimeZoneOffset,h.PriceDate)
	,PriceHour = h.PriceHour
	,h.InstanceCode
	,i.InstanceCategory
	,h.Price
	,OnDemandPrice = rp.OnDemandPrice
	,i.ComputeUnits
	,i.MemoryInGB
	,i.HddInGB
	,i.SsdInGB
	,StorageInGB = isnull(i.HddInGB,0) + isnull(i.SsdInGb,0)
from dbo.SpotPriceHistory h
inner join dbo.Region r
on r.Region = h.Region
inner join dbo.InstanceType i
on i.InstanceCode = h.InstanceCode
inner join dbo.RegionPrice rp
on rp.Region = h.Region
and rp.InstanceCode = h.InstanceCode