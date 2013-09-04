require 'spec_helper'

describe "backlog_items/show" do
  let(:backlog_item) { mock_model BacklogItem, :tasks => [mock_model(Task, :name => "Task 1")] }

  context "tasks" do
    context "with tasks" do
      before :each do
        assign :backlog_item, backlog_item
        backlog_item.stub(:has_work).and_return true
        backlog_item.stub(:is_done).and_return false
      end

      context "with remaining tasks" do
        it "should show message not done" do
          backlog_item.should_receive(:has_work).and_return true
          backlog_item.should_receive(:is_done).and_return false

          render

          expect(rendered).to have_content "Not done!"
        end
      end

      context "without remaining tasks" do
        it "should show done message" do
          backlog_item.should_receive(:has_work).and_return true
          backlog_item.should_receive(:is_done).and_return true

          render

          expect(rendered).to have_content "Done!"
        end
      end

      it "should show tasks" do
        render

        expect(rendered).to have_content "Task 1"
        expect(rendered).not_to have_content "No tasks"
      end

      it "should have a complete button" do
        render

        expect(rendered).to have_link "Complete task"
      end

      it "should have a remove button" do
        render

        expect(rendered).to have_link "Remove task"
      end

      it "should have a edit button" do
        render

        expect(rendered).to have_link "Edit task"
      end
    end

    context "without tasks" do
      before :each do
        assign :backlog_item, mock_model(BacklogItem, :has_work => false).as_null_object
        render
      end

      it "should show message nothing to do" do
        expect(rendered).to have_content "No work!"
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
