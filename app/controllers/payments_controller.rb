class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @ordersObject = params[:product_id]
    @user = current_user


    token = params[:stripeToken]
  # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        amount: 2000, # amount in cents, again
        currency: "usd",
        :source => token,
        :description => params[:stripeEmail],
        :receipt_email => params[:stripeEmail]
      )

      if charge.paid
        Order.create(
          product_id: product.id,
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
