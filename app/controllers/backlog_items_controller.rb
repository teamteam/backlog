class BacklogItemsController < ApplicationController
  def index
    @items = BacklogItem.all
  end

  def edit
    @backlog_item = BacklogItem.find params[:backlog_item_id]
  end
end
