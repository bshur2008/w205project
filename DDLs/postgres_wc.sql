
--DROP TABLE IF EXISTS public.tweet_word_count ;
CREATE TABLE public.tweet_word_count
(
	language varchar(10)
	, day date
	, word varchar(100)
	, cnt integer
)
;

CREATE INDEX twc ON public.tweet_word_count (language, day, word);
