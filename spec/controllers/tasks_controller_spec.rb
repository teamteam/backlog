require 'spec_helper'

describe TasksController do
  let(:task) { mock_model(Task).as_null_object }
  let(:item) { BacklogItem.create :name => "test backlog item name" }

  before :each do
    Task.stub(:new).and_return task
  end

  describe "#new" do
    it "assigns a new task" do
      get :new, :backlog_item_id => item.id
      expect(assigns :task).to eq task
    end

    it "assigns new task to a backlog item" do
      Task.should_receive(:new).with(:backlog_item_id => item.id)
      get :new, :backlog_item_id => item.id
    end
  end

  describe "#create" do
    before :each do
      BacklogMailer.stub_chain :create_task_email, :deliver
    end

    it "should send update item email" do
      email = double
      email.should_receive :deliver
      BacklogMailer.should_receive(:create_task_email).and_return email

      post :create, :backlog_item_id => item.id, :task => { :name => "My new task" }
    end

    it "creates a new task" do
      Task.should_receive(:new).with(:name => "My new task", :backlog_item_id => item.id).and_return task
      post :create, :backlog_item_id => item.id, :task => { :name => "My new task" }
    end

    it "saves the task" do
      task.should_receive(:save)
      post :create, :backlog_item_id => item.id, :task => { :name => "My new task" }
    end

    context "when the task successfully saves" do
      it "redirects to backlog item" do
        post :create, :backlog_item_id => item.id, :task => { :name => "My new task" }
        expect(response).to redirect_to(item)
      end
    end

    context "when the task fails to save" do
      it "assigns @task" do
        task.stub(:save).and_return false
        post :create, :backlog_item_id => item.id, :task => { :name => "My new task" }
        expect(assigns :task).to eq(task)
      end

      it "renders the new template" do
        task.stub(:save).and_return false
        post :create, :backlog_item_id => item.id, :task => { :name => "My new task" }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#toggle_completed" do
    before :each do
      Task.should_receive(:find).with(task.id.to_s).and_return task
    end

    it "should redirect to backlog item page" do
      get :toggle_completed, :backlog_item_id => item.id, :task_id => task.id

      expect(response).to redirect_to backlog_item_path(item)
    end

    it "calls toggle_completed on the task" do
      task.should_receive(:toggle_completed)

      get :toggle_completed, :backlog_item_id => item.id, :task_id => task.id
    end
  end

  describe "#destroy" do
    it "deletes the task" do
      Task.should_receive(:delete).with("1")
      
      delete :destroy, :backlog_item_id => 2, :task_id => 1
    end

    it "should redirect to backlog item" do
      delete :destroy, :backlog_item_id => 2, :task_id => 1
      
      expect(response).to redirect_to backlog_item_path(2)
    end
  end

  describe "#edit" do
    it "assigns task" do
      Task.should_receive(:find).with("1").and_return "Existing task"

      get :edit, :backlog_item_id => 2, :task_id => 1

      expect(assigns :task).to eq "Existing task"
    end
  end

  describe "#update" do
    before :each do
      Task.should_receive(:find).with(task.id.to_s).and_return task
      BacklogMailer.stub_chain :update_task_email, :deliver
    end

    it "should send update item email" do
      email = double
      email.should_receive :deliver
      BacklogMailer.should_receive(:update_task_email).and_return email

      post :update, :backlog_item_id => item.id, :task_id => task.id, :task => { :name => "a name" }
    end

    it "redirects back to the task edit" do
      post :update, :backlog_item_id => item.id, :task_id => task.id, :task => { :name => "a name" }

      expect(response).to redirect_to(task_path(item, task))
    end

    it "updates the task" do
      task.should_receive(:update_attributes).with "name" => "a name"

      post :update, :backlog_item_id => item.id, :task_id => task.id, :task => { :name => "a name" }
    end

    it "assigns task to the correct instance when unsuccessful" do
      task.should_receive(:update_attributes).and_return false
  
      post :update, :backlog_item_id => item.id, :task_id => task.id, :task => { :name => "" }

      expect(assigns :task).to eq task
    end

    it "renders the edit page when unsuccessful" do
      task.should_receive(:update_attributes).and_return false
  
      post :update, :backlog_item_id => item.id, :task_id => task.id, :task => { :name => "" }

      expect(assigns :task).to render_template :edit
    end
  end
end
