class AddDeletedAtToTaskLists < ActiveRecord::Migration[7.0]
  def change
    add_column :task_lists, :deleted_at, :datetime
    add_index :task_lists, :deleted_at
  end
end
