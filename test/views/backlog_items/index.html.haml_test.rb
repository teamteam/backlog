require "test_helper"

describe BacklogItemsController do
  describe "index" do
    it "links items to their detail page" do
      backlog_item = BacklogItem.create :name => "Backlog Item Name"

      get :index

      assert_select "a", backlog_item.name
    end
  end
end
