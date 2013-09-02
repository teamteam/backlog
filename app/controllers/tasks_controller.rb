class TasksController < ApplicationController
  def new
    item = BacklogItem.find params[:backlog_item_id]
    @task = Task.new :backlog_item_id => item.id
  end

  def create
    item = BacklogItem.find params[:backlog_item_id]
    @task = Task.new :name => params[:task][:name], :backlog_item_id => item.id
    if @task.save
      BacklogMailer.create_task_email.deliver
      redirect_to backlog_item_path(item)
    else
      render :action => :new
    end
  end

  def toggle_completed
    Task.find(params[:task_id]).toggle_completed
    redirect_to backlog_item_path params[:backlog_item_id]
  end

  def destroy
    Task.delete params[:task_id]
    BacklogMailer.delete_task_email.deliver
    redirect_to backlog_item_path params[:backlog_item_id]
  end

  def edit
    @task = Task.find params[:task_id]
  end

  def update
    @task = Task.find params[:task_id]
    if @task.update_attributes params.require(:task).permit(:name)
      BacklogMailer.update_task_email.deliver
      redirect_to task_path(params[:backlog_item_id], params[:task_id])
    else
      render :edit
    end
  end
end
