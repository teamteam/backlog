require "test_helper"

describe BacklogItemsController do
  before :each do
    @backlog_item = backlog_items :first_item
  end

  describe "index" do
    it "assigns backlog_items" do
      get :index

      assert_equal assigns(:backlog_items), BacklogItem.all
    end

    it "provides links to the backlog items" do
      get :index

      assert_select "a[href=#{backlog_item_path @backlog_item}]"
    end
  end

  describe "destroy" do
    it "deletes the backlog item" do
      delete :destroy, :backlog_item_id => @backlog_item.id

      assert_nil BacklogItem.find_by_id @backlog_item.id
    end

    it "redirects to the backlog" do
      delete :destroy, :backlog_item_id => @backlog_item.id

      assert_redirected_to backlog_path
    end
  end

  describe "edit" do
    it "assigns backlog_item" do
      get :edit, :backlog_item_id => @backlog_item.id

      assert_equal assigns(:backlog_item), @backlog_item
    end
  end
end
