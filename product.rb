require "minitest/autorun"

class Product
  def initialize
    @@products = []
    @@id = 0
  end

  def create(name: nil, value: nil, brand: nil, description: nil, quantity: nil)
  if has_value?(name, value, brand)
    @@products << {
      id: @@id += 1,
      name: name,
      value: value,
      brand: brand,
      description: description,
      quantity: quantity
    }
    return true
  end

  false
  end
    
  def count
    @@products.size
  end

  def all
    @@products
  end

  def find(id: 0)
    return false unless where(id: id).first

    where(id: id).first
  end

  def where(*criteria)
    parsed_criteria = Hash(*criteria)

    @@products.select do |product|
        within_criteria(product, parsed_criteria)
    end
  end

  def update(*attributes)
    parsed_attributes = Hash(*attributes)
    return false unless parsed_attributes[:id]

    @@products.each do |product|
      next unless product[:id] == parsed_attributes[:id]

      parsed_attributes.each do |key, value|
        product[key] = value if product.key?(key)
      end

      return true
    end
      
    false
  end

  def destroy(id: 0)
    return unless id
    @@products.each_with_index do |product, index|
      if product[:id] == id
        @@products.delete_at(index)
        return true
      end
    end

    false
  end

  private

    def has_value?(*fields)
      fields.each do |field|
        return false if field.nil? || field == ""
      end
      
      true
    end

    def within_criteria(product, criteria)
      product_valid = true
      criteria.each_pair do |field, value|
        next unless product_valid

        product_valid &&= value == product[field]
      end

      product_valid
    end
end

# pro = Product.new
# pro.create(name: "Sugar", value: 200, brand: "Manuelita", description: "Some description", quantity: 5)
# pro.create(name: "Butter", value: 300, brand: "Margarina", description: "Some description", quantity: 8)
# p pro.count
# p pro.all
# p pro.find()
# p pro.find(id: 2)
# p pro.where(value: 100)
# p pro.where(value: 200)
# p pro.update(name: 'Sal', value: 50, brand: 'Alguna sal')
# p pro.update(id: 4, name: 'Sal', value: 50, brand: 'Alguna sal')
# p pro.update(id:2, name: 'Sal', value: 50, brand: 'Alguna sal')
# p pro.all
# p pro.destroy()
# p pro.destroy(id: 4)
# p pro.destroy(id: 1)
# p pro.all

describe Product do
  before do
    @pro = Product.new
  end
    
  describe "When create a new product" do
    it "Must respond positively" do
      _(@pro.create(name: "Sugar", value: 200, brand: "Manuelita", description: "Some description", quantity: 5)).must_equal true
    end

    it "Must respond negative" do
      _(@pro.create(value: 200, brand: "Manuelita", description: "Some description", quantity: 5)).must_equal false
    end
  end

  describe "When query all products" do
    it "Must respond with an array of products" do
      @pro.create(name: "Sugar", value: 200, brand: "Manuelita", description: "Some description", quantity: 5)

      _(@pro.all()).must_equal [{:id=>1, :name=>"Sugar", :value=>200, :brand=>"Manuelita", :description=>"Some description", :quantity=>5}]
    end

    it "Must respond with a empty array" do
      _(@pro.all()).must_equal []
    end
  end

  # describe "When query one product" do
  #   it "Must respond with a hash of the product" do
  #     @pro.create(name: "Sugar", value: 200, brand: "Manuelita", description: "Some description", quantity: 5)
      
  #     _(@pro.find(id: 1)).must_equal {:id=>1, :name=>"Sugar", :value=>200, :brand=>"Manuelita", :description=>"Some description", :quantity=>5}
  #   end

  #   it "Must respond negative" do
  #     @pro.create(name: "Sugar", value: 200, brand: "Manuelita", description: "Some description", quantity: 5)
  #     _(@pro.find()).must_equal false
  #   end 
  # end

  describe "When query the number of products" do
    it "Must responde 0" do
      _(@pro.count).must_equal 0
    end

    it "Must responde 2" do
      @pro.create(name: "Sugar", value: 200, brand: "Manuelita", description: "Some description", quantity: 5)
      @pro.create(name: "Butter", value: 300, brand: "Margarina", description: "Some description", quantity: 8)

      _(@pro.count).must_equal 2
    end
  end

  describe "When query products with criteria" do
    it "Must responde with a empty array" do
      @pro.create(name: "Sugar", value: 200, brand: "Manuelita", description: "Some description", quantity: 5)
      @pro.create(name: "Butter", value: 200, brand: "Margarina", description: "Some description", quantity: 8)

      _(@pro.where(value: 'Sal')).must_equal []
    end

    it "Must responde with an array of products" do
      @pro.create(name: "Sugar", value: 200, brand: "Manuelita", description: "Some description", quantity: 5)
      @pro.create(name: "Butter", value: 200, brand: "Margarina", description: "Some description", quantity: 8)

      _(@pro.where(value: 200)).must_equal [{:id=>1, :name=>"Sugar", :value=>200, :brand=>"Manuelita", :description=>"Some description", :quantity=>5}, {:id=>2, :name=>"Butter", :value=>200, :brand=>"Margarina", :description=>"Some description", :quantity=>8}]
    end
  end

  describe "When update an products" do
      it "Must responde positive" do
        @pro.create(name: "Sugar", value: 200, brand: "Manuelita", description: "Some description", quantity: 5)
        @pro.create(name: "Butter", value: 200, brand: "Margarina", description: "Some description", quantity: 8)

        _(@pro.update(id: 2, name: "Milk", value: 2000)).must_equal true
    end

    it "Must responde negative" do
      @pro.create(name: "Sugar", value: 200, brand: "Manuelita", description: "Some description", quantity: 5)
      @pro.create(name: "Butter", value: 200, brand: "Margarina", description: "Some description", quantity: 8)

      _(@pro.update(name: "Milk", value: 2000)).must_equal false
      _(@pro.update(id: 4, name: "Milk", value: 2000)).must_equal false
    end
  end

  describe "When destroy an products" do
    it "Must responde positive" do
      @pro.create(name: "Sugar", value: 200, brand: "Manuelita", description: "Some description", quantity: 5)
      @pro.create(name: "Butter", value: 200, brand: "Margarina", description: "Some description", quantity: 8)

      _(@pro.destroy(id: 1)).must_equal true
    end

    it "Must responde negative" do
      @pro.create(name: "Sugar", value: 200, brand: "Manuelita", description: "Some description", quantity: 5)
      @pro.create(name: "Butter", value: 200, brand: "Margarina", description: "Some description", quantity: 8)

      _(@pro.destroy()).must_equal false
      _(@pro.destroy(id: 4)).must_equal false
    end
  end
end