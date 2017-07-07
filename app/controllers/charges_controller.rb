class ChargesController < ApplicationController
  skip_before_action :authorize
  include CurrentCart
  before_action :set_cart, only: [:create, :new]
  
  def new
    if @cart.line_items.empty?
      redirect_to store_index_url
    end
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
      :currency    => 'pln'
    )
    
    if charge["paid"] == true
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      OrderMailer.received(@order).deliver_later
    end
  
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end
end
