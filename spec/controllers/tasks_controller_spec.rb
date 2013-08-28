require 'spec_helper'

describe TasksController do
  describe "#new" do
    before :each do
      @item = BacklogItem.create :name => "test backlog item name"
    end

    it "assigns a new task" do
      get :new, :backlog_item_id => @item.id

      expect(assigns :task).to be_a Task
      expect(assigns :task).to be_new_record
    end

    it "assigns new task to a backlog item" do
      get :new, :backlog_item_id => @item.id

      expect(assigns(:task).backlog_item).to eq(@item)
    end
  end

  describe "#create" do
    before :each do
      @item = BacklogItem.create :name => "test backlog item name"
    end

    it "creates a new task" do
      task = mock_model(Task).as_null_object
      Task.should_receive(:new).with(:name => "My new task", :backlog_item_id => @item.id).and_return task
      post :create, :backlog_item_id => @item.id, :task => { :name => "My new task" }
    end

    it "redirects to backlog item when creation is successful" do
      post :create, :backlog_item_id => @item.id, :task => { :name => "My new task" }
      expect(response).to redirect_to(@item)
    end

    it "saves the task" do
      task = mock_model Task
      Task.stub(:new).and_return(task)
      task.should_receive(:save)
      post :create, :backlog_item_id => @item.id, :task => { :name => "My new task" }
    end

    it "renders the new template when creation fails"
  end
end
