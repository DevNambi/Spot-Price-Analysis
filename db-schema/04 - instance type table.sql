use SpotAnalysis
go

-- drop table dbo.InstanceType

create table dbo.InstanceType
(InstanceName varchar(256)
,MemoryInGB decimal(6,3)
,ComputeUnits decimal(5,2)
,ComputeUnitDesc varchar(256)
,HddInGB int
,SsdInGb int
,StorageDesc varchar(256)
,ArchitectureDesc varchar(256)
,NetworkPerfDesc varchar(256)
,MaxIPs smallint
,InstanceCode varchar(20)
,constraint InstanceTypePK primary key clustered (InstanceCode)
)
go