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
        @email = BacklogMailer.create_task_email
      end

      it "should send the email to everyone" do
        expect(@email).to deliver_to "teammate@example.com"
      end

      it "should have the correct subject" do
        expect(@email).to have_subject "Task Created"
      end
    end

    describe "New Item Email" do
      before :each do
        @email = BacklogMailer.create_item_email
      end

      it "should send the email to everyone" do
        expect(@email).to deliver_to "teammate@example.com"
      end

      it "should have the correct subject" do
        expect(@email).to have_subject "Backlog Item Created"
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
        @email = BacklogMailer.update_task_email
      end

      it "should send the email to everyone" do
        expect(@email).to deliver_to "teammate@example.com"
      end

      it "should have the correct subject" do
        expect(@email).to have_subject "Task Updated"
      end
    end

    describe "Update Item Email" do
      before :each do
        @email = BacklogMailer.update_item_email
      end

      it "should send the email to everyone" do
        expect(@email).to deliver_to "teammate@example.com"
      end

      it "should have the correct subject" do
        expect(@email).to have_subject "Backlog Item Updated"
      end
    end
  end
end
