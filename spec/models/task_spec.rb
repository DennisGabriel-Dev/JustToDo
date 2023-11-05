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
require 'rails_helper'

RSpec.describe Task, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
