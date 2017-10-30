require_relative '../config/environment'
require_relative '../app/models/fridge'

# $ ruby lib/fridge_tracker.rb

my_greeting = %q(
    Welcome to the fridge tracker
    What would you like to do? 
    1. Show all of your fridges 
    2. Add a fridge
    3. Delete a fridge
    4. View all food items in a specific fridge 
    5. Add a food item to a fridge
    6. Eat a food item from a fridge (delete it)
    7. View all drink items in a specific fridge
    8. Add a drink item to a fridge
    9. Consume PART of a drink from a fridge (update its size in ounces)
    10. Consume ALL of a drink from a fridge (delete it)  
)

puts my_greeting

def show_fridge(fridge)
    puts "Your #{fridge.brand} Fridge in the #{fridge.location}. (frisge-id:#{fridge.id})" 
    if(fridge.has_food || fridge.has_drink)
        puts "+ Contains:"        
        food = Food.where(fridge_id: fridge.id)
        food.each do |e|
            puts "- #{e.name} #{e.weight}oz (food-id:#{e.id})"
        end            
        drink = Drink.where(fridge_id: fridge.id)
        drink.each do |e|
            puts "- #{e.name} #{e.size}oz (drink-id:#{e.id})"
        end            
    end
end

def show_fridges()
    fridges = Fridge.all
    fridges.each do |fridge|
        show_fridge(fridge)
    end
end 

def add_a_fridge()
    puts "Enter fridge location:"
    fridgeLocation = gets.chomp.to_s
    puts "Enter fridge brand:"
    fridgeBrand = gets.chomp.to_s
    puts "Enter fridge size:"
    fridgeSize = gets.chomp.to_i
    puts "Does the fridge have food in it? (yes or no)"
    isFood = gets.chomp
    case isFood
        when 'y', 'Y', 'yes'
            isFood = true
        when 'n', 'N', 'no'
            isFood = false
    end
    puts "Does the fridge have drinks in it? (yes or no)"
    isDrinks = gets.chomp
    case isDrinks
        when 'y', 'Y', 'yes'
            isDrinks = true
        when 'n', 'N', 'no'
            isDrinks = false
    end
    Fridge.create(location:fridgeLocation, brand:fridgeBrand, size:fridgeSize, has_food:isFood, has_drink:isDrinks)
end

def view_a_fridge(fridgeid)
    fridge = Fridge.find(fridgeid)
    show_fridge(fridge)
end 

def delete_fridge(fridgeid)
    fridge = Fridge.find(fridgeid)
    fridge.destroy()
    puts "Your #{fridge.brand} Fridge in the #{fridge.location} has been deleted"    
end 

def add_food(fridgeid)
    puts "Enter food name:"
    foodName = gets.chomp.to_s
    puts "Enter weight:"
    foodWeight = gets.chomp.to_s
    Food.create(fridge_id:fridgeid, name: foodName, weight: foodWeight, vegan: false, added_to_fridge: Date.today)
end

def delete_food(foodid)
    food = Food.find(foodid)
    food.destroy()
    puts "You ate the #{food.name}! Yum."    
end 


def add_drink(fridgeid)
    puts "Enter drink name:"
    drinkName = gets.chomp.to_s
    puts "Enter volume:"
    size = gets.chomp.to_s
    Drink.create(fridge_id:fridgeid, name: drinkName, size: size, alcoholic: true)
end

def sip_drink(drinkid)
    drink = Drink.find(drinkid)
    oldsize = drink.size;
    drink.size = oldsize / 2
    puts "You drank half the #{drink.name}! (Was #{oldsize}oz, now #{drink.size}oz)"    
end 

def delete_drink(drinkid)
    drink = Drink.find(drinkid)
    drink.destroy()
    puts "You drank the #{drink.name}! Yum."    
end 


user_input = gets.chomp.to_i

if user_input == 1
    show_fridges()
end

if user_input == 2
    add_a_fridge()
end

if user_input == 3
    puts "Enter the id of the fridge you'd like to delete."
    user_input = gets.chomp.to_i    
    delete_fridge(user_input)
end

if user_input == 4
    puts "Enter the id of a fridge to see all its food."
    user_input = gets.chomp.to_i    
    view_a_fridge(user_input)    
end

if user_input == 5
    puts "Enter the id of the fridge you'd like to add food to."
    user_input = gets.chomp.to_i    
    add_food(user_input)
end

if user_input == 6
    puts "Enter the id of the food you'd like to eat."
    user_input = gets.chomp.to_i    
    delete_food(user_input)
end

if user_input == 7
    puts "Enter the id of a fridge to see all its drinks."
    user_input = gets.chomp.to_i    
    view_a_fridge(user_input)    
end

if user_input == 8
    puts "Enter the id of the fridge you'd like to add a drink to."
    user_input = gets.chomp.to_i    
    add_drink(user_input)
end

if user_input == 9
    puts "Enter the id of the drink you'd like to sip."
    user_input = gets.chomp.to_i    
    sip_drink(user_input)
end

if user_input == 10
    puts "Enter the id of the drink you'd like to chug."
    user_input = gets.chomp.to_i    
    delete_drink(user_input)
end