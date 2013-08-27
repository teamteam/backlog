require 'spec_helper'

describe BacklogItemsController do
  fixtures :backlog_items

  before :each do
    @item1 = backlog_items :first_item
    @item2 = backlog_items :second_item
  end

  describe "#index" do
    it "assigns backlog_items" do
      get :index

      expect(assigns :backlog_items).to eq(BacklogItem.where(:archived => false))
    end
  end

  describe "#archive" do
    it "assigns backlog_items" do
      BacklogItem.should_receive(:archived).and_return 'archived backlog items'

      get :archive

      expect(assigns :backlog_items).to eq('archived backlog items')
    end
  end

  describe "#new" do
    it "assigns backlog_item to a new instance of BacklogItem" do
      BacklogItem.should_receive(:new).and_return 'new backlog item'

      get :new

      expect(assigns :backlog_item).to eq('new backlog item')
    end
  end

  describe "#create" do
    before :each do
      @item = mock_model BacklogItem
      BacklogItem.should_receive(:new).and_return @item
    end

    it "creates a new backlog item" do
      @item.should_receive(:save).and_return true

      post :create, :backlog_item => { :name => "new backlog item" }
    end

    it "redirects to backlog when creation is successful" do
      @item.should_receive(:save).and_return true

      post :create, :backlog_item => { :name => "" }

      response.should redirect_to(@item)
    end

    it "renders the new template when creation fails" do
      @item.should_receive(:save).and_return false

      post :create, :backlog_item => { :name => "" }

      response.should render_template(:new)
    end
  end

  describe "#edit" do
    it "assigns backlog_item to the correct instance" do
      BacklogItem.should_receive(:find).with("1").and_return "existing backlog item"

      get :edit, :backlog_item_id => 1

      expect(assigns :backlog_item).to eq('existing backlog item')
    end
  end

  describe "#update" do
    before :each do
      @request.env['HTTP_REFERER'] = 'something'
      @item = backlog_items :first_item
    end

    it "updates the backlog item" do
      assert_nil BacklogItem.find_by_name "a"

      post :update, :backlog_item_id => @item.id, :backlog_item => { :name => "a" }

      assert_not_nil BacklogItem.find_by_name "a"
    end

    it "redirects back to referer when update is successful" do
      post :update, :backlog_item_id => @item.id, :backlog_item => { :name => "a" }

      response.should redirect_to("something")
    end

    it "assigns backlog_item to the correct instance when unsucessful" do
      post :update, :backlog_item_id => @item.id, :backlog_item => { :name => "" }

      expect(assigns :backlog_item).to eq(@item)
    end

    it "renders the edit page when unsuccessful" do
      post :update, :backlog_item_id => @item.id, :backlog_item => { :name => "" }

      response.should render_template(:edit)
    end
  end

  describe "#destroy" do
    before :each do
      @request.env['HTTP_REFERER'] = 'something'
    end

    it "deletes the item" do
      BacklogItem.should_receive(:delete).with "#{@item1.id}"

      delete :destroy, :backlog_item_id => @item1.id
    end

    it "redirects to the referer" do
      get :toggle_complete, :backlog_item_id => @item1.id

      response.should redirect_to("something")
    end
  end

  describe "#toggle_complete" do
    before :each do
      @request.env['HTTP_REFERER'] = "something"
    end

    it "toggles the backlog item completed attribute from false to true" do
      @item1.completed.should be_false

      get :toggle_complete, :backlog_item_id => @item1.id

      assert_not_nil BacklogItem.find_by_id_and_completed(@item1.id, true)
    end

    it "toggles the backlog item completed attribute from true to false" do
      @item2.completed.should be_true

      get :toggle_complete, :backlog_item_id => @item2.id

      assert_not_nil BacklogItem.find_by_id_and_completed(@item2.id, false)
    end

    it "redirects to the referer" do
      get :toggle_complete, :backlog_item_id => @item1.id

      response.should redirect_to("something")
    end
  end
end
