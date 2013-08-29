require 'spec_helper'

describe "backlog_items/edit" do
  context "tasks" do
    it "should show tasks" do
      backlog_item = mock_model BacklogItem
      task = mock_model Task, :name => "Task 1"
      backlog_item.stub(:tasks).and_return [task]
      assign :backlog_item, backlog_item

      render

      expect(rendered).to have_content "Task 1"
      expect(rendered).not_to have_content "No tasks"
    end

    it "should have a button to create new tasks" do
      assign :backlog_item, mock_model(BacklogItem).as_null_object

      render

      expect(rendered).to have_link "New task"
    end

    it "should handle empty task list" do
      assign :backlog_item, mock_model(BacklogItem).as_null_object

      render

      expect(rendered).to have_content "No tasks"
    end
  end
end
