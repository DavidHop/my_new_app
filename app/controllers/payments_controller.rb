class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @ordersObject = params[:order_ids]
    @user = current_user
    @ordersObject.each do |order_id|
      order = Order.find(order_id)

    @totalPrice = @totalPrice + order.total
  end

  token = params[:stripeToken]
  # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        amount: 2000, # amount in cents, again
        currency: "usd",
        source: token,
        description: params[:stripeEmail]
      )

      if charge.paid
        Order.create(
          product_id: @product.id,
          user_id: @user.id,
          total: @product.price
        )

      end

      rescue Stripe::CardError => e
        # The card has been declined
        body = e.json_body
        err = body[:error]
        flash[:error] = "Unfortunately, there was an error processing your payment: #{err[:message]}"
      end
        redirect_to product_path(@product)
    end
  end
