class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]
  before_action :get_stock
  # , except: [:index, :show]

  # GET /transactions or /transactions.json
  def index
    # @transactions = Transaction.all
    @transactions = @stock.transactions
  end

  # GET /transactions/1 or /transactions/1.json
  def show
    # @transaction = Transaction.find(params[:id])
  end

  # GET /transactions/new
  def new
    # @transaction = Transaction.new
    @transaction = @stock.transactions.build

    # @stock = Stock.find_by(id: '1')
    # @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    # @transaction = Transaction.new(transaction_params)
    @transaction = @stock.transactions.build(transaction_params)

    respond_to do |format|
      if @transaction.save
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
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def get_stock
      @stock = Stock.find(params[:stock_id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:price, :volume, :trader_id, :stock_id, :transaction_type, :transaction_id)
    end
end
