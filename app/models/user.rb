class User < ApplicationRecord
  validates :name, :address, :age, presence: true
  has_many :incomes
  has_many :expenses
end
