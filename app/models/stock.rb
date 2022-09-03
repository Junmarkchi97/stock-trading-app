class Stock < ApplicationRecord
  has_and_belongs_to_many :traders, join_table: 'stocks_traders'
  validates :volume, numericality: { greater_than_or_equal_to: 0 }
  validates :code, uniqueness: true

end
