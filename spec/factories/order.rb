FactoryGirl.define do
  factory :order do
    client_name     "John"
    phone           "+37212345678"
    pickup_address  "Raekoja Plats 1, Tartu"
    pickup_lat      58.37973949999999
    pickup_lon      26.722121
    dropoff_address "Liivi 2, Tartu"
  end

  factory :invalid_order, :class => Order do
    client_name "John"
  end
end
