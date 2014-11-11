use SpotAnalysis
go

-- drop table dbo.RegionPrice

create table dbo.RegionPrice
(Region varchar(32) not null
,InstanceCode varchar(32) not null
,OnDemandPrice money not null
,constraint RegionPricePK primary key clustered (Region, InstanceCode)
)
go

/*

select distinct Region, InstanceCode
from dbo.SpotPriceHistory
order by Region, InstanceCode

*/