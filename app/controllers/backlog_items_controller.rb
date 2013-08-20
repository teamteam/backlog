class BacklogItemsController < ApplicationController
  def index
    @items = BacklogItem.all
  end
end
