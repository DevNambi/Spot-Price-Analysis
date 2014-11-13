use SpotAnalysis
go

-- drop view dbo.SpotPriceDay

create view dbo.SpotPriceDay
as
select
	Region
	,AZ
	,InstanceCode
	,InstanceCategory
	,ComputeUnits
	,MemoryInGB
	,HddInGB
	,SsdInGB
	,StorageInGB
	,IsWeekday
	,CalendarDate = convert(date,PriceHour)
	,Price = sum(Price)
	,OnDemandPrice = sum(OnDemandPrice)
from dbo.SpotPriceHour
group by Region
	,AZ
	,InstanceCode
	,InstanceCategory
	,ComputeUnits
	,MemoryInGB
	,HddInGB
	,SsdInGB
	,StorageInGB
	,IsWeekday
	,convert(date,PriceHour)
go