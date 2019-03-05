class PaymentsController < ApplicationController
  before_action :authenticate_user!



  def create
    @ordersObject = params[:order_ids]
    @user = current_user
    # lets loop this and get the total amount
    @totalPrice = 0
    @ordersObject.each do |order_id|
      order = Order.find(order_id)


      if order.user_id != @user.id
        redirect_to orders_path, alert: "Something went wrong with your order... Refresh the page and try again."
      end

      @totalPrice = @totalPrice + order.total
    end



    token = params[:stripeToken]


    begin
      charge = Stripe::Charge.create(
        amount: @totalPrice,
        currency: "eur",
        source: token,
        description: params[:stripeEmail]
      )

    if charge.paid



      @ordersObject.each do |order_id|

        tmpVar = Order.find(order_id)

        if tmpVar.user_id == @user.id
          tmpVar.paid = 1
          tmpVar.save

        else
          redirect_to orders_path, alert: "Your order has been paid but an error ocurred. Please contact the support"
        end

      end

      redirect_to orders_path, notice: "Thank you for the <span class='dollar'>€</span>#{@totalPrice}! Items will never arrive ahahaha."

    end

    # Something went wrong lets display what
    rescue Stripe::CardError => e

      body = e.json_body
      err = body[:error]

      redirect_to orders_path, alert: "Something went wrong with your payment request.<br><br>ERROR.: #{err[:message]}."
    end



  end
