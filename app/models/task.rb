# == Schema Information
#
# Table name: tasks
#
#  id           :bigint           not null, primary key
#  title        :string
#  status       :boolean
#  task_list_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  deleted_at   :datetime
#
class Task < ApplicationRecord

  # paranoia
  acts_as_paranoid

  belongs_to :task_list
end
