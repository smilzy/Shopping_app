class AddDeliveryToCart < ActiveRecord::Migration[5.0]
  def change
    add_column :carts, :delivery_id, :integer, default: 1
  end
end
