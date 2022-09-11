class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]
  # before_action :get_stock#, except: %i[create]
  # , except: [:index, :show]

  # GET /transactions or /transactions.json
  def index
    @transactions = Transaction.all
    # @transactions = @stock.transactions
  end

  # GET /transactions/1 or /transactions/1.json
  def show
    # @transaction = Transaction.find(params[:id])
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
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
    @stocks_trader = StocksTrader.find_by(stock_id: @transaction.stock_id)
    @sum = @stocks_trader.volume.to_i + @transaction.volume.to_i
    # @transaction = @stock.transactions.build(transaction_params)
    # debugger
    # current_trader.stocks << @stock
    if StocksTrader.exists?(stock_id: @transaction.stock_id)
      @stocks_trader.update_attribute(:volume, @sum) 
    else
      StocksTrader.create(stock_id: @transaction.stock_id, trader_id: @transaction.trader_id, volume: @transaction.volume)
    end

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
