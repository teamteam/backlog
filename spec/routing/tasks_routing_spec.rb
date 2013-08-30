require 'spec_helper'

describe TasksController do
  describe "routes" do
    before :each do
      @team_name = "teamteam"
      @backlog_item = mock_model BacklogItem
    end

    it "has a new_task_path" do
      path = new_task_path @backlog_item
      expect(path).to eq "/#{@team_name}/#{@backlog_item.id}/tasks/new"
      expect(:get => path).to route_to(
        :controller => "tasks",
        :action => "new",
        :backlog_item_id => "#{@backlog_item.id}"
      )
    end

    it "has a create_task_path" do
      path = create_task_path @backlog_item

      expect(path).to eq "/#{@team_name}/#{@backlog_item.id}/tasks/create"
      expect(:post => path).to route_to(
        :controller => "tasks",
        :action => "create",
        :backlog_item_id => @backlog_item.id.to_s
      )
    end

    it "has a toggle_completed_task_path" do
      task = mock_model Task
      path = toggle_completed_task_path @backlog_item, task

      expect(path).to eq "/#{@team_name}/#{@backlog_item.id}/tasks/#{task.id}/toggle-completed"
      expect(:get => path).to route_to(
        :controller => "tasks",
        :action => "toggle_completed",
        :backlog_item_id => @backlog_item.id.to_s,
        :task_id => task.id.to_s
      )
    end

    it "has a delete_task_path" do
      task = mock_model Task
      path = delete_task_path @backlog_item, task

      expect(path).to eq "/#{@team_name}/#{@backlog_item.id}/tasks/#{task.id}"
      expect(:delete => path).to route_to(
        :controller => "tasks",
        :action => "destroy",
        :backlog_item_id => @backlog_item.id.to_s,
        :task_id => task.id.to_s
      )
    end
  end
end
