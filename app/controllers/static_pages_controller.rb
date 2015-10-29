class StaticPagesController < ApplicationController
	before_action :simulate_logged_in, :except => [:signup]

	def index
	end

	def about
	end

	def about_edit
	end

	def friends
	end

	def news_feed
	end

	def photos
	end

	def signup
		session[:logged_in] = false
	end

	def timeline
	end

	private
		def simulate_logged_in
			session[:logged_in] = true
		end
end
