require "test_helper"

describe BacklogItemsController do
  describe "index" do
    it "assigns backlog_items" do
      get :index

      assert_equal assigns(:backlog_items), BacklogItem.all
    end

    it "provides links to the backlog items" do
      backlog_item = backlog_items :first_item

      get :index

      assert_select "a[href=#{backlog_item_path backlog_item}]"
    end
  end

  describe "edit" do
    it "assigns backlog_item" do
      backlog_item = backlog_items :first_item

      get :edit, :backlog_item_id => backlog_item.id

      assert_equal assigns(:backlog_item), backlog_item
    end
  end
end
