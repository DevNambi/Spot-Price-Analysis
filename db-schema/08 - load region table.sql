use SpotAnalysis
go

declare @regions xml
set @regions = '<regions>
<region code="sa-east-1"		offset="-3" />
<region code="eu-west-1"		offset="0" />
<region code="eu-central-1"		offset="1" />
<region code="ap-southeast-1"	offset="8" />
<region code="ap-southeast-2"	offset="10" />
<region code="ap-northeast-1"	offset="9" />
<region code="us-east-1"		offset="-5" />
<region code="us-west-1"		offset="-8" />
<region code="us-west-2"		offset="-8" />
</regions>'

delete from dbo.Region

insert into dbo.Region (Region, TimeZoneOffset)
select r.i.value('@code','varchar(32)') as region
		,r.i.value('@offset','int') as offset
from @regions.nodes ('/regions/region') r(i)