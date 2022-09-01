class PagesController < ApplicationController
  def home
    client = Iex.client
    @microsoft = client.quote('MSFT').latest_price

    @top_ten = client.stock_market_list(:mostactive)
   
  end
end
