
-- DROP TABLE IF EXISTS prd.combined_words;
CREATE TABLE IF NOT EXISTS prd.combined_words
(
	language string
	, source string
	, words array<string>
	, sentences array<array<string>>
)
STORED AS ORC
;

