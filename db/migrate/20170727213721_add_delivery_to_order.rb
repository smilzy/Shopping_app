class AddDeliveryToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :delivery_id, :integer, default: 0
  end
end
