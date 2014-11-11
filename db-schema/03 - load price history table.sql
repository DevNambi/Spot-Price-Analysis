use SpotAnalysis
go

truncate table dbo.SpotPriceHistory
go

bulk insert dbo.SpotPriceHistory
FROM N'D:\Work\Github\Spot-Price-Analysis\raw-data\sa-east-1_history.csv'
WITH
(
DATAFILETYPE='char'
--,ROWTERMINATOR=''
,FIELDTERMINATOR=','
,TABLOCK
)
go

bulk insert dbo.SpotPriceHistory
FROM N'D:\Work\Github\Spot-Price-Analysis\raw-data\us-west-1_history.csv'
WITH
(
DATAFILETYPE='char'
--,ROWTERMINATOR=''
,FIELDTERMINATOR=','
,TABLOCK
)
go

bulk insert dbo.SpotPriceHistory
FROM N'D:\Work\Github\Spot-Price-Analysis\raw-data\ap-southeast-2_history.csv'
WITH
(
DATAFILETYPE='char'
--,ROWTERMINATOR=''
,FIELDTERMINATOR=','
,TABLOCK
)
go

bulk insert dbo.SpotPriceHistory
FROM N'D:\Work\Github\Spot-Price-Analysis\raw-data\ap-northeast-1_history.csv'
WITH
(
DATAFILETYPE='char'
--,ROWTERMINATOR=''
,FIELDTERMINATOR=','
,TABLOCK
)
go

bulk insert dbo.SpotPriceHistory
FROM N'D:\Work\Github\Spot-Price-Analysis\raw-data\eu-west-1_history.csv'
WITH
(
DATAFILETYPE='char'
--,ROWTERMINATOR=''
,FIELDTERMINATOR=','
,TABLOCK
)
go

bulk insert dbo.SpotPriceHistory
FROM N'D:\Work\Github\Spot-Price-Analysis\raw-data\us-west-2_history.csv'
WITH
(
DATAFILETYPE='char'
--,ROWTERMINATOR=''
,FIELDTERMINATOR=','
,TABLOCK
)
go

bulk insert dbo.SpotPriceHistory
FROM N'D:\Work\Github\Spot-Price-Analysis\raw-data\us-east-1_history.csv'
WITH
(
DATAFILETYPE='char'
--,ROWTERMINATOR=''
,FIELDTERMINATOR=','
,TABLOCK
)
go

bulk insert dbo.SpotPriceHistory
FROM N'D:\Work\Github\Spot-Price-Analysis\raw-data\ap-southeast-1_history.csv'
WITH
(
DATAFILETYPE='char'
--,ROWTERMINATOR=''
,FIELDTERMINATOR=','
,TABLOCK
)
go

begin tran

	if object_id('tempdb..#spot_dups') is not null
	begin
		exec ('drop table #spot_dups')
	end

	select Region, Az, PriceDate, InstanceCode, Price = max(Price), count(*) as dup_count
	into #spot_dups
	from dbo.SpotPriceHistory
	group by Region, Az, PriceDate, InstanceCode
	having count(*) > 1

	delete
	from dbo.SpotPriceHistory
	from dbo.SpotPriceHistory h
	inner join #spot_dups d
	on h.AZ = d.AZ
	and h.PriceDate = d.PriceDate
	and h.InstanceCode = d.InstanceCode


	INSERT INTO [dbo].[SpotPriceHistory]
	([Region]
	,[AZ]
	,[PriceDate]
	,[InstanceCode]
	,[Price])
	select Region, 
		Az, 
		PriceDate, 
		InstanceCode, 
		Price
	from #spot_dups

commit tran
go

ALTER TABLE dbo.SpotPriceHistory
ADD CONSTRAINT SpotPriceHistoryPK primary key clustered
(PriceDate
,AZ
,InstanceCode)
go

create nonclustered columnstore index colstore
on dbo.SpotPriceHistory (Region, AZ, PriceDate, InstanceCode, Price)
go