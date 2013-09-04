class TasksController < ApplicationController
  before_filter :find_task, :only => [:show, :update, :destroy]

  def new
    item = BacklogItem.find params[:backlog_item_id]
    @task = Task.new :backlog_item_id => item.id
  end

  def show
  end

  def create
    @task = Task.new :name => params[:task][:name], :backlog_item_id => params[:backlog_item_id]
    if @task.save
      TaskMailer.create_task_email(@task).deliver
      redirect_to @task.backlog_item
    else
      render :action => :new
    end
  end

  def destroy
    @task.delete
    TaskMailer.delete_task_email(@task).deliver
    redirect_to @task.backlog_item
  end

  def update
    if @task.update_attributes params.require(:task).permit(:name, :completed)
      TaskMailer.update_task_email(@task).deliver
      redirect_to @task.backlog_item
    else
      render :show
    end
  end

  def find_task
    @task = Task.find params[:id]
  end
end
