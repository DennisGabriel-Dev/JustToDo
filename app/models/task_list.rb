# == Schema Information
#
# Table name: task_lists
#
#  id         :bigint           not null, primary key
#  name       :string
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#
class TaskList < ApplicationRecord

  # paranoia
  acts_as_paranoid

  belongs_to :user
  has_many :tasks,  dependent: :destroy
  validates :name, presence: true, length: {minimum: 8, message: "Texto curto demais"}

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
end
