class AddDurationToRuns < ActiveRecord::Migration[5.2]
  def change
    add_column :runs, :duration, :integer
  end
end
