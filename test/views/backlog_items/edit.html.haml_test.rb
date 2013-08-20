require "test_helper"

describe BacklogItemsController do
  describe "edit" do
    it "shows the name of the backlog item" do
      backlog_item = backlog_items :first_item

      get :edit, :backlog_item_id => backlog_item.id

      assert_select 'body', backlog_item.name
    end
  end
end
