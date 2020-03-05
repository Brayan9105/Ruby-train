require 'rspec'
require './product'
include ProductModel

describe 'Product' do
  before do
    @product = Product.new
    @product2 = Product.new
    @product3 = Product.new
    @product4 = Product.new
  end

  describe 'Product create' do
    it 'Must create an instances of product correctly' do
      expect(@product.create( name: "Mantequilla", value: "1500", brand: "Margarina")).to be(true)
      expect(@product2.create( name: "Azucar", value: "1000", brand: "Manuelita")).to be(true)
      expect(@product3.create( name: "Arroz", value: "3000", brand: "Roa")).to be(true)
    end
    
    it 'Must respond false' do
      expect(@product4.create(value: "3000", brand: "Roa")).to be(false)
    end
  end

  describe 'Product all' do
    it 'Must return an array of product instances' do
      expect(Product.all[0]).to be_an_instance_of(Product)
      expect(Product.all[0].id).to be(1)
    end
  end

  describe 'Product find' do
    it 'Must respond with a specific instance of product' do
      expect(Product.find(id: 2)).to be_an_instance_of(Product)
      expect(Product.find(id: 2).id).to be(2)
    end

    it 'Must repond nil' do
      expect(Product.find(id: 4)).to be_nil
      expect(Product.find()).to be_nil
    end
  end

  describe 'Product count' do
    it 'Must respond with the numbes of products' do
      expect(Product.count()).to be(3)
    end
  end

  describe 'Product where' do
    it 'Must return an array of product with criteria' do
      expect(Product.where(brand: 'Roa')[0]).to be_an_instance_of(Product)
      expect(Product.where(brand: 'Roa')[0].id).to be(3)
    end

    it 'Must return an array empty' do
      expect(Product.where(brand: 'Milo')).to eql([])
    end
  end

  describe 'Product update' do
    it 'Must change the value of instace' do
      expect(Product.update(id: 1, name: "Sal", brand: "Refisal")).to be(true)
    end
    
    it 'Must return false' do
      expect(Product.update(name: "Sal", brand: "Refisal")).to be(false)
      expect(Product.update(id: 4, name: "Sal", brand: "Refisal")).to be(false)
    end
  end

  describe 'Product destroy' do
    it 'Must delete the product from the array' do
      expect(Product.destroy(id: 1)).to be(true)
    end
    
    it 'Must return false' do
      expect(Product.destroy()).to be(false)
      expect(Product.destroy(id: 4)).to be(false)
    end
  end
end
