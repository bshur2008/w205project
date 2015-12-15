
INSERT OVERWRITE TABLE prd.combined_words
SELECT * FROM (
SELECT
language 
, 'tweets'
, words
, sentences
FROM prd.tweet_words
UNION ALL
SELECT
language
, 'wiki'
, words
, sentences
FROM prd.wikipedia
) z
;
