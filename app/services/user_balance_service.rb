class UserBalanceService
  def self.call(user)
    # use ActiveRecord
    # user.incomes.sum(:amount) - user.expenses.sum(:amount)

    # without
    result = ActiveRecord::Base.connection.execute("select get_balance(#{user.id})")
    result.getvalue(0, 0).to_f
  end
end