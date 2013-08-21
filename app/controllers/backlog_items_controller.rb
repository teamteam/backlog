class BacklogItemsController < ApplicationController
  def index
    @backlog_items = BacklogItem.all
  end

  def edit
    @backlog_item = BacklogItem.find params[:backlog_item_id]
  end

  def destroy
    BacklogItem.delete params[:backlog_item_id]
    redirect_to backlog_path
  end
end
