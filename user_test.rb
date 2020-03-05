require 'minitest/autorun'
require'./user'

# http://docs.seattlerb.org/minitest/Minitest/Test.html#method-c-i_suck_and_my_tests_are_order_dependent-21
class TestMeme < MiniTest::Unit::TestCase
  i_suck_and_my_tests_are_order_dependent!
  include UserModel

  def setup
    @user = User.new
    @user2 = User.new
    @user3 = User.new
    @user4 = User.new
    @user5 = User.new
  end

  def test_1_create
    assert_equal true, @user.create(first_name: "UNO",last_name: "ONE", email: "asd@hotmail.com")
    assert_equal true, @user2.create(first_name: "DOS", last_name: "TWO", email: "asd2@hotmail.com")
    assert_equal true, @user3.create(first_name: "TRES", last_name: "THREE", email: "asd3@hotmail.com")

    # False cases
    assert_equal false, @user4.create(first_name: "TRES", last_name: "THREE", email: "asd3@hotmail.com")
    assert_equal false, @user5.create(last_name: "THREE", email: "asd5@hotmail.com")
  end

  def test_2_all
    assert_equal true, User.all[0].instance_of?(User) && User.all[0].id == 1
  end
  
  def test_3_find
    assert_equal true, User.find(id: 1).instance_of?(User) && User.all[0].id == 1

    # False cases
    assert_equal false, User.find(id: 4).instance_of?(User) && User.all[3].id == 4
    assert_nil User.find()
  end
  
  def test_4_count
    assert_equal 3, User.count
  end

  def test_5_where
    assert_equal true, User.where(id: 1)[0].instance_of?(User) && User.where(id: 1)[0].id == 1
    
    #False cases
    assert_equal [], User.where(id: 4)
  end

  def test_6_update
    assert_equal true, User.update(id: 1, first_name: "Carlos", last_name: "Marin")

    # False cases
    assert_equal false, User.update(id: 4, first_name: "JAM", last_name: "SOLO")
    assert_equal false, User.update(first_name: "Pibe", last_name: "Valderrama")
  end

  def test_7_destroy
    assert_equal true, User.destroy(id: 3)

    # False cases
    assert_equal false, User.destroy(id: 4)
    assert_equal false, User.destroy()
  end
end
