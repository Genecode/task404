class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.decimal :balance, precision: 8, scale: 2
      t.belongs_to :user, foreign_key: true
    end
  end
end
