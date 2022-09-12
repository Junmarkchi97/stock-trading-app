class StocksController < ApplicationController
  before_action :set_stock, only: %i[ show edit update destroy ]

  # GET /stocks or /stocks.json
  def index
    @stocks = Stock.all
  end

  # GET /stocks/1 or /stocks/1.json
  def show
    @client = Iex.client
    @test = Stock.find(params[:id])
    @test2 = StocksTrader.find_by(trader_id: current_trader.id)
    @company_stock = @client.quote(@stock.code)
    # @stocks_trader = StocksTrader.new(trader_id: current_trader.id, stock_id: @test.id)
    @cash = current_trader.cash
    @stocks_trader = StocksTrader.find_or_create_by(trader_id: current_trader.id, stock_id: @test.id)
    
    # @stocks_trader = StocksTrader.find_or_create_by(params[:id])
    # @stocks_trader = StocksTrader.new

    # respond_to do |format|
    #   if @stocks_trader.save
    #     format.html { redirect_to portfolio_path, notice: "Stock was successfully created." }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @stock.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # GET /stocks/new
  def new
    @stocks_trader = StocksTrader.new
  end

  # GET /stocks/1/edit
  def edit
  
  end

  # POST /stocks or /stocks.json
  def create
    @stocks_trader = StocksTrader.new(stocks_trader_params)

    respond_to do |format|
      if @stocks_trader.save
        format.html { redirect_to stock_url(@stock), notice: "Stock was successfully created." }
        format.json { render :show, status: :created, location: @stock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stocks/1 or /stocks/1.json
  def update
    respond_to do |format|
      if @stocks_trader.update(stocks_trader_params)
        format.html { redirect_to stock_url(@stock), notice: "Stock was successfully updated." }
        format.json { render :show, status: :ok, location: @stock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1 or /stocks/1.json
  def destroy
    @stock.destroy

    respond_to do |format|
      format.html { redirect_to stocks_url, notice: "Stock was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stock_params
      params.fetch(:stock, {})
    end

    def stocks_trader_params
      params.fetch(:stocks_trader, {})
    end
end
