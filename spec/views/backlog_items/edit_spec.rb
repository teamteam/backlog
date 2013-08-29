require 'spec_helper'

describe "backlog_items/edit" do
  it "should show tasks" do
    backlog_item = mock_model BacklogItem
    task = mock_model Task, :name => "Task 1"
    backlog_item.stub(:tasks).and_return [task]
    assign :backlog_item, backlog_item
    render
    expect(rendered).to have_content "Task 1"
  end
end
