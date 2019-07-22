class User < ApplicationRecord
  validates :name, :address, :age, presence: true
  validates :age, numericality: { greater_than: 0 }

  has_many :incomes
  has_many :expenses

  def monthly_income_sum
    MonthlyIncomeService.call(user: self, time: Time.now)
  end

  def monthly_expense_sum
    MonthlyExpenseService.call(user: self, time: Time.now)
  end

  def balance
    UserBalanceService.call(self)
  end

end
