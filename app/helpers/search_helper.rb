module SearchHelper
	def init_twitter_client
		client = Twitter::REST::Client.new do |config|
			config.consumer_key        = ENV["CONSUMER_KEY"]
			config.consumer_secret     = ENV["CONSUMER_SECRET"]
			config.access_token        = ENV["TOKEN"]
			config.access_token_secret = ENV["TOKEN_SECRET"]
		end

		return client
	end
end
