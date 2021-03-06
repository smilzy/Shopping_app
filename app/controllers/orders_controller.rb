class OrdersController < ApplicationController
  skip_before_action :authorize, only: [:new, :create, :history, :show]
  include CurrentCart
  include ApplicationHelper
  before_action :set_cart, only: [:new, :create, :history]
  before_action :ensure_cart_isnt_empty, only: :new
  before_action :ensure_products_on_warehouse, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :ensure_order_belongs_to_current_user, only: :show

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all.order("created_at DESC")
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @delivery = Delivery.find(@cart.delivery_id)
    @order = Order.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @cart.line_items.each do |i|
      qty = i.quantity
      product = Product.find(i.product_id)
      product.quantity_update(product, qty)
    end
    @order.add_line_items_from_cart(@cart)
    if user_signed_in?
      @order.user_id = current_user.id
    end
    
    respond_to do |format|
      
      # Dynamically update Products quantity (same as in ProdController)
      # dynamically_update_products
                    
      if @order.save && @order.pay_type == "Karta kredytowa"
        format.html { redirect_to new_charge_url }
        format.json { render :show, status: :created, location: @order }
      elsif @order.save && @order.pay_type != "Karta kredytowa"
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        OrderMailer.received(@order).deliver_later
        format.html { redirect_to store_index_url,
                      notice: 'Zamówienie zostało złożone.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.line_items.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  rescue_from 'User::Error' do |exception|
    redirect_to users_url, notice: exception.message
  end
  
  def history
    @orders = current_user.orders.order("created_at DESC")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
      @delivery = Delivery.find(@order.delivery_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :phone_number, :pay_type, :postal_code, :city, :delivery_id, :price)
    end
    
    def ensure_cart_isnt_empty
      if @cart.line_items.empty?
        redirect_to store_index_url, notice: 'Twój koszyk jest pusty'
      end
    end
    
    
    def ensure_order_belongs_to_current_user
      unless @order.user == current_user || admin_user_signed_in?
        redirect_to store_index_url, notice: 'Błędny numer zamówienia'
      end
    end  
end
