module Haulable
  
  def haul_a_load
    puts "I am hauling a load"
  end
  
end


class Vehicle
attr_accessor :color, :model, :speed
attr_reader :year
@@number_of_vehicles = 0


  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
    @@number_of_vehicles += 1
  end
  
  def speed_up(i)
    self.speed += i
    self.speed_of_vehicle
  end
  
  def slow_down(i)
    self.speed -= i
    if self.speed < 0
      self.speed = 0
    end
    self.speed_of_vehicle
  end
  
  def speed_of_vehicle
    puts "You are now going #{self.speed}"
  end
  
  def shut_the_car_off
    self.speed = 0
    puts "Your #{self.model} is now off and speed is 0"
  end
  
  def self.find_mileage(gallons, miles)
    puts "#{miles / gallons} per gallon"
  end

  def number_of_vehicles?
    puts @@number_of_vehicles
  end
  
  def to_s
    "My #{self.model} is a #{self.color}, #{self.year}, #{self.model}."
  end
  
  def spray_paint
    puts "Ugh, #{self.color} is ugly! Lets spray paint it!"
    puts "Rattle, rattle, rattle.  What color is your spray paint?"
    new_color = gets.chomp
    self.color = new_color
    puts "Your #{self.model} is now a shiny, bright #{self.color}"
  end
  
  def age
    puts "Your #{self.model} is #{find_age} years old"
  end
  
  private
    
    def find_age
      age = Time.now.year - self.year.to_i
    end
    
end

class MyCar < Vehicle
  VEHICLETYPE = "Car"

  def initialize(y, c, m)
    super(y, c, m)
  end
  
  
end

class MyTruck < Vehicle
  include Haulable
  VEHICLETYPE = "Truck"
  
  def intialize(y, c, m)
    super(y, c, m)
  end
  
end

fat_kiki = MyCar.new('2012', 'Black', 'Kia Soul')

fat_kiki.age

# fat_kiki.speed_up(55)
# fat_kiki.slow_down(30)
# fat_kiki.slow_down(50)
# fat_kiki.speed_up(10)
# fat_kiki.shut_the_car_off
# fat_kiki.speed_up(55)
# MyCar.find_mileage(5, 94)

# fat_kiki.spray_paint
# truck = MyTruck.new('2000', 'silver', 'Ford F150')
# puts MyCar.ancestors
# puts MyTruck.ancestors

# puts fat_kiki
# fat_kiki.number_of_vehicles?

