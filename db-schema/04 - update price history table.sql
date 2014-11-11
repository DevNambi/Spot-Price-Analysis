use SpotAnalysis
go

ALTER TABLE [dbo].[SpotPriceHistory]
ADD PriceHour datetime null
GO

UPDATE h
SET PriceHour = dateadd(hh
					,datepart(hh,  dateadd(hh,r.TimeZoneOffset,h.PriceDate)   )
					,convert(datetime,convert(varchar,   dateadd(hh,r.TimeZoneOffset,h.PriceDate)    ,101))
					)
--dateadd(hh,r.TimeZoneOffset,h.PriceDate) 
FROM dbo.SpotPriceHistory h
inner join dbo.Region r
on r.Region = h.Region
GO

ALTER TABLE [dbo].[SpotPriceHistory]
ALTER COLUMN PriceHour datetime not null
GO

create nonclustered columnstore index colstore
on dbo.SpotPriceHistory (Region, AZ, PriceDate, InstanceCode, Price, PriceHour)
go