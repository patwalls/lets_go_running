class CreateUsersTableAndLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :telegram_id
      t.string :first_name
      t.string :last_name

      t.timestamps
    end

    create_table :runs do |t|
      t.integer :user_id
      t.decimal :distance, :precision => 5, :scale => 2

      t.timestamps
    end
  end
end
