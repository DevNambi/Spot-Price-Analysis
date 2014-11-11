use SpotAnalysis
go

delete from dbo.InstanceType
go

bulk insert dbo.InstanceType
from N'D:\Work\Github\Spot-Price-Analysis\raw-data\EC2 Instance Info.csv'
WITH
(
DATAFILETYPE='char'
--,ROWTERMINATOR=''
,FIELDTERMINATOR=','
,TABLOCK
,FIRSTROW=2
)
