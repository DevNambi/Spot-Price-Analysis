use SpotAnalysis
go

-- drop table dbo.Dates

create table dbo.Dates
(StartTime datetime not null
,EndTime datetime not null
,IsWeekday bit not null
,IsBusinessHours bit not null)
go