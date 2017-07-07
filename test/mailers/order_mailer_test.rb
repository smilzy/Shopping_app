require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  # test "received" do
  #   mail = OrderMailer.received(orders(:one))
  #   assert_equal "Potwierdzenie zamówienia w Sklepie GSM", mail.subject
  #   assert_equal ["johnny@example.com"], mail.to
  #   assert_equal ["shop@gsm.com"], mail.from
  #   assert_match "Xiaomi", mail.body.encoded
  # end

  # test "shipped" do
  #   mail = OrderMailer.shipped(orders(:one))
  #   assert_equal "Informacje o przesyłce | Sklep GSM", mail.subject
  #   assert_equal ["johnny@example.com"], mail.to
  #   assert_equal ["shop@gsm.com"], mail.from
  #   assert_match "<td>Xiaomi</td>", mail.body.encoded
  # end

end
