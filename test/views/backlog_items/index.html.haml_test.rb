require "test_helper"

describe BacklogItemsController do
  describe "index" do
    it "links items to their detail page" do
      backlog_item = backlog_items :first_item

      get :index

      assert_select "a[href=#{backlog_item_path(backlog_item)}]", "Edit"
    end

    it "links to new backlog item page" do
      get :index

      assert_select "a[href=#{new_backlog_item_path}]", "Create Backlog item"
    end

    it "calls out the backlog items that are completed" do
      get :index

      assert_select "tr.success"
    end
  end
end
