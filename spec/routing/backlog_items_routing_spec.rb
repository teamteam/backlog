require "spec_helper"

describe BacklogItemsController do
  describe "path helpers" do
    it "has a backlog_path" do
      path = backlog_path

      path.should eq("/backlog")
      get(path).should route_to(
        'backlog_items#index'
      )
    end

    it "has a backlog_item_path" do
      item = mock_model BacklogItem, :id => 1
      path = backlog_item_path(item)

      path.should eq("/backlog/1")
      get(path).should route_to(
        'backlog_items#edit',
        :backlog_item_id => "#{item.id}"
      )
    end

    it "has a new_backlog_item_path" do
      path = new_backlog_item_path
      
      path.should eq("/backlog/new")
      get(path).should route_to(
        'backlog_items#new'
      )
    end

    it "has a create_backlog_item_path" do
      path = create_backlog_item_path

      path.should eq("/backlog/create")
      post(path).should route_to(
        'backlog_items#create'
      )
    end

    it "has an update_backlog_item_path" do
      item = mock_model BacklogItem, :id => 1
      path = update_backlog_item_path(item)

      path.should eq("/backlog/1")
      patch(path).should route_to(
        'backlog_items#update',
        :backlog_item_id => "#{item.id}"
      )
    end

    it "has a delete_backlog_item_path" do
      item = mock_model BacklogItem, :id => 1
      path = delete_backlog_item_path(item)

      path.should eq("/backlog/1")
      delete(path).should route_to(
        'backlog_items#destroy',
        :backlog_item_id => "#{item.id}"
      )
    end

    it "has a toggle_complete_backlog_item_path" do
      item = mock_model BacklogItem, :id => 1
      path = toggle_complete_backlog_item_path(item)
      
      path.should eq("/backlog/1/toggle-complete")
      get(path).should route_to(
        'backlog_items#toggle_complete',
        :backlog_item_id => "#{item.id}"
      )
    end
  end
end
