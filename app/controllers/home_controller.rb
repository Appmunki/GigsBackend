class HomeController < ApplicationController
	def index
		render template: "index"
	end
end