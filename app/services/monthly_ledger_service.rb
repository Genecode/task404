class MonthlyLedgerService
  def self.monthly_time_range(time)
    time.beginning_of_month..time.end_of_month
  end
end