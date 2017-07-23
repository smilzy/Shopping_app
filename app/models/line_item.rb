class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product, optional: true
  belongs_to :cart
  before_create :on_warehouse
  before_update :on_warehouse
  
  def total_price
    product.price * quantity
  end
  
  # private
  
  def on_warehouse
    unless product.quantity - quantity >= 0
      errors.add(:base, 'Brak produktu na magazynie.')
      # return false
      throw :abort
    end
  end
  
end
