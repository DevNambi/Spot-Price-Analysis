use SpotAnalysis
go


-- drop index dbo.SpotPriceHistory.colstore
-- Now, add in values that are missing
-- for spot prices, we can infer that a future hour has the same price as a past hour.

if object_id('tempdb..#existing_ranges') is not null
begin 
	exec ('drop table #existing_ranges');
end
go

declare @MaxDate datetime
select @MaxDate = max(d.EndTime)
from dbo.Dates d;

with existing as 
(
	select TimeRanker = DENSE_RANK() OVER (PARTITION BY h.AZ, h.InstanceCode ORDER BY h.PriceHour asc, h.PriceDate desc)
		,StartTimeUTC = dateadd(hh, -1.0 * r.TimeZoneOffset, h.PriceHour)
		,h.*
	from dbo.SpotPriceHistory h
	inner join dbo.Region r
	on r.Region = h.Region
	where h.Region = 'us-west-2'
	--and InstanceCode in ('r3.2xlarge')
), exist_ranges as 
(
	select e.*
		, dateadd(ms,-3.33,e2.StartTimeUTC) as EndTimeUTC
	from existing e
	inner join existing e2
	on e.InstanceCode = e2.InstanceCode
	and e.AZ = e2.AZ
	and e.TimeRanker = e2.TimeRanker - 1 --e is earlier
)

select *
into #existing_ranges
from exist_ranges;


with all_ranges as 
(
	select 
		e.Region
		,e.AZ
		,d.StartTime
		,d.EndTime
		,e.InstanceCode
		,e.Price
		,PriceHour = dateadd(hh,r.TimeZoneOffset,d.StartTime) --price hour is in timezone offset
	from dbo.Dates d
	inner join #existing_ranges e
	on d.StartTime between e.StartTimeUTC and e.EndTimeUTC --join on UTC dates only
	inner join dbo.Region r
	on r.Region = e.Region
)


INSERT INTO [dbo].[SpotPriceHistory]
([Region]
,[AZ]
,[PriceDate]
,[InstanceCode]
,[Price]
,PriceHour)
select
a.Region
,a.AZ
,a.StartTime --this in UTC
,a.InstanceCode
,a.Price
,a.PriceHour --this is w/ a timezone offset
from all_ranges a
where 1=1
--and a.PriceHour =  '2014-08-14 05:00'
and not exists
(
	select *
	from dbo.SpotPriceHistory h
	where h.AZ = a.AZ
	and h.InstanceCode = a.InstanceCode
	and h.PriceDate between a.StartTime and a.EndTime
)

/*
select *
from dbo.SpotPriceHistory
where AZ = 'eu-west-1c'
	and InstanceCode in ('r3.2xlarge')
and PriceHour = '2014-08-08 05:00'
order by 


select * 
from all_ranges a
left outer join dbo.SpotPriceHistory h
on h.AZ = a.AZ
	and h.InstanceCode = a.InstanceCode
	and h.PriceDate between a.StartTime and a.EndTime
where a.PriceHour = '2014-08-08 05:00'
order by StartTime

select *
from dbo.SpotPriceHistory
where AZ = 'eu-west-1c'
	and InstanceCode in ('r3.2xlarge')
and PriceHour = '2014-08-08 05:00'
*/



/*
-- finally, create a columnstore index so it can be queried quickly
create nonclustered columnstore index colstore
on dbo.SpotPriceHistory (Region, AZ, PriceDate, InstanceCode, Price, PriceHour)
go

CREATE NONCLUSTERED INDEX lag_helper
ON [dbo].[SpotPriceHistory] ([AZ],[InstanceCode])
INCLUDE ([Region],[Price],[PriceHour])
*/