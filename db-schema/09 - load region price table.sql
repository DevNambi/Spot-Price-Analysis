use SpotAnalysis
go

delete from dbo.RegionPrice
go

bulk insert dbo.RegionPrice
FROM N'D:\Work\Github\Spot-Price-Analysis\raw-data\InstancePrice.csv'
WITH
(
DATAFILETYPE='char'
--,ROWTERMINATOR=''
,FIELDTERMINATOR=','
,TABLOCK
)
go