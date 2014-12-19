# class Person
#   attr_accessor :name
#   def initialize(name)
#     @name = name
#   end
# end

# bob = Person.new("Steve")
# bob.name = "Bob"
# puts bob.name

class Student
  
  def initialize(name, grade)
    @name = name
    @grade = grade
  end
  
  def better_grade_than?(other_student)
    grade > other_student.grade
  end
  
  
  protected
  
    def grade
      @grade
    end
      
  
end

joe = Student.new("Joe", 99)
bob = Student.new("Bob", 90)
puts "Well done!" if joe.better_grade_than?(bob)
