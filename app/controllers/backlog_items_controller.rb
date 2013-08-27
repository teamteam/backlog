class BacklogItemsController < ApplicationController
  def index
    @backlog_items = BacklogItem.where :archived => false
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
      redirect_to :back
    else
      render :edit
    end
  end

  def destroy
    BacklogItem.delete params[:backlog_item_id]
    redirect_to backlog_path
  end

  def toggle_complete
    backlog_item = BacklogItem.find params[:backlog_item_id]
    backlog_item.update_attribute :completed, (not backlog_item.completed)
    redirect_to :back
  end
end
