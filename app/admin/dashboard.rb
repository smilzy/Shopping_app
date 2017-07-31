ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    # Here is an example of a simple dashboard with columns and panels.
    
    columns do
      column do
        panel "Recent Orders" do
          table_for Order.order("created_at desc").limit(5) do
            column :name do |order|
              link_to(order.name, admin_order_path(order))
            end
            column :created_at
            column :delivery
            column :total_price, sortable: :total_price do |price|
              number_to_currency price.total_price, locale: :pl
            end
          end
        end
      end

      column do
        panel "Info" do
          para "Welcome to ActiveAdmin."
        end
      end
    end
  end # content
end
