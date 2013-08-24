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

  describe "toggle_complete" do
    before :each do
      @request.env["HTTP_REFERER"] = "referer-value"
    end

    it "toggles the completed value of the item" do
      backlog_item = backlog_items :first_item

      get :toggle_complete, :backlog_item_id => backlog_item.id

      assert_not_nil BacklogItem.find_by_id_and_completed(backlog_item.id, true)
    end

    it "redirects to the referer" do
      backlog_item = backlog_items :first_item

      get :toggle_complete, :backlog_item_id => backlog_item.id

      assert_redirected_to "referer-value"
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

  describe "update" do
    it "redirects to the referer" do
      @request.env["HTTP_REFERER"] = "referer-value"
      backlog_item = backlog_items :first_item

      post :update, :backlog_item_id => backlog_item.id, :backlog_item => { :name => 'something' }

      assert_redirected_to "referer-value"
    end

    it "renders edit backlog item form with errors on error" do
      backlog_item = backlog_items :first_item

      post :update, :backlog_item_id => backlog_item.id, :backlog_item => { :name => "" }

      assert_not_nil assigns(:backlog_item)
      assert_template :edit
    end
  end

  describe "new" do
    it "assigns a new backlog item" do
      get :new

      assert_nil assigns(:backlog_item).id
    end
  end

  describe "create" do
    it "creates a new backlog item" do
      post :create, :backlog_item => { :name => 'Newly Created Backlog Item Name' }

      assert_not_nil BacklogItem.find_by_name 'Newly Created Backlog Item Name'
    end

    it "redirects to backlog item on success" do
      post :create, :backlog_item => { :name => 'Item Name' }

      assert_redirected_to backlog_item_path(BacklogItem.find_by_name('Item Name'))
    end

    it "renders new backlog item form with errors on error" do
      post :create, :backlog_item => { :name => "" }

      assert_not_nil assigns(:backlog_item)
      assert_template :new
    end
  end
end
