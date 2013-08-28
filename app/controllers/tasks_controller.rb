class TasksController < ApplicationController
  def new
    item = BacklogItem.find params[:backlog_item_id]
    @task = Task.new :backlog_item_id => item.id
  end

  def create
    item = BacklogItem.find params[:backlog_item_id]
    @task = Task.new :name => params[:task][:name], :backlog_item_id => item.id
    if @task.save
      redirect_to backlog_item_path(item)
    else
      render :action => :new
    end
  end
end
