require "test_helper"

describe BacklogItemsController do
  describe "index" do
    it "links items to their detail page" do
      backlog_item = backlog_items :first_item

      get :index

      assert_select "a[href=#{backlog_item_path(backlog_item)}]"
    end

    it "links to new backlog item page" do
      get :index

      assert_select "a[href=#{new_backlog_item_path}]"
    end

    it "calls out the backlog items that are completed" do
      get :index

      assert_select "i.glyphicon-ok"
    end

    it "gracefully handles no backlog items" do
      BacklogItem.delete_all

      get :index

      @response.body.must_include "No backlog items"
    end
  end
end
