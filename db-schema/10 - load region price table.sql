use SpotAnalysis
go

delete from dbo.RegionPrice
go

bulk insert dbo.RegionPrice
FROM N'D:\Work\Github\Spot-Price-Analysis\raw-data\EC2 Price Instance Info.csv'
WITH
(
DATAFILETYPE='char'
--,ROWTERMINATOR=''
,FIELDTERMINATOR=','
,TABLOCK
,FIRSTROW=2
)
go