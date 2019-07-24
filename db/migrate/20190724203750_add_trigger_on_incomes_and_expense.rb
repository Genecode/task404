class AddTriggerOnIncomesAndExpense < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        sql = <<~SQL
          create trigger update_balance_on_incomes
          after insert or update or delete 
          on incomes
          for each row
          execute procedure upsert_balance();
        SQL
        connection.execute(sql)

        sql = <<~SQL
          create trigger update_balance_on_expenses
          after insert or update or delete 
          on expenses
          for each row
          execute procedure upsert_balance();
        SQL
        connection.execute(sql)
      end

      dir.down do
        connection.execute('DROP  TRIGGER IF EXISTS update_balance_on_incomes ON incomes')
        connection.execute('DROP  TRIGGER IF EXISTS update_balance_on_expenses ON expenses')
      end
    end
  end
end
