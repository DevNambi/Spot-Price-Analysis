use SpotAnalysis
go

-- add a PriceHour value to the fact table. This is a derived time, with just the date and hour, including offset.
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
