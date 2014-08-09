class Countdown < ActiveRecord::Base
	def tweets
		client = Twitter::REST::Client.new do |config|
			config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
			config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
		end

		client.search("\##{hashtag}", :result_type => "recent").take(25).collect do |tweet|
			{:name => "#{tweet.user.screen_name}", :text => "#{tweet.text}"}
		end
	end
end
