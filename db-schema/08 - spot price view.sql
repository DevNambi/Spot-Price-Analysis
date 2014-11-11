use SpotAnalysis
go

select top 100 
	h.Region
	,h.AZ
	--,h.PriceDate
	,PriceDate = dateadd(hh,r.TimeZoneOffset,h.PriceDate) 
	,h.InstanceCode
	,h.Price
	,i.*
from dbo.SpotPriceHistory h
inner join dbo.Region r
on r.Region = h.Region
inner join dbo.InstanceType i
on i.InstanceCode = h.InstanceCode