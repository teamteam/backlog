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
    it "creates a new task" do
      @item = BacklogItem.create :name => "test backlog item name"
      Task.should_receive(:create).with :name => "My new task", :backlog_item_id => @item.id.to_s

      post :create, :backlog_item_id => @item.id, :task => { :name => "My new task" }
    end
  end
end
