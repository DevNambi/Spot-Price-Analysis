use SpotAnalysis
go

-- drop table dbo.SpotPriceHistory

create table dbo.SpotPriceHistory
(Region varchar(32) not null
,AZ varchar(32) not null
,PriceDate datetime not null
,InstanceCode varchar(32) not null
,Price money not null
)
go