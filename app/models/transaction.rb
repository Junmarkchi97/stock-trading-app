class Transaction < ApplicationRecord
    belongs_to :stock
    belongs_to :trader
    enum role: [:buy, :sell]
end
