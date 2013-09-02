require 'spec_helper'

describe "Notification Emails" do
  include EmailSpec::Helpers
  include EmailSpec::Matchers
  include Rails.application.routes.url_helpers

  describe "Emails" do
    before :each do
      User.stub(:all).and_return [mock_model(User, :email => "teammate@example.com")]
      @view.stub :mail
    end

    describe "Create Task Email" do
      before :each do
        task = mock_model Task, :name => "The Task Name"
        @email = BacklogMailer.create_task_email task
      end

      it "should send the email to everyone" do
        expect(@email).to deliver_to "teammate@example.com"
      end

      it "should have the correct subject" do
        expect(@email).to have_subject "Task Created"
      end

      it "should include the name of the new task" do
        expect(@email).to have_body_text /The Task Name/
      end
    end

    describe "Create Item Email" do
      before :each do
        item = mock_model BacklogItem, :name => "The Backlog Item Name"
        @email = BacklogMailer.create_item_email item
      end

      it "should send the email to everyone" do
        expect(@email).to deliver_to "teammate@example.com"
      end

      it "should have the correct subject" do
        expect(@email).to have_subject "Backlog Item Created"
      end

      it "should include the name of the new item" do
        expect(@email).to have_body_text /The Backlog Item Name/
      end
    end

    describe "Delete Task Email" do
      before :each do
        @email = BacklogMailer.delete_task_email
      end

      it "should send the email to everyone" do
        expect(@email).to deliver_to "teammate@example.com"
      end

      it "should have the correct subject" do
        expect(@email).to have_subject "Task Deleted"
      end
    end

    describe "Delete Item Email" do
      before :each do
        @email = BacklogMailer.delete_item_email
      end

      it "should send the email to everyone" do
        expect(@email).to deliver_to "teammate@example.com"
      end

      it "should have the correct subject" do
        expect(@email).to have_subject "Backlog Item Deleted"
      end
    end

    describe "Update Task Email" do
      before :each do
        task = mock_model Task, :name => "The Task Name"
        @email = BacklogMailer.update_task_email task
      end

      it "should send the email to everyone" do
        expect(@email).to deliver_to "teammate@example.com"
      end

      it "should have the correct subject" do
        expect(@email).to have_subject "Task Updated"
      end

      it "should include the name of the new task" do
        expect(@email).to have_body_text /The Task Name/
      end
    end

    describe "Update Item Email" do
      before :each do
        item = mock_model BacklogItem, :name => "The Backlog Item Name"
        @email = BacklogMailer.update_item_email item
      end

      it "should send the email to everyone" do
        expect(@email).to deliver_to "teammate@example.com"
      end

      it "should have the correct subject" do
        expect(@email).to have_subject "Backlog Item Updated"
      end

      it "should contain the item name" do
        expect(@email).to have_body_text /The Backlog Item Name/
      end
    end

    describe "Complete Task Email" do
      before :each do
        @email = BacklogMailer.complete_task_email
      end

      it "should send the email to everyone" do
        expect(@email).to deliver_to "teammate@example.com"
      end

      it "should have the correct subject" do
        expect(@email).to have_subject "Task Marked Complete"
      end
    end

    describe "Incomplete Task Email" do
      before :each do
        @email = BacklogMailer.incomplete_task_email
      end

      it "should send the email to everyone" do
        expect(@email).to deliver_to "teammate@example.com"
      end

      it "should have the correct subject" do
        expect(@email).to have_subject "Task Marked Incomplete"
      end
    end
  end
end
