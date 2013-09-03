require "spec_helper"

describe BacklogItemsController do
  describe "routes" do
    before :each do
      @team_name = "teamteam"
    end

    it "has a backlog_items_path" do
      path = backlog_items_path

      expect(path).to eq("/#{@team_name}")
      expect(get(path)).to route_to(
        :action => 'index',
        :controller => 'backlog_items',
      )
    end

    it "has a archive_backlog_items_path" do
      path = archive_backlog_items_path

      expect(path).to eq("/#{@team_name}/archive")
      expect(get(path)).to route_to(
        'backlog_items#archive'
      )
    end

    it "has a backlog_item_path" do
      item = mock_model BacklogItem, :id => 1
      path = backlog_item_path(item)

      expect(path).to eq("/#{@team_name}/1")
      expect(get(path)).to route_to(
        :action => 'show',
        :controller => 'backlog_items',
        :id => "#{item.id}"
      )
    end

    it "has a new_backlog_item_path" do
      path = new_backlog_item_path
      
      expect(path).to eq("/#{@team_name}/new")
      expect(get(path)).to route_to(
        'backlog_items#new'
      )
    end

    it "has a create backlog_item_path" do
      path = backlog_items_path

      expect(path).to eq("/#{@team_name}")
      expect(post(path)).to route_to(
        'backlog_items#create'
      )
    end

    it "has an update backlog_item_path" do
      item = mock_model BacklogItem, :id => 1
      path = backlog_item_path(item)

      expect(path).to eq("/#{@team_name}/1")
      expect(patch(path)).to route_to(
        'backlog_items#update',
        :id => "#{item.id}"
      )
    end

    it "has a delete backlog_item_path" do
      item = mock_model BacklogItem, :id => 1
      path = backlog_item_path(item)

      expect(path).to eq("/#{@team_name}/1")
      expect(delete(path)).to route_to(
        'backlog_items#destroy',
        :id => "#{item.id}"
      )
    end
  end
end
