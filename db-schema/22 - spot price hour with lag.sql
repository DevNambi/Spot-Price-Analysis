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
	,PriceInThreeHours = (
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
		)
from dbo.SpotPriceHour h