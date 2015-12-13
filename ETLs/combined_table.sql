
INSERT OVERWRITE TABLE prd.combined_words
SELECT * FROM (
SELECT
language 
, 'tweets'
, words
FROM prd.tweet_words
UNION ALL
SELECT
language
, 'wiki'
, words
FROM prd.wikipedia
) z
;
