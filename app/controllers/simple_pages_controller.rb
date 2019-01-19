class SimplePagesController < ApplicationController

  def landing_page
      @featured_product = Product.first
  end

  def about
    @products = Product.limit(3)
  end

  def contact
  end
end
