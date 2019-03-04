module PaymentsHelper
  def getPaymentValue(value)

    if value > 0
      value.to_f / 100.to_f
    else
    "0.00"
    end

  end
end
