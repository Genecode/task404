class Expense < ApplicationRecord
  belongs_to :user
  validates :amount, :assignment, presence: true
  validates :amount, numericality: { greater_than: 0 }

  def add
    set_timestamp!
    raise ActiveRecord::RecordInvalid.new(self) if invalid?

    result = self.class.connection.execute(sql)
    self.id = result.getvalue(0, 0)
    id
  rescue ActiveRecord::RecordInvalid
    false
  end

  private

  def sql
    sql_query = ['SELECT AddExpense (:amount, :user_id, :assignment,
                  :created_at, :updated_at)']
    sql_query << attributes.symbolize_keys
    self.class.sanitize_sql_array(sql_query)
  end

  def set_timestamp!
    self.created_at = self.updated_at = Time.now
  end

end
