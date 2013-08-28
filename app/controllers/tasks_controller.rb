class TasksController < ApplicationController
  def new
    item = BacklogItem.find params[:backlog_item_id]
    @task = item.tasks.build
  end

  def create
    Task.create :name => params[:task][:name], :backlog_item_id => params[:backlog_item_id]

    render :nothing => true
  end
end
