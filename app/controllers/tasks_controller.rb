class TasksController < ApplicationController
  def new
    item = BacklogItem.find params[:backlog_item_id]
    @task = item.tasks.build
  end

  def create
    item = BacklogItem.find params[:backlog_item_id]
    @task = Task.new :name => params[:task][:name], :backlog_item_id => item.id
    @task.save
    redirect_to backlog_item_path(item)
  end
end
