class OrderMailer < ApplicationMailer
default from: 'GSM Shop <shop@gsm.com>'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.received.subject
  #
  def received(order)
    @order = order

    mail to: order.email, subject: 'Potwierdzenie zamówienia w Sklepie GSM'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.shipped.subject
  #
  def shipped
    @greeting = "Hi"

    mail to: order.email, subject: 'Informacje o przesyłce | Sklep GSM'
  end
end
