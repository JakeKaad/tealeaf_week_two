class MyCar
attr_accessor  :color, :model, :speed
attr_reader :year

  def initialize(y, c, m)
    @year = y 
    @color = c 
    @model = m
    @speed = 0
  end
  
  def speed_up(i)
    self.speed += i
    self.speed_of_car
  end
  
  def slow_down(i)
    self.speed -= i
    if self.speed < 0
      self.speed = 0
    end
    self.speed_of_car
  end
  
  def speed_of_car
    puts "You are now going #{self.speed}"
  end
  
  def shut_the_car_off
    self.speed = 0
    puts "Your car is now off and speed is 0"
  end
  
  def spray_paint
    puts "Ugh, #{self.color} is ugly! Lets spray paint it!"
    puts "Rattle, rattle, rattle.  What color is your spray paint?"
    new_color = gets.chomp
    self.color = new_color
    puts "Your car is now a shiny, bright #{self.color}"
  end
  
  def self.find_mileage(gallons, miles)
    puts "#{miles / gallons} per gallon"
  end
  
  def to_s
    "My car is a #{self.color}, #{self.year}, #{self.model}."
  end
  

    
end

fat_kiki = MyCar.new('2014', 'Black', 'Kia Soul')

fat_kiki.speed_up(55)
fat_kiki.slow_down(30)
fat_kiki.slow_down(50)
fat_kiki.speed_up(10)
fat_kiki.shut_the_car_off
fat_kiki.speed_up(55)
MyCar.find_mileage(5, 94)

fat_kiki.spray_paint

puts fat_kiki

