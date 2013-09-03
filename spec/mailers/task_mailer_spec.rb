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
        @email = TaskMailer.create_task_email task
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

    describe "Delete Task Email" do
      before :each do
        task = mock_model Task, :name => "The Task Name"
        @email = TaskMailer.delete_task_email task
      end

      it "should send the email to everyone" do
        expect(@email).to deliver_to "teammate@example.com"
      end

      it "should have the correct subject" do
        expect(@email).to have_subject "Task Deleted"
      end

      it "should contain the name of the task" do
        expect(@email).to have_body_text /The Task Name/
      end
    end

    describe "Update Task Email" do
      before :each do
        task = mock_model Task, :name => "The Task Name"
        @email = TaskMailer.update_task_email task
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

    describe "Complete Task Email" do
      before :each do
        @task = mock_model Task, :name => "The Task Name"
        @email = TaskMailer.complete_task_email @task
      end

      it "should send the email to everyone" do
        expect(@email).to deliver_to "teammate@example.com"
      end

      it "should have the correct subject" do
        expect(@email).to have_subject "Task Marked Complete"
      end

      it "should contain the task name" do
        expect(@email).to have_body_text /The Task Name/
      end
    end

    describe "Incomplete Task Email" do
      before :each do
        @task = mock_model Task, :name => "The Task Name"
        @email = TaskMailer.incomplete_task_email @task
      end

      it "should send the email to everyone" do
        expect(@email).to deliver_to "teammate@example.com"
      end

      it "should have the correct subject" do
        expect(@email).to have_subject "Task Marked Incomplete"
      end

      it "should contain the task name" do
        expect(@email).to have_body_text /The Task Name/
      end
    end
  end
end
