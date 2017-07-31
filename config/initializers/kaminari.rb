# config/initializers/kaminari.rb
# Added for compatibility with will_paginate 
Kaminari.configure do |config|
  config.page_method_name = :per_page_kaminari
end