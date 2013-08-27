require "test_helper"

describe BacklogItemsController do
  describe "index" do
    describe "with backlog items" do
      before :each do
        @backlog_item = backlog_items :first_item

        get :index
      end

      it "links items to their detail page" do
        assert_select "a[href=#{backlog_item_path(@backlog_item)}]"
      end

      it "links to new backlog item page" do
        assert_select "a[href=#{new_backlog_item_path}]"
      end

      it "calls out the backlog items that are completed" do
        assert_select "i.icon-ok"
      end
    end

    describe "without backlog items" do
      it "gracefully handles no backlog items" do
        BacklogItem.delete_all

        get :index

        @response.body.must_include "No backlog items"
      end
    end
  end
end
