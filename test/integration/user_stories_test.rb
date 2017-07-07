require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products
  include ActiveJob::TestHelper

  # A user goes to the index page. They select a product, adding it to their
  # cart, and check out, filling in their details on the checkout form. When
  # they submit, an order is created containing their information, along with a
  # single line item corresponding to the product they added to their cart.
  
  test "buying a product" do
    start_order_count = Order.count
    xiaomi_phone = products(:xiaomi)

    get "/"
    assert_response :success
    assert_select 'h1', "Katalog produktów"
    
    post '/line_items', params: { product_id: xiaomi_phone.id }, xhr: true
    assert_response :success 
    
    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal xiaomi_phone, cart.line_items[0].product
    
    get "/orders/new"
    assert_response :success
    assert_select 'legend', 'Wprowadź swoje dane'
    
    perform_enqueued_jobs do
      post "/orders", params: {
        order: {
          name:     "Johnny Five",
          address:  "123 Elm Street",
          email:    "johnny5@example.com",
          pay_type: "Przelew"
        }
      }

      follow_redirect!

      assert_response :success
      assert_select 'p', "Zamówienie zostało złożone."
      cart = Cart.find(session[:cart_id])
      assert_equal 0, cart.line_items.size
    
      assert_equal start_order_count + 1, Order.count
      order = Order.last
      
      assert_equal "Johnny Five",         order.name
      assert_equal "123 Elm Street",      order.address
      assert_equal "johnny5@example.com", order.email
      assert_equal "Przelew",             order.pay_type
      
      assert_equal 1, order.line_items.size
      line_item = order.line_items[0]
      assert_equal xiaomi_phone, line_item.product

      mail = ActionMailer::Base.deliveries.last
      assert_equal ["johnny5@example.com"], mail.to
      assert_equal 'GSM Shop <shop@gsm.com>', mail[:from].value
      assert_equal "Potwierdzenie zamówienia w Sklepie GSM", mail.subject
    end
  end
end
