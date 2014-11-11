use SpotAnalysis
go

delete from dbo.Dates;

with hours as
(
select distinct dateadd(hh
					,datepart(hh,PriceDate)
					,convert(datetime,convert(varchar,PriceDate,101))
					) as StartTime
from [dbo].[SpotPriceInfo]
)

insert into dbo.Dates 
(StartTime
,EndTime
,IsWeekday
,IsBusinessHours)
select
	StartTime
	,EndTime = dateadd(hh,1,StartTime)
	,IsWeekday = CASE WHEN DATEPART (dw,StartTime) BETWEEN 2 and 6 THEN 1 ELSE 0 END --Monday through Friday
	,IsBusinessHours = CASE WHEN DATEPART (dw,StartTime) BETWEEN 2 and 6
							AND DATEPART(hh,StartTime) between 8 and 18 THEN 1
							ELSE 0 END -- define business hours as M-F 8am through 6pm
from hours
