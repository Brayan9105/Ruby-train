require "minitest/autorun"

class User
  attr_accessor :users
 
  def initialize
    @@users = []
    @@id = 0
  end
  
  def unique?(email: nil)
    @@users.each do |user|
      return false if user[:email] == email
    end
    true
  end

  def has_value?(*fields)
    fields.each do |field|
      return false unless field
    end
    true
  end

  def create(first_name: nil, last_name: nil, email: nil, age: nil, address: nil)
    if has_value?(first_name, last_name, email) && unique?(email: email)
      @@users << {
        id: @@id += 1,
        first_name: first_name,
        last_name: last_name,
        email: email,
        age: age,
        address: address
      }

      true
    else
      false
    end
  end

  def count
    @@users.size
  end

  def all
    @@users
  end

  def find(id: 0)
    return false unless where(id: id).first
    
    where(id: id).first
  end

  def where(*criteria)
    parsed_criteria = Hash(*criteria)
    
    @@users.select {|user|
      within_criteria(user, parsed_criteria)
    }
  end


  def update(*attributes)
    parsed_attributes = Hash(*attributes)
    return false unless parsed_attributes[:id]

    @@users.each do |user|
      next unless user[:id] == parsed_attributes[:id]

      parsed_attributes.each do |key, value|
        user[key] = value if user.key?(key)
      end

      return true
    end
     
    false
  end

  def destroy(id: 0)
    @@users.each_with_index do |user, index|
      if user[:id] == id
        @@users.delete_at(index)
        return true
      end
    end

    false
  end

  private

  def within_criteria(user, criteria)
    user_valid = true
    criteria.each_pair do |field, value|
      next unless user_valid

      user_valid &&= value == user[field]
    end

    user_valid
  end
end

# u = User.new

# u.create( first_name: "UNO",last_name: "ONE", email: "asd@hotmail.com")
# u.create(first_name: "DOS", last_name: "TWO", email: "asd2@hotmail.com")
# u.create(first_name: "UNO", last_name: "Three", email: "asd3@hotmail.com")
# u.destroy(id:2)
# p u.all

# p u.count
# p u.find(id:3)
# u.update(id: 1, first_name: "Juan", last_name: "Perez")
# u.update(one: "one", two: "two", three: "three")
# u.update(id: 3, first_name: "JAM", last_name: "SOLO")
# p u.all
# p u.where(first_name: "UNO")

describe User do
  before do
    @u = User.new
  end
    
  describe "When create a new user" do
    it "Must respond positively" do
      _(@u.create(first_name: "UNO",last_name: "ONE", email: "asd@hotmail.com")).must_equal true
    end

    it "Must respond negative" do
      @u.create(first_name: "prueba", last_name: "Three", email: "asd@hotmail.com")

      _(@u.create(last_name: "ONE", email: "asd@hotmail.com")).must_equal false # name require
      _(@u.create(first_name: "UNO",last_name: "ONE", email: "asd@hotmail.com")).must_equal false #no unique email
    end
  end

  describe "When query all users" do
    it "Must respond with an array of users" do
      @u.create( first_name: "UNO",last_name: "ONE", email: "asd@hotmail.com")

      _(@u.all()).must_equal [{:id=>1, :first_name=>"UNO", :last_name=>"ONE", :email=>"asd@hotmail.com", :age=>nil, :address=>nil}]
    end

    it "Must respond with a empty array" do
      _(@u.all()).must_equal []
    end
  end

  # describe "When query one user" do
  #   it "Must respond with a hash of the user" do
  #     @u.create(first_name: "UNO", last_name: "ONE", email: "asd@hotmail.com")
      
  #     _(@u.find(id: 1)).must_equal {}
  #     _(@u.find(id: 1)).must_equal {:id=>1, :first_name=>"UNO", :last_name=>"ONE", :email=>"asd@hotmail.com", :age=>nil, :address=>nil}
  #   end

  #   it "Must respond with a hash of the user" do
  #     @u.create(first_name: "UNO", last_name: "ONE", email: "asd@hotmail.com")
  #     _(@u.find()).must_equal false
  #   end 
  # end

  describe "When query the number of users" do
    it "Must responde 0" do
      _(@u.count).must_equal 0
    end

    it "Must responde 2" do
      @u.create( first_name: "UNO",last_name: "ONE", email: "asd@hotmail.com")
      @u.create(first_name: "DOS", last_name: "TWO", email: "asd2@hotmail.com")

      _(@u.count).must_equal 2
    end
  end

  describe "When query users with criteria" do
    it "Must responde with a empty array" do
      @u.create( first_name: "UNO",last_name: "ONE", email: "asd@hotmail.com")
      @u.create(first_name: "DOS", last_name: "TWO", email: "asd2@hotmail.com")
      @u.create(first_name: "UNO", last_name: "Three", email: "asd3@hotmail.com")

      _(@u.where(first_name: "Paula")).must_equal []
    end

    it "Must responde with an array of users" do
      @u.create( first_name: "UNO",last_name: "ONE", email: "asd@hotmail.com")
      @u.create(first_name: "DOS", last_name: "TWO", email: "asd2@hotmail.com")
      @u.create(first_name: "UNO", last_name: "Three", email: "asd3@hotmail.com")

      _(@u.where(first_name: "UNO")).must_equal [{:id=>1, :first_name=>"UNO", :last_name=>"ONE", :email=>"asd@hotmail.com", :age=>nil, :address=>nil}, {:id=>3, :first_name=>"UNO", :last_name=>"Three", :email=>"asd3@hotmail.com", :age=>nil, :address=>nil}]
    end
  end

  describe "When update an users" do
      it "Must responde positive" do
      @u.create( first_name: "UNO",last_name: "ONE", email: "asd@hotmail.com")
      @u.create(first_name: "DOS", last_name: "TWO", email: "asd2@hotmail.com")
      @u.create(first_name: "UNO", last_name: "Three", email: "asd3@hotmail.com")

      _(@u.update(id: 3, first_name: "JAM", last_name: "SOLO")).must_equal true
    end

    it "Must responde negative" do
      @u.create( first_name: "UNO",last_name: "ONE", email: "asd@hotmail.com")
      @u.create(first_name: "DOS", last_name: "TWO", email: "asd2@hotmail.com")
      @u.create(first_name: "UNO", last_name: "Three", email: "asd3@hotmail.com")

      _(@u.update(id: 4, first_name: "JAM", last_name: "SOLO")).must_equal false
      _(@u.update(first_name: "JAM", last_name: "SOLO")).must_equal false
    end
  end

  describe "When destroy an users" do
    it "Must responde positive" do
      @u.create( first_name: "UNO",last_name: "ONE", email: "asd@hotmail.com")
      @u.create(first_name: "DOS", last_name: "TWO", email: "asd2@hotmail.com")
      @u.create(first_name: "UNO", last_name: "Three", email: "asd3@hotmail.com")

      _(@u.destroy(id: 3)).must_equal true
    end

    it "Must responde negative" do
      @u.create( first_name: "UNO",last_name: "ONE", email: "asd@hotmail.com")
      @u.create(first_name: "DOS", last_name: "TWO", email: "asd2@hotmail.com")
      @u.create(first_name: "UNO", last_name: "Three", email: "asd3@hotmail.com")

      _(@u.destroy()).must_equal false
      _(@u.destroy(id: 4)).must_equal false
    end
  end
end