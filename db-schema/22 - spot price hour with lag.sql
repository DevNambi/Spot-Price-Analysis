use SpotAnalysis
go

-- drop view dbo.SpotPriceHourLag

create view dbo.SpotPriceHourLag as 
select
	[Region]
	,[AZ]
	,[InstanceCode]
	,[InstanceCategory]
	,[ComputeUnits]
	,[MemoryInGB]
	,[HddInGB]
	,[SsdInGB]
	,[StorageType]
	,[StorageInGB]
	,[PriceHour]
	,[IsWeekday]
	,[IsBusinessHours]
	,[Price]
	,[OnDemandPrice]
	,[PriceDiscountPercent]
	,[PricePerGbMemory]
	,[PricePerComputeUnit]
	,[PricePerTbStorage]
	,[PricePerGbSSD]
	,PriceInThreeHours = LEAD(Price,3) OVER (PARTITION BY AZ, InstanceCode ORDER BY PriceHour)
	,PriceInSixHours = LEAD(Price,6) OVER (PARTITION BY AZ, InstanceCode ORDER BY PriceHour)
	,PriceInTwelveHours = LEAD(Price,12) OVER (PARTITION BY AZ, InstanceCode ORDER BY PriceHour)
	,PriceInTwentyFourHours = LEAD(Price,24) OVER (PARTITION BY AZ, InstanceCode ORDER BY PriceHour)
	,PriceInFourtyEightHours = LEAD(Price,48) OVER (PARTITION BY AZ, InstanceCode ORDER BY PriceHour)
	/*,PriceInThreeHours = (
		SELECT top 1 h2.Price
		FROM dbo.SpotPriceHour h2
		WHERE h2.AZ = h.AZ
		 AND h2.InstanceCode = h.InstanceCode
		 AND h2.PriceHour > h.PriceHour
		 AND h2.PriceHour < dateadd(hh,3,h.PriceHour)
		 ORDER BY h2.Price desc
		)
	,PriceInSixHours = (
		SELECT top 1 h2.Price
		FROM dbo.SpotPriceHour h2
		WHERE h2.AZ = h.AZ
		 AND h2.InstanceCode = h.InstanceCode
		 AND h2.PriceHour > h.PriceHour
		 AND h2.PriceHour < dateadd(hh,6,h.PriceHour)
		 ORDER BY h2.Price desc
		)
	,PriceInTwelveHours = (
		SELECT top 1 h2.Price
		FROM dbo.SpotPriceHour h2
		WHERE h2.AZ = h.AZ
		 AND h2.InstanceCode = h.InstanceCode
		 AND h2.PriceHour > h.PriceHour
		 AND h2.PriceHour < dateadd(hh,12,h.PriceHour)
		 ORDER BY h2.Price desc
		)
	,PriceInTwentyFourHours = (
		SELECT top 1 h2.Price
		FROM dbo.SpotPriceHour h2
		WHERE h2.AZ = h.AZ
		 AND h2.InstanceCode = h.InstanceCode
		 AND h2.PriceHour > h.PriceHour
		 AND h2.PriceHour < dateadd(hh,24,h.PriceHour)
		 ORDER BY h2.Price desc
		)
    ,PriceInFourtyEightHours = (
		SELECT top 1 h2.Price
		FROM dbo.SpotPriceHour h2
		WHERE h2.AZ = h.AZ
		 AND h2.InstanceCode = h.InstanceCode
		 AND h2.PriceHour > h.PriceHour
		 AND h2.PriceHour < dateadd(hh,48,h.PriceHour)
		 ORDER BY h2.Price desc
		)*/
from dbo.SpotPriceHour h
go


select top 100 *
from dbo.SpotPriceHourLag
where AZ = 'us-west-2b'
and InstanceCode = 'm3.medium'
order by PriceHour