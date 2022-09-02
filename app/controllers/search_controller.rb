class SearchController < ApplicationController
  def index
    @query = Stock.ransack(params[:q])
    @stocks = @query.result(distinct: true)
  end
end
