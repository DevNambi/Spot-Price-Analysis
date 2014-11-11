use SpotAnalysis
go

-- drop table dbo.Region

create table dbo.Region
(Region varchar(32)
,TimeZoneOffset int
,constraint RegionPK primary key clustered (Region)
)
go