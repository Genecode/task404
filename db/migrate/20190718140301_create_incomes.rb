class CreateIncomes < ActiveRecord::Migration[5.2]
  def change
    create_table :incomes do |t|
      t.decimal :amount, precision: 8, scale: 2
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
