class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :delivery, optional: true
  belongs_to :user, optional: true
  enum pay_type: {
    "Przelew"         => 0,
    "Karta kredytowa" => 1,
    "Pobranie"        => 2
  }
  
  validates :name, :address, :email, :postal_code, :city, :phone_number, presence: true
  validates :pay_type, inclusion: pay_types.keys
  
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil # Commented out for ChargesController CC payment.
      line_items << item
    end
  end
  
  def total_price
    line_items.to_a.sum { |item| item.total_price } + delivery.price
  end
  
end
