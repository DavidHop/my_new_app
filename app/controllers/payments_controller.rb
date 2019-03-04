class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @ordersObject = params[:order_ids]
    @user = current_user
    # lets loop this and get the total ammount
    @totalPrice = 0
    @ordersObject.each do |order_id|
      order = Order.find(order_id)

      # pre hack validation xD
      if order.user_id != @user.id
        redirect_to orders_path, alert: "Something went wrong with your order... Refresh the page and try again."
      end

      @totalPrice = @totalPrice + order.total
    end

  token = params[:stripeToken]
  # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        amount: (@product.price * 100).to_i,
        currency: "usd",
        :source => token,
        :description => params[:stripeEmail],
        :receipt_email => params[:stripeEmail]
      )

      if charge.paid
        Order.create(
          product_id: @product.id,
          user_id: @user.id,
          total: @product.price
        )
        redirect_to orders_path, notice: "Thank you for the payment"
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
