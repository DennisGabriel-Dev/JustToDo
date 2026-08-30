class AddDueAtToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :due_at, :datetime
  end
end
