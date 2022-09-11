class StocksTrader < ApplicationRecord

    def set_volume(transaction)
        self.volume = volume + transaction.volume
    end

end
