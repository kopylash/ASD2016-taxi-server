# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

drivers = [
    {:name => 'Op op, Banuelos', :phone => '+37253915322', :car_model => 'Daewoo Lanos', :car_number => 'EST911', :status => 0},
    {:name => 'Vasia Advanced', :phone => '+37253915320', :car_model => 'Space X shuttle', :car_number => 'EST900', :status => 0},
    {:name => 'Marlon Dumas', :phone => '+37253915321', :car_model => 'Tesla', :car_number => 'EST800', :status => 0},
    {:name => 'Misha Dorokhov', :phone => '+37253915323', :car_model => 'Mitsubishi Lancer', :car_number => 'EST700', :status => 0},
    {:name => 'Fellix Ferdiges', :phone => '+37253915324', :car_model => 'Toyota Camry', :car_number => 'EST600', :status => 0}
]

drivers.each do |d|
  Driver.create!(d)
end