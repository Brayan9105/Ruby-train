
module ProductModel
  class Product
    @@products = []
    @@id = 0
    
    def self.count
      @@products.size
    end

    def self.all
      @@products
    end

    def self.find(id: 0)
      Product.where(id: id).first
    end

    def self.where(*criteria)
      parsed_criteria = Hash(*criteria)
      @@products.select { |product| Product.within_criteria(product, parsed_criteria) }
    end

    def self.update(*attributes)
      parsed_attributes = Hash(*attributes)
      return false unless parsed_attributes[:id]

      @@products.each do |product|
        next unless product.id == parsed_attributes[:id]
      
        parsed_attributes.each { |key, value| product.send("#{key}=", value) if product.respond_to?("#{key}") }
        return true
      end
      
      false
    end

    def self.destroy(id: 0)
      @@products.each_with_index do |product, index|
        if product.id == id
          @@products.delete_at(index)
          return true
        end
      end

      false
    end

    private

      def self.within_criteria(product, criteria)
        product_valid = true
        criteria.each_pair do |field, value|
          next unless product_valid
          product_valid &&= value == product.send(field)
        end

        product_valid
      end

      def self.has_value?(*fields)
        fields.all? { |field| field != '' }
      end

    public

      attr_accessor :id, :name, :value, :brand, :description, :quantity

      def initialize
        @id = ''
        @name = ''
        @value = ''
        @brand = ''
        @description = ''
        @quantity = ''
      end

      def create(name: '', value: '', brand: '', description: '', quantity: '')
        if Product.has_value?(name, value, brand)
          @id = (@@id += 1)
          @name = name
          @value = value
          @brand = brand
          @description = description
          @quantity = quantity
          @@products << self
          true
        else
          false
        end
      end
  end
end
