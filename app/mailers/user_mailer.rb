class UserMailer < ApplicationMailer
  default from: "from@example.com"

  def contact_form(email, name, message)
  @message = message
    mail(from: email,
         to: 'your-email@example.com',
         subject: "A new contact form message from #{name}")
  end

  def order_placed(user, product)
    @user = user
    @product = product
    mail(to: user.email,
      from: email,
      subject: "Thank you for your purchase!")
  end
end
