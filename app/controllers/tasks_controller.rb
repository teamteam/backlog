class TasksController < ApplicationController
  def new
    item = BacklogItem.find params[:backlog_item_id]
    @task = Task.new :backlog_item_id => item.id
  end

  def show
    @task = Task.find params[:id]
  end

  def create
    item = BacklogItem.find params[:backlog_item_id]
    @task = Task.new :name => params[:task][:name], :backlog_item_id => item.id
    if @task.save
      TaskMailer.create_task_email(@task).deliver
      redirect_to backlog_item_path(item)
    else
      render :action => :new
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.delete
    TaskMailer.delete_task_email(task).deliver
    redirect_to backlog_item_path params[:backlog_item_id]
  end

  def update
    @task = Task.find params[:id]
    if @task.update_attributes params.require(:task).permit(:name, :completed)
      TaskMailer.update_task_email(@task).deliver
      redirect_to backlog_item_path params[:backlog_item_id]
    else
      render :show
    end
  end
end
