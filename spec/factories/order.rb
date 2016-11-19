FactoryGirl.define do
  factory :order do
    client_name     "John"
    phone           "+37212345678"
    pickup_address  "Raekoja Plats 1, Tartu"
    dropoff_address "Liivi 2, Tartu"
  end
end
