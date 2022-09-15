require "test_helper"

class TransactionTest < ActiveSupport::TestCase

  test "should be able to create transaction." do
    transaction = Transaction.new()
    transaction.trader_id = 1
    transaction.stock_id = 100000
    transaction.volume = 1
    transaction.price = 1
    transaction.transaction_type = true #buy

    assert transaction.save, "Did not create a new transaction"
  end

  test "should not be able to create transaction without trader_id." do
    transaction = Transaction.new()
    transaction.stock_id = 100000
    transaction.volume = 1
    transaction.price = 1
    transaction.transaction_type = true #buy

    assert_not transaction.save, "Created a new transaction without trader_id"
  end

  test "should not be able to create transaction without stock_id." do
    transaction = Transaction.new()
    transaction.trader_id = 1
    transaction.volume = 1
    transaction.price = 1
    transaction.transaction_type = true #buy

    assert_not transaction.save, "Created a new transaction without stock_id"
  end

  test "should not be able to create transaction without volume." do
    transaction = Transaction.new()
    transaction.trader_id = 1
    transaction.stock_id = 100000
    transaction.price = 1
    transaction.transaction_type = true #buy

    assert_not transaction.save, "Created a new transaction without volume"
  end

  test "should not be able to create transaction without price." do
    transaction = Transaction.new()
    transaction.trader_id = 1
    transaction.stock_id = 100000
    transaction.volume = 1
    transaction.transaction_type = true #buy

    assert_not transaction.save, "Created a new transaction without price"
  end

  test "should not be able to create transaction without transaction_type." do
    transaction = Transaction.new()
    transaction.trader_id = 1
    transaction.stock_id = 100000
    transaction.volume = 1
    transaction.price = 1

    assert_not transaction.save, "Created a new transaction without transaction_type"
  end

  test "should be able to buy stocks." do
    trader = Trader.new()
    trader.save
    transaction = Transaction.new()
    transaction.trader_id = trader.id
    transaction.stock_id = 100000
    transaction.volume = 1
    transaction.price = 1
    transaction.transaction_type = true #buy
    
    assert trader.buy_stock(transaction, StocksTrader.find_by(stock_id: transaction.stock_id)), "did not buy new stock"
  end

  test "should be able to sell stocks." do
    trader = Trader.new()
    trader.save
    transaction = Transaction.new()
    transaction.trader_id = trader.id
    transaction.stock_id = 100000
    transaction.volume = 1
    transaction.price = 1
    transaction.transaction_type = false #sell
    
    assert trader.sell_stock(transaction, StocksTrader.find_by(stock_id: transaction.stock_id)), "did not sell stock"
  end

  test "should not be able to buy stocks without enough cash." do
    trader = Trader.new()
    trader.cash = 0
    trader.save
    transaction = Transaction.new()
    transaction.trader_id = trader.id
    transaction.stock_id = 100000
    transaction.volume = 1
    transaction.price = 100
    transaction.transaction_type = true #buy
    
    assert_not transaction.save, "bought new stock"
  end

  test "should not be able to sell stocks without enough volume." do
    portfolio = Portfolio.new()
    portfolio.save
    transaction = Transaction.new()
    transaction.trader_id = portfolio.trader_id
    transaction.stock_id = portfolio.stock_id
    transaction.volume = 100000
    transaction.price = 100
    transaction.transaction_type = false #sell
    
    assert_not transaction.save, "sold stock without enough volume"
  end
end
