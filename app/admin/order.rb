ActiveAdmin.register Order do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :name, :address, :postal_code, :city, :price
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  index do
    column :id
    column :created_at
    column :name
    column :address
    column :city
    column :postal_code
    column :phone_number
    column :pay_type
    column :delivery
    column :user
    column :price, sortable: :price do |order|
      number_to_currency order.price, locale: :pl
    end
    actions
  end
end
