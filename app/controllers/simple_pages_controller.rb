class SimplePagesController < ApplicationController

  def landing_page
    @featured_product = Product.first
    $redis.getset('hit_counter', 0) # finds or creates the hit counter
    @hit_counter = $redis.incr('hit_counter') # updates the hit counter by 1
  end

  def about
    @products = Product.limit(3)
  end

  def contact
  end

  def thank_you
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    UserMailer.contact_form(@email, @name, @message).deliver_now
  end

end
