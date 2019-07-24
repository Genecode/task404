class Income < ApplicationRecord
  belongs_to :user
  validates :amount, presence: true
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
    sql_query = ['SELECT AddIncome (:amount, :user_id, :created_at, :updated_at)']
    sql_query << attributes.symbolize_keys
    self.class.sanitize_sql_array(sql_query)
  end

  def set_timestamp!
    self.created_at = self.updated_at = Time.current
  end
end
