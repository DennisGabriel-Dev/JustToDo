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
#  position     :integer
#  due_at       :datetime
#
class Task < ApplicationRecord
  acts_as_paranoid

  belongs_to :task_list

  scope :ordered, -> { order(:position, :id) }
  scope :pending, -> { where(status: [false, nil]) }
  scope :done, -> { where(status: true) }
  scope :due_today, -> { where(due_at: Time.zone.today.all_day) }

  before_validation :assign_position, on: :create

  validates :title, presence: true

  def overdue?
    due_at.present? && !status? && due_at.to_date < Time.zone.today
  end

  def due_today?
    due_at.present? && !status? && due_at.to_date == Time.zone.today
  end

  private

  def assign_position
    return if position.to_i.positive?

    self.position = (task_list.tasks.maximum(:position) || 0) + 1
  end
end
