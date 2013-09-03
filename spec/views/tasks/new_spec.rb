require 'spec_helper'

describe "tasks/new" do
  it "has a new task form" do
    task = mock_model(
      "Task",
      :backlog_item => mock_model(BacklogItem),
      :name => "name of task"
    )
    assign :task, task

    render
    expect(rendered).to have_selector "form[action='#{backlog_item_tasks_path(task.backlog_item)}'][method='post']"
    expect(rendered).to have_field "Name"
    expect(rendered).to have_button "Create"
  end
end
