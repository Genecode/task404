class User < ApplicationRecord
  validates :name, :address, :age, presence: true
  has_many :incomes
  has_many :expenses

  def monthly_income_sum
    incomes.where({ created_at: monthly_time_range }).sum(:amount)
  end

  def monthly_expense_sum
    expenses.where({ created_at: monthly_time_range }).sum(:amount)
  end

  private

  def monthly_time_range
    current_time = DateTime.current
    current_time.beginning_of_month..current_time
  end
end
