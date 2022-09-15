require "test_helper"

class TraderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @trader = traders(:one)
  end

  test "Should reject trader without an email" do
    trader = Trader.create( first_name: @trader.first_name , last_name: @trader.last_name, age: @trader.age )

    assert_not  trader.save, "saved trader without an email"
  end

  test "Should reject trader without a first name" do
    trader = Trader.create( email: @trader.email , last_name: @trader.last_name, age: @trader.age )

    assert_not trader.save,"saved trader without a first name"
  end

  test "Should reject trader without a last name" do
    trader = Trader.create( email: @trader.email , first_name: @trader.first_name, age: @trader.age )

    assert_not trader.save,"saved trader without a last name"
  end

  test "Should reject trader without an age" do
    trader = Trader.create( email: @trader.email , first_name: @trader.first_name, last_name: @trader.last_name, )

    assert_not trader.save,"saved trader without an age"
  end

  test "Should reject trader with age below 18" do
    trader = Trader.create( email: @trader.email , first_name: @trader.first_name, last_name: @trader.last_name, age: 16 )

    assert_not trader.save,"saved trader with age below 18"
  end

  test "Should reject trader with existing email" do
    trader1 = Trader.create( email: @trader.email , first_name: @trader.first_name, last_name: @trader.last_name, age: 18 )
    trader2 = Trader.create( email: @trader.email , first_name: 'James', last_name: 'Bond', age: 18 )
    
    trader1.save
    assert_not trader2.save,"saved trader with existing email"
  end
end
