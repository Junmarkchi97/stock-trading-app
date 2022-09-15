class DashboardController < ApplicationController
  before_action :set_client

  def index
    @stocks = Stock.all
    @microsoft = @client.quote('MSFT').latest_price
    # @logo = @client.logo('MSFT')
    @top_ten = @client.stock_market_list(:mostactive)
    @symbols = @client.ref_data_symbols()

    # @code = params[:code]
    # @stock = Stock.find(paramss[:id])

    # @company_stock = @client.quote(@stock.code)
    @companies = []

    @stocks.each do |stock|
      if stock.code != nil
        if @companies.length < 20
          @companies.push(@client.quote(stock.code))
        end
      end
    end

    if current_trader.admin
      @transactions = Transaction.all
    else
      @transactions = Transaction.where(trader_id: current_trader.id)
    end

  end

  def portfolio 
    @top_ten = @client.stock_market_list(:mostactive)
    @microsoft = @client.quote('MSFT').latest_price
    @current_stocks = current_trader.stocks
    @owned_stocks = Portfolio.where(trader_id: current_trader.id).where("volume > 0").collect do |x|
      {
        trader_id: Trader.find(x.trader_id).email ,
        name: Stock.find(x.stock_id).name,
        volume: x.volume,
        price: @client.quote(Stock.find(x.stock_id).code).latest_price,
        code: Stock.find(x.stock_id).code,
        value: x.volume * @client.quote(Stock.find(x.stock_id).code).latest_price
      }
    end
    # @owned_stocks = StocksTrader.where(trader_id: current_trader.id).where("volume > 0")
  end

  def pending
    @traders = Trader.where(approved_boolean: false)
  end

  private

  def set_client
    @client = Iex.client
    # @stock = Stock.find(params[:id])
  end
end
