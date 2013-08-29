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
end
