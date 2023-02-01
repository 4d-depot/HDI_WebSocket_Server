//%attributes = {}

ARRAY TEXT:C222(_TabTitles; 0)
var Infos : Collection

Infos:=ds:C1482.INFO.all().orderBy("PageNumber").toCollection()
COLLECTION TO ARRAY:C1562(Infos.query("PageNumber<=3"); _TabTitles; "TabTitle")
