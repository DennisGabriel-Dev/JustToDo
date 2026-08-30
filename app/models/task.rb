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
#  priority     :string
#  tags         :string
#
class Task < ApplicationRecord
  acts_as_paranoid

  PRIORITIES = {
    "low" => "Baixa",
    "medium" => "Média",
    "high" => "Alta"
  }.freeze

  belongs_to :task_list

  scope :ordered, -> { order(:position, :id) }
  scope :pending, -> { where(status: [false, nil]) }
  scope :done, -> { where(status: true) }
  scope :due_today, -> { where(due_at: Time.zone.today.all_day) }
  scope :overdue, -> { where.not(due_at: nil).where("due_at < ?", Time.zone.today.beginning_of_day) }

  before_validation :assign_position, on: :create
  before_validation :normalize_tags
  before_validation :default_priority

  validates :title, presence: true
  validates :priority, inclusion: { in: PRIORITIES.keys }

  def tag_list
    tags.to_s.split(",").map(&:strip).reject(&:blank?)
  end

  def overdue?
    due_at.present? && !status? && due_at.to_date < Time.zone.today
  end

  def due_today?
    due_at.present? && !status? && due_at.to_date == Time.zone.today
  end

  private

  def default_priority
    self.priority = "medium" if priority.blank?
  end

  def normalize_tags
    return if tags.blank?

    self.tags = tags.split(",").map(&:strip).reject(&:blank?).join(",")
  end

  def assign_position
    return if position.to_i.positive?

    self.position = (task_list.tasks.maximum(:position) || 0) + 1
  end
end
