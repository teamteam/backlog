class BacklogItemsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_backlog_item, :only => [:show, :update, :destroy]

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
      BacklogItemMailer.create_item_email(@backlog_item).deliver
      redirect_to @backlog_item
    else
      render :new
    end
  end

  def show
  end

  def update
    if @backlog_item.update_attributes params.require(:backlog_item).permit(:name)
      BacklogItemMailer.update_item_email(@backlog_item).deliver
      redirect_to @backlog_item
    else
      render :show
    end
  end

  def destroy
    @backlog_item.delete
    BacklogItemMailer.delete_item_email(@backlog_item).deliver
    redirect_to backlog_items_path
  end

  def find_backlog_item
    @backlog_item = BacklogItem.find params[:id]
  end
end
