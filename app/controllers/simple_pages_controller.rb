class SimplePagesController < ApplicationController


  def landing_page
    @featured_product = Product.first
    @hit_counter = get_hits
    @hit_counter = $redis.incr('hit_counter')
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

  private

  def get_hits
    hits = $redis.get('hit_counter')
    if !hits
      hits = $redis.getset('hit_counter', 0)
    end
    return hits
  end
end
