class AddPriorityAndTagsToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :priority, :string
    add_column :tasks, :tags, :string
  end
end
