class ChargesController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create, :new]
  
  def new
    @price = @cart.total_price
  end

  def create
    # Amount in cents
    @amount = (@cart.total_price * 100).round
  
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )
  
    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )
    
  if charge["paid"] == true
    Cart.destroy(session[:cart_id])
    session[:cart_id] = nil
  end
  
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
