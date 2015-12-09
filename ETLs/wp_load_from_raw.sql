FROM (
FROM raw.es_wikipedia
SELECT TRANSFORM(es_wikipedia.title, es_wikipedia.revision)
USING '/project/ETLs/wp_raw_mapper.py'
AS (
title string
, text string
)
) raw_wp
INSERT OVERWRITE TABLE prd.wikipedia
SELECT 
 'es' 
 , title
 , split(lower(text),' ')
;
