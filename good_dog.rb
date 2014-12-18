class GoodDog
  attr_accessor :name, :height, :weight, :age
  @@number_of_dogs = 0
  DOG_YEARS = 7
  
  def initialize(n, h, w, a)
    self.name = n
    self.height = h
    self.weight = w
    self.age = a * DOG_YEARS
    @@number_of_dogs += 1
  end
  
  def speak
    "#{name} says Arf!"
  end
  
  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w 
  end
  
  def info 
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end
  
  def self.total_number_of_dogs
    @@number_of_dogs
  end
  
  def what_is_self?
    self
  end
  
end

sparky = GoodDog.new('Sparky', '12 inches', '10lbs', 3)
puts sparky.info

sparky.change_info('Spartacus', '24 inches', '45lbs')
puts sparky.info

fido = GoodDog.new("fido", "12inches", "15lbs", 3)
spot = GoodDog.new("spot", "25 Inches", "49lbs", 5)
puts GoodDog.total_number_of_dogs
puts sparky.age
p sparky.what_is_self?