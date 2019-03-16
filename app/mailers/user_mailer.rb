class UserMailer < ApplicationMailer
  default from: "davidlucashopkins@gmail.com"

  def contact_form(email, name, message)
    @message = message
      mail(from: email,
           to: 'your-email@example.com',
           subject: "A new contact form message from #{name}")
  end

  def welcome(user)
    @appname = "Boston Boulders"
    mail(to: user.email,
        subject: "Welcome to #{@appname}!")
  end

  def order_placed(user, product)
    @user = user
    @product = product
    mail(to: user.email,
      from: email,
      subject: "Thank you for your purchase!")
  end
end
