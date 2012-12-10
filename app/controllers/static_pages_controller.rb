class StaticPagesController < ApplicationController
  def home
  	# @var = "testvar"
  	# @micropost = current_user.microposts.build if signed_in?

  	if signed_in?
  		@micropost = current_user.microposts.build
  		# @feed_items = current_user.feed.paginate(page:params[:page])
      @feed_items = current_user.feed.page(params[:page])
  	end
  end

  def help
  end

  def about
  end

  def contact
  end
end
