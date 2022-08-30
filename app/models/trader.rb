class Trader < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: [:trader, :admin]
  after_initialize :set_default_role, :if => :new_record?
  def set_default_role
    self.role ||= :trader
  end

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :age, presence: true, numericality: { greater_than_or_equal_to: 18 }
end
