class UserBalanceService
  def self.call(user)
    user.incomes.sum(:amount) - user.expenses.sum(:amount)
  end
end