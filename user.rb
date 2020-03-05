
module UserModel
  class User
    attr_accessor :id, :first_name, :last_name, :email, :age, :address
    @@users = []
    @@id = 0
    
    def initialize
      @id = ''
      @first_name = ''
      @last_name = ''
      @email = ''
      @age = ''
      @address = ''
    end
    
    def self.unique?(send_email)
      @@users.none? { |user| user.email == send_email }
    end

    def self.has_value?(*fields)
      fields.all? { |field| field != '' }
    end

    def create(first_name: '', last_name: '', email: '', age: '', address: '')
      if User.has_value?(first_name, last_name, email) && User.unique?(email)
        @id = (@@id += 1)
        @first_name = first_name
        @last_name = last_name
        @email = email
        @age = age
        @address = address
        @@users << self
        true
      else
        false
      end
    end

    def self.count
      @@users.size
    end

    def self.all
      @@users
    end

    def self.find(id: 0)
      User.where(id: id).first
    end

    def self.where(*criteria)
      parsed_criteria = Hash(*criteria)
      
      @@users.select {|user|
        User.within_criteria(user, parsed_criteria)
      }
    end


    def self.update(*attributes)
      parsed_attributes = Hash(*attributes)
      return false unless parsed_attributes[:id]

      @@users.each do |user|
        next unless user.id == parsed_attributes[:id]
        
        parsed_attributes.each do |key, value|
          user.send("#{key}=", value) if user.respond_to?("#{key}")
        end

        return true
      end
      
      false
    end

    def self.destroy(id: 0)
      @@users.each_with_index do |user, index|
        if user.id == id
          @@users.delete_at(index)
          return true
        end
      end

      false
    end

    private

    def self.within_criteria(user, criteria)
      user_valid = true
      criteria.each_pair do |field, value|
        next unless user_valid
        user_valid &&= value == user.send(field)
      end

      user_valid
    end
  end
end

# u = User.new
# u2 = User.new
# u3 = User.new

# p u.create( first_name: "UNO",last_name: "TWO", email: "asd@hotmail.com")
# p u2.create(first_name: "DOS", last_name: "TWO", email: "asd2@hotmail.com")
# p User.all
# p '------------------------------'
# p u3.create(first_name: "UNO", last_name: "Three", email: "asd3@hotmail.com")
# p User.destroy(id:2)
# p User.all
# p '------------------------------'

# p User.count
# p User.find(id:3)
# p User.update(id: 1, first_name: "Juan", last_name: "Perez")
# p '------------------------------'

# p User.update(one: "one", two: "two", three: "three")
# p User.update(id: 3, first_name: "JAM", last_name: "SOLO")
# p User.all
# p '------------------------------'

# p User.where(first_name: "Juan")