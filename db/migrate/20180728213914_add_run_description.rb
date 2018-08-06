class AddRunDescription < ActiveRecord::Migration[5.2]
  def change
    add_column :runs, :description, :text
  end
end
