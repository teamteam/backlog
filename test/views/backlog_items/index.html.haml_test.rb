require "test_helper"

describe BacklogItemsController do
  describe "index" do
    it "links items to their detail page" do
      backlog_item = backlog_items :first_item

      get :index

      assert_select "a", backlog_item.name
    end
  end
end
