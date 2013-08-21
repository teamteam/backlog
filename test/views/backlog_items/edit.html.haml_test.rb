require "test_helper"

describe BacklogItemsController do
  describe "edit" do
    before :each do
      @backlog_item = backlog_items :first_item
      get :edit, :backlog_item_id => @backlog_item.id
    end

    it "shows the name of the backlog item" do
      @response.body.must_match /#{@backlog_item.name}/
    end

    it "shows a link back to the backlog" do
      assert_select "a[href=#{backlog_path}]", "Backlog"
    end
  end
end
