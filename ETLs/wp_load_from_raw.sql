add jar /project/libs/hivexmlserde-1.0.5.3.jar;
add file /project/ETLs/wp_raw_mapper.py;

FROM (
FROM raw.es_wikipedia
SELECT TRANSFORM(
	es_wikipedia.title
	, regexp_replace(es_wikipedia.revision['text'],'[\n\r\t]',' ')
)
USING 'python wp_raw_mapper.py'
AS 
title string
, text string
) raw_wp
INSERT OVERWRITE TABLE prd.wikipedia
SELECT 
 'es' 
 , title
 , split(lower(text),' ')
;
