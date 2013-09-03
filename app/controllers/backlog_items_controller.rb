class BacklogItemsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @backlog_items = BacklogItem.this_week
  end

  def archive
    @backlog_items = BacklogItem.archived
  end

  def new
    @backlog_item = BacklogItem.new
  end

  def create
    @backlog_item = BacklogItem.new :name => params[:backlog_item][:name]
    if @backlog_item.save
      BacklogMailer.create_item_email(@backlog_item).deliver
      redirect_to backlog_item_path(@backlog_item)
    else
      render :new
    end
  end

  def edit
    @backlog_item = BacklogItem.find params[:backlog_item_id]
  end

  def update
    @backlog_item = BacklogItem.find params[:backlog_item_id]
    if @backlog_item.update_attributes params.require(:backlog_item).permit(:name, :completed)
      BacklogMailer.update_item_email(@backlog_item).deliver
      redirect_to :back
    else
      render :edit
    end
  end

  def destroy
    backlog_item = BacklogItem.find params[:backlog_item_id]
    backlog_item.delete
    BacklogMailer.delete_item_email(backlog_item).deliver
    redirect_to backlog_path
  end
end
