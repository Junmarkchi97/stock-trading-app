class PagesController < ApplicationController
  before_action :set_client
  def home
    
    @microsoft = @client.quote('MSFT').latest_price
    
    @top_ten = @client.stock_market_list(:mostactive)
    
    @symbols = @client.ref_data_symbols()

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
  end
end
