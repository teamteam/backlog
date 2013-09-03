class TasksController < ApplicationController
  def new
    item = BacklogItem.find params[:backlog_item_id]
    @task = Task.new :backlog_item_id => item.id
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

  def toggle_completed
    task = Task.find(params[:task_id])
    task.toggle_completed
    TaskMailer.complete_task_email(task).deliver
    redirect_to backlog_item_path params[:backlog_item_id]
  end

  def destroy
    task = Task.find(params[:task_id])
    task.delete
    TaskMailer.delete_task_email(task).deliver
    redirect_to backlog_item_path params[:backlog_item_id]
  end

  def edit
    @task = Task.find params[:task_id]
  end

  def update
    @task = Task.find params[:task_id]
    if @task.update_attributes params.require(:task).permit(:name)
      TaskMailer.update_task_email(@task).deliver
      redirect_to task_path(params[:backlog_item_id], params[:task_id])
    else
      render :edit
    end
  end
end
