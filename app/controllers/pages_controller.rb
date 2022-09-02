class PagesController < ApplicationController
  def home
    client = Iex.client
    @microsoft = client.quote('MSFT').latest_price
    
    @top_ten = client.stock_market_list(:mostactive)
    
    @symbols = client.ref_data_symbols()

  end

  def show 
    @top_ten = client.stock_market_list(:mostactive)
    @microsoft = client.quote('MSFT').latest_price
  end
end
