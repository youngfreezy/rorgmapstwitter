class SearchController < ApplicationController
	# include the helper that contains the initialization method
	# you could also add this here as a method but since the controller should not
	# have too much responsibility, it's better to offload it to a helper
	include SearchHelper

	def do_search
		# params["term"] is same as req.query.term
		if !params["term"]
			# render :json => is same as res.json()
			render :json => {:error => "Must specify a search term"}
		else
			begin
				twitter_client = init_twitter_client
				results = twitter_client.search(params["term"], {:geocode => "23.846695,90.403005,1000km"})
				# puts results.inspect
				# results is an object here and to_h turns it into a hash that can be rendered into json
				render :json => results.to_h
			rescue Twitter::Error::TooManyRequests => err
				sleep err.rate_limit.reset_in + 1
				retry
			rescue Exception => err
				# if theres an issue it will be sent to us as an exception
				# in that case we send the error msg back to the browser.
				# puts err.inspect
				render :json => {:error => err.message}
			end
		end
	end

	def map
		# this wil ltake the views/search/map.html.erb view and render that
		render 'map'
	end
end
