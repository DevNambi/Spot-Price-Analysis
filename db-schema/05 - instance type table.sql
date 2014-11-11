use SpotAnalysis
go

-- drop table dbo.InstanceType

create table dbo.InstanceType
(InstanceName varchar(256) not null
,MemoryInGB decimal(6,3) not null
,ComputeUnits decimal(5,2) not null
,ComputeUnitDesc varchar(256)
,HddInGB int not null
,SsdInGb int not null
,StorageDesc varchar(256)
,ArchitectureDesc varchar(256)
,NetworkPerfDesc varchar(256)
,MaxIPs smallint
,InstanceCode varchar(20) not null
,InstanceCategory varchar(32) not null
,constraint InstanceTypePK primary key clustered (InstanceCode)
)
go