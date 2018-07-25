class AddMessageIdToLog < ActiveRecord::Migration[5.2]
  def change
    add_column :runs, :telegram_message_id, :integer
  end
end
