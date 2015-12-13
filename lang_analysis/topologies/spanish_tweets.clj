(ns spanish_tweets
  (:use     [streamparse.specs])
  (:gen-class))

(defn tweetwordcount [options]
   [
    ;; spout configuration
    {"tweet-spout" (python-spout-spec
          options
          "spouts.tweets.Tweets"
          ["tweet"]
	  :p 3
          )
    }
    ;; bolt configuration
    {"s3-bolt" (python-bolt-spec
          options
          {"tweet-spout" :shuffle}
          "bolts.parse.ParseTweet"
          ["word"]
          :p 2
          )
    ;; counter 
    "cnt-bolt" (python-bolt-spec
          options
          {"s3-bolt" ["word"]}
          "bolts.count.TweetCounter"
          ["word" "count"]
          :p 2
          )
    }
  ]
)
