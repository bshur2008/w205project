
-- DROP TABLE IF EXISTS prd.combined_words;
CREATE TABLE prd.combined_words
(
	language string
	, source string
	, words array<string>
)
STORED AS ORC
;

