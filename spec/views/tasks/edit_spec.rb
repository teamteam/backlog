require 'spec_helper'

describe "tasks/edit" do
  it "has an edit task form" do
    task = mock_model Task
    task.stub(:backlog_item).and_return mock_model BacklogItem
    assign :task, task

    render

    expect(rendered).to have_selector "form[action='#{update_task_path(task.backlog_item, task)}']"
    expect(rendered).to have_field "Name"
    expect(rendered).to have_button "Update"
  end
end
