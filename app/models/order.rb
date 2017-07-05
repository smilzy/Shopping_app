class Order < ApplicationRecord
  enum pay_type: {
    "Przelew"         => 0,
    "Karta kredytowa" => 1,
    "Pobranie"        => 2
  }
end
