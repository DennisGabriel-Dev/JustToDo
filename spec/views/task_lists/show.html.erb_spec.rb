require 'rails_helper'

RSpec.describe "task_lists/show", type: :view do
  before(:each) do
    assign(:task_list, TaskList.create!(
      name: "Name",
      user: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end
