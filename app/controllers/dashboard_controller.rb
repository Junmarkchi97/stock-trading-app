class DashboardController < ApplicationController
  before_action :set_client

  def index
    @stocks = Stock.all
    @transactions = Transaction.all
    @microsoft = @client.quote('MSFT').latest_price
    # @logo = @client.logo('MSFT')
    @top_ten = @client.stock_market_list(:mostactive)
    @symbols = @client.ref_data_symbols()

    # @code = params[:code]
    # @stock = Stock.find(params[:id])

    # @company_stock = @client.quote(@stock.code)
    @companies = []
    @company_price = []

    # @stocks.each do |stock|
    #   if stock.code != nil
    #     @companies.push(@client.quote(stock.code).latest_price)
    #   end
    # end

    
  end

  def portfolio 
    @top_ten = @client.stock_market_list(:mostactive)
    @microsoft = @client.quote('MSFT').latest_price
    @owned_stocks = StocksTrader.where(trader_id: current_trader.id).where("volume > 0").collect do |x|
      {
        trader_id: Trader.find(x.trader_id).email ,
        name: Stock.find(x.stock_id).name,
        volume: x.volume,
        # price: Stock.find(x.stock_id).price,
        code: Stock.find(x.stock_id).code
      }
    end
    # @owned_stocks = StocksTrader.where(trader_id: current_trader.id).where("volume > 0")
  end

  private

  def set_client
    @client = Iex.client
    # @stock = Stock.find(params[:id])
  end
end
