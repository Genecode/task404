class MonthlyExpenseService < MonthlyLedgerService
  def self.call(user:, time: )
    time_range = self.monthly_time_range(time)
    user.expenses.where(created_at: time_range).sum(:amount)
  end
end