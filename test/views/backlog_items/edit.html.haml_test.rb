require "test_helper"

describe BacklogItemsController do
  describe "edit" do
    it "shows the name of the backlog item" do
      backlog_item = BacklogItem.create :name => "Backlog Item Name"

      get :edit, :backlog_item_id => backlog_item.id

      assert_select 'body', backlog_item.name
    end
  end
end
