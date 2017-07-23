module CurrentCart
  
  private
  
  def set_cart
      @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      @cart = Cart.create
      session[:cart_id] = @cart.id
  end
  
  def ensure_products_on_warehouse
    @cart.line_items.each do |item|
      if item.product.quantity - item.quantity < 0
        redirect_to store_index_url, notice: 'Ilość zamawianego towaru wyższa niż obecnie dostępna w sprzedaży. Zaktualizowano koszyk.'
        item.quantity = item.product.quantity
        item.save
      end
    end
  end
  
end