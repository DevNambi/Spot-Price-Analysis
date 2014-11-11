use SpotAnalysis
go

-- drop view dbo.SpotPriceHour

create view dbo.SpotPriceHour as 
select 
	Region
	,AZ
	,InstanceCode
	,InstanceCategory
	,ComputeUnits
	,MemoryInGB
	,HddInGB
	,SsdInGB
	,StorageType = CASE WHEN SsdInGb > 0 then 'SSD' 
						WHEN HddInGb > 0 then 'HDD'
						ELSE 'None' END
	,StorageInGB
	,PriceHour = i.PriceHour
	,IsWeekday
	,IsBusinessHours
	,Price = max(Price)
	,OnDemandPrice = max(OnDemandPrice)
	,PriceDiscountPercent = 1.0 - (max(Price) / max(OnDemandPrice))
	,PricePerGbMemory = max(Price) / MemoryInGB
	,PricePerComputeUnit = max(Price) / ComputeUnits
	,PricePerTbStorage = case when StorageInGB = 0 
								then NULL 
								else max(Price) * 1.0 / (StorageInGB / 1000.0) end
	,PricePerGbSSD = CASE WHEN SsdInGb = 0
							then NULL
							else max(Price) * 1.0 / SsdInGb end
from SpotPriceInfo i
inner join dbo.Dates d
on d.StartTime = i.PriceHour
group by Region
	,AZ
	,InstanceCode
	,InstanceCategory
	,ComputeUnits
	,MemoryInGB
	,HddInGB
	,SsdInGB
	,StorageInGB
	,CASE WHEN SsdInGb > 0 then 'SSD' 
						WHEN HddInGb > 0 then 'HDD'
						ELSE 'None' END
	,IsWeekday
	,IsBusinessHours
	,i.PriceHour