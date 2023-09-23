require 'rails_helper'

RSpec.describe "task_lists/new", type: :view do
  before(:each) do
    assign(:task_list, TaskList.new(
      name: "MyString",
      user: nil
    ))
  end

  it "renders new task_list form" do
    render

    assert_select "form[action=?][method=?]", task_lists_path, "post" do

      assert_select "input[name=?]", "task_list[name]"

      assert_select "input[name=?]", "task_list[user_id]"
    end
  end
end
