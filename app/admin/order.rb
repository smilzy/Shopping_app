ActiveAdmin.register Order do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
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
    column :total_price, sortable: :total_price do |price|
      number_to_currency price.total_price, locale: :pl
    end
    actions
  end
end
