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
require 'rails_helper'

RSpec.describe TaskList, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
