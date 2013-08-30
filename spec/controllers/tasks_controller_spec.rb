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

  describe "#toggle_complete" do
    before :each do
      Task.should_receive(:find).with(task.id.to_s).and_return task
    end

    it "should redirect to backlog item page" do
      get :toggle_complete, :backlog_item_id => item.id, :task_id => task.id

      expect(response).to redirect_to backlog_item_path(item)
    end

    it "calls toggle_complete on the task" do
      task.should_receive(:toggle_complete)

      get :toggle_complete, :backlog_item_id => item.id, :task_id => task.id
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
end
