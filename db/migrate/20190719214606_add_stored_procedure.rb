class AddStoredProcedure < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
      sql = <<~SQL
        CREATE OR REPLACE FUNCTION AddIncome(_amount numeric(8,2), _user_id integer, _created_at timestamp, _updated_at timestamp, OUT _id bigint) AS
        $BODY$
        BEGIN
          INSERT INTO incomes(amount, user_id, created_at, updated_at)
          VALUES(_amount, _user_id, _created_at, _updated_at)
          RETURNING id INTO _id;
        END;
        $BODY$
        LANGUAGE 'plpgsql' VOLATILE
      SQL
        connection.execute(sql)

      sql = <<~SQL
        CREATE OR REPLACE FUNCTION AddExpense(_amount numeric(8,2), _user_id integer, _assignment varchar, _created_at timestamp, _updated_at timestamp, OUT _id bigint) AS
        $BODY$
        BEGIN
          INSERT INTO expenses(amount, user_id, assignment, created_at, updated_at)
          VALUES(_amount, _user_id, _assignment, _created_at, _updated_at)
          RETURNING id INTO _id;
        END;
        $BODY$
        LANGUAGE 'plpgsql' VOLATILE
      SQL
        connection.execute(sql)
      end

      dir.down do
        connection.execute('DROP FUNCTION IF EXISTS AddIncome')
        connection.execute('DROP FUNCTION IF EXISTS AddExpense')
      end
    end
  end
end
