class Transaction < ApplicationRecord
    belongs_to :stock

    validates :trader_id, presence: true
    validates :stock_id, presence: true
    validates :price, presence: true
    validates :volume, presence: true
    validates :transaction_type, presence: true
    
    # belongs_to :trader
    # enum role: [:buy, :sell]
end
