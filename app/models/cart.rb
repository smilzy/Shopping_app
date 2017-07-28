class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :delivery, optional: true
  
  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product.id)
    end
    current_item
  end
  
  def decrement_line_item_quantity(line_item_id)
    current_item = line_items.find(line_item_id)

    if current_item.quantity > 1
      current_item.quantity -= 1
    else
      current_item.destroy
    end

    current_item
  end
    
  # Sums up prices in cart
  def total_price
    line_items.to_a.sum { |item| item.total_price } 
  end
  
  def checkout_price
    total_price + delivery.price
  end
end
