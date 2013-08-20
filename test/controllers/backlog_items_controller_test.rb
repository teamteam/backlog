require "test_helper"

describe BacklogItemsController do
  describe "index" do
    it "assigns backlog_items" do
      get :index

      assert_equal assigns(:items), BacklogItem.all
    end
  end
end
