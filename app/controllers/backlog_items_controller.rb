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
      redirect_to backlog_item_path(@backlog_item)
    else
      render :new
    end
  end

  def show
    @backlog_item = BacklogItem.find params[:id]
  end

  def update
    @backlog_item = BacklogItem.find params[:id]
    if @backlog_item.update_attributes params.require(:backlog_item).permit(:name, :completed)
      redirect_to :back
    else
      render :show
    end
  end

  def destroy
    BacklogItem.delete params[:id]
    redirect_to backlog_items_path
  end
end
