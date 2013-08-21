class BacklogItemsController < ApplicationController
  def index
    @backlog_items = BacklogItem.all
  end

  def new
    @backlog_item = BacklogItem.new
  end

  def create
    backlog_item = BacklogItem.create :name => params[:backlog_item][:name]
    redirect_to backlog_item_path(backlog_item)
  end

  def edit
    @backlog_item = BacklogItem.find params[:backlog_item_id]
  end

  def update
    backlog_item = BacklogItem.find params[:backlog_item_id]
    backlog_item.update_attributes params.require(:backlog_item).permit(:name)
    redirect_to backlog_item_path(backlog_item)
  end

  def destroy
    BacklogItem.delete params[:backlog_item_id]
    redirect_to backlog_path
  end
end
