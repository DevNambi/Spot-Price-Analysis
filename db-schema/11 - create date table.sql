use SpotAnalysis
go

-- drop table dbo.Dates

create table dbo.Dates
(StartTime datetime not null
,EndTime datetime not null
,DayName varchar(10) not null
,HourNumber tinyint not null
,IsWeekday bit not null
,IsBusinessHours bit not null
,constraint DatesPK primary key clustered (StartTime))
go