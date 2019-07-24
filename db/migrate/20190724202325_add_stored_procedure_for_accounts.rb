class AddStoredProcedureForAccounts < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        sql = <<~SQL
          create function get_balance(bigint) returns numeric(8,2)
          immutable
          strict
          language sql
          as
          $$
          SELECT ( SELECT COALESCE(SUM(amount), 0)
                    FROM incomes
                    WHERE user_id = $1 ) - 
                    ( SELECT COALESCE(SUM(amount), 0)
                    FROM expenses
                    WHERE user_id = $1 ) as sum
          $$;
        SQL
        connection.execute(sql)

        sql = <<~SQL
          create function upsert_balance() returns trigger
          language plpgsql
          as
          $$
          BEGIN
              UPDATE accounts SET balance = get_balance(NEW.user_id) 
              WHERE user_id = NEW.user_id;
              IF NOT FOUND THEN
                  INSERT INTO accounts(user_id, balance)
                  VALUES (NEW.user_id, get_balance(NEW.user_id));
              END IF ;
              RETURN NEW;
          END;
          $$;
        SQL
        connection.execute(sql)
      end

      dir.down do
        connection.execute('DROP FUNCTION IF EXISTS get_balance')
        connection.execute('DROP FUNCTION IF EXISTS upsert_balance')
      end
    end
  end
end
