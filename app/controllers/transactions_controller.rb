class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]
  # before_action :get_stock#, except: %i[create]
  # , except: [:index, :show]

  # GET /transactions or /transactions.json
  def index
    if current_trader.admin
      @transactions = Transaction.all
    else
      @transactions = Transaction.where(trader_id: current_trader.id)
    end
    # @transactions = @stock.transactions
  end

  # GET /transactions/1 or /transactions/1.json
  def show
    # @transaction = Transaction.find(params[:id])
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    @stock = Stock.find(params[:stock_id])
    @client = Iex.client
    @price = @client.quote(@stock.code).latest_price 
    # @query = Stock.ransack(params[:q])
    # @stocks = @query.result(distinct: true)
    # @stock = Stock.find_by(id: @transaction.stock_id)
    # @transaction = @stock.transactions.build

    # @stock = Stock.find_by(id: '1')
    # @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    # debugger
    @transaction = Transaction.new(transaction_params)

    if Portfolio.exists?(trader_id: current_trader.id, stock_id: @transaction.stock_id)
      @portfolio = Portfolio.find_by(trader_id: current_trader.id, stock_id: @transaction.stock_id)
      if @transaction.transaction_type  
        @portfolio.volume = @portfolio.volume + @transaction.volume
        @portfolio.save
      else
        @portfolio.volume = @portfolio.volume - @transaction.volume
        @portfolio.save
      end
    else  
      Portfolio.create(trader_id: current_trader.id, stock_id: @transaction.stock_id, volume: @transaction.volume)
    end

    # @stock = Stock.find_by(id: @transaction.stock_id)
    # # @stock.volume = @stock.volume + @transaction.volume
    # # @stock.save
    
    # # @transaction = @stock.transactions.build(transaction_params)
    # # debugger
    # current_trader.stocks << @stock
    # @current_stock = current_trader.stocks.find_by(id: @transaction.stock_id)
    # @current_stock.volume = @current_stock.volume + @transaction.volume
    # @current_stock.save
    # # debugger
    # if StocksTrader.exists?(stock_id: @transaction.stock_id, trader_id: current_trader.id ) #&& StocksTrader.has_key?(:volume) 
    #   @stocks_trader = StocksTrader.find_by(stock_id: @transaction.stock_id, trader_id: current_trader.id)
    #   @stocks_trader.set_volume(@stock)
    #   # @sum = @stocks_trader.volume.to_i + @transaction.volume.to_i
    #   # @stocks_trader.volume << @sum
    #   # @stocks_trader.save
    #   # debugger
    # else
    #   StocksTrader.create(stock_id: @transaction.stock_id, trader_id: @transaction.trader_id, volume: @transaction.volume)
    #   # debugger
    # end

    respond_to do |format|
      if @transaction.save
        # debugger
        #buy and sell
        if @transaction.transaction_type == true
          current_trader.buy_stock(@transaction, StocksTrader.find_by(stock_id: @transaction.stock_id))
        elsif @transaction.transaction_type == false
          current_trader.sell_stock(@transaction, StocksTrader.find_by(stock_id: @transaction.stock_id))
          # puts @transaction_type
        end

        current_trader.save

        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully created." }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def buy
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # def get_stock
      # @stock = Stock.find(params[:stock_id])
    # end

    def set_transaction
      @transaction = Transaction.find(params[:id])
      # @transaction = @stock.transactions.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:price, :volume, :trader_id, :stock_id, :transaction_type, :transaction_id)
    end
end
