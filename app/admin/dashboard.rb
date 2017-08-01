ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    # Here is an example of a simple dashboard with columns and panels.
    
    columns do
      column do
        panel "Recent Orders" do
          table_for Order.order("created_at desc").limit(10) do
            column :name do |order|
              link_to(order.name, admin_order_path(order))
            end
            column :created_at
            column :delivery
            column :price do |order|
              number_to_currency order.price, locale: :pl
            end
          end
        end
      end

      column do
        panel "Recent Customers" do
          table_for User.order("id desc").limit(10).each do |_user|
            column(:email)    { |user| link_to(user.email, admin_user_path(user)) }
            column "Orders" do
              |user| Order.where(user_id: user.id).each do |order|
                link_to(order.name, admin_order_path(order))
              end
            end
          end
        end
      end

    end
  end # content
end
