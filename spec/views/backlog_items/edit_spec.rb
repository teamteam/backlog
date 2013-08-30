require 'spec_helper'

describe "backlog_items/edit" do
  context "tasks" do
    context "with tasks" do
      before :each do
        backlog_item = mock_model BacklogItem, :tasks => [mock_model(Task, :name => "Task 1")]
        assign :backlog_item, backlog_item
        render
      end

      it "should show tasks" do
        expect(rendered).to have_content "Task 1"
        expect(rendered).not_to have_content "No tasks"
      end

      it "should have a complete button" do
        expect(rendered).to have_link "Complete task"
      end

      it "should have a remove button" do
        expect(rendered).to have_link "Remove task"
      end
    end

    context "without tasks" do
      before :each do
        assign :backlog_item, mock_model(BacklogItem).as_null_object
        render
      end

      it "should have a button to create new tasks" do
        expect(rendered).to have_link "New task"
      end

      it "should handle empty task list" do
        expect(rendered).to have_content "No tasks"
      end
    end
  end
end
