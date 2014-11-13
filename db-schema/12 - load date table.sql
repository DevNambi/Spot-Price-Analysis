use SpotAnalysis
go

delete from dbo.Dates;

-- first, a number generator
with
	L0 as (select 0 as c union all select 1),
	L1 as (select 0 as c from L0 cross join L0 as b),
	L2 as (select 0 as c from L1 cross join L1 as b),
	L3 as (select 0 as c from L2 cross join L2 as b),
	L4 as (select 0 as c from L3 cross join L3 as b),
	L5 as (select 0 as c from L4 cross join L4 as b),
	nums as (select row_number() OVER (ORDER BY (select null)) as n from L5)
-- second, the hours to load
,hours as
(
	select dateadd(hh,h.HourNumber,d.StartDate) as StartTime
	from
	(
		select
			StartDate = dateadd(dd,n.n - 1, m.MinDate)
		from nums n
		inner join
		(
			select MaxDate = convert(datetime,convert(varchar,max(PriceDate),101))
				,MinDate = convert(datetime,convert(varchar,min(PriceDate),101))
				,DaysToLoad = datediff(dd,min(PriceDate),max(PriceDate))
			from dbo.SpotPriceInfo i
		) as m
		on n.n <= m.DaysToLoad + 1
		and n.n <= 200
	) as d
	cross join
	(
		select distinct HourNumber = datepart(hh,PriceDate)
		from dbo.SpotPriceInfo
	) as h

)

insert into dbo.Dates 
(StartTime
,EndTime
,DayName
,HourNumber
,IsWeekday
,IsBusinessHours)
select
	StartTime
	,EndTime = dateadd(ms,-3.33,dateadd(hh,1,StartTime))
	,DayName = CASE WHEN DATEPART(dw,StartTime) = 1 THEN 'Sunday'
					WHEN DATEPART(dw,StartTime) = 2 THEN 'Monday'
					WHEN DATEPART(dw,StartTime) = 3 THEN 'Tuesday'
					WHEN DATEPART(dw,StartTime) = 4 THEN 'Wednesday'
					WHEN DATEPART(dw,StartTime) = 5 THEN 'Thursday'
					WHEN DATEPART(dw,StartTime) = 6 THEN 'Friday'
					WHEN DATEPART(dw,StartTime) = 7 THEN 'Saturday'
					ELSE '' END
	,HourNumber = datepart(hh,StartTime)
	,IsWeekday = CASE WHEN DATEPART (dw,StartTime) BETWEEN 2 and 6 THEN 1 ELSE 0 END --Monday through Friday
	,IsBusinessHours = CASE WHEN DATEPART (dw,StartTime) BETWEEN 2 and 6
							AND DATEPART(hh,StartTime) between 8 and 18 THEN 1
							ELSE 0 END -- define business hours as M-F 8am through 6pm
from hours
