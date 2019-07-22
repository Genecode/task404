class MonthlyIncomeService < MonthlyLedgerService
  def self.call(user:, time: )
    time_range = self.monthly_time_range(time)
    user.incomes.where(created_at: time_range).sum(:amount)
  end
end