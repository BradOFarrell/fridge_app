# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Fridge.destroy_all

samsung = Fridge.create(location: "kitchen", brand: "samsung", size: 700, has_food: true, has_drink: true)
frigidaire = Fridge.create(location: "garage", brand: "frigidaire", size: 700, has_food: true, has_drink: true)
kenmore = Fridge.create(location: "garage", brand: "kenmore", size: 700, has_food: true, has_drink: true)

Food.create(fridge_id: samsung.id, name: "cucumber", weight: 10, vegan: true, added_to_fridge: Date.today)
Food.create(fridge_id: frigidaire.id, name: "arugala", weight: 10, vegan: true, added_to_fridge: Date.today)
Food.create(fridge_id: kenmore.id, name: "pizza", weight: 7, vegan: false, added_to_fridge: Date.today)
Food.create(fridge_id: frigidaire.id, name: "taco", weight: 90, vegan: false, added_to_fridge: Date.today)


Drink.create(fridge_id: samsung.id, name: "beer", alcoholic: true, size: 16, )
Drink.create(fridge_id: kenmore.id, name: "wine", alcoholic: true, size: 750)
Drink.create(fridge_id: kenmore.id, name: "orange juice", alcoholic: false, size: 16)
Drink.create(fridge_id: frigidaire.id, name: "cold brew coffee", alcoholic: false, size: 50)