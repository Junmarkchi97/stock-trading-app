class TradersController < ApplicationController
    before_action :authenticate_trader!
    before_action :set_trader, only: %i[ show edit update destroy ]
  
    # GET /traders or /traders.json
    def index
      @traders = Trader.all
    end
  
    # GET /traders/1 or /traders/1.json
    def show
    end
  
    # GET /traders/new
    def new
      @trader = Trader.new
    end
  
    # GET /traders/1/edit
    def edit
    end
  
    # POST /traders or /traders.json
    def create
      @trader = Trader.new(trader_params)
  
      respond_to do |format|
        if @trader.save
          format.html { redirect_to trader_url(@trader), notice: "Trader was successfully created." }
          format.json { render :show, status: :created, location: @trader }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @trader.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /traders/1 or /traders/1.json
    def update
      respond_to do |format|
        if @trader.update(trader_params)
          format.html { redirect_to trader_url(@trader), notice: "Trader was successfully updated." }
          format.json { render :show, status: :ok, location: @trader }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @trader.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /traders/1 or /traders/1.json
    def destroy
      @trader.destroy
  
      respond_to do |format|
        format.html { redirect_to traders_url, notice: "Trader was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    def today
      @traders = Trader.all
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_trader
        @trader = Trader.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def trader_params
        params.require(:trader).permit(:email, :password, :role, :admin)
      end
  end
  