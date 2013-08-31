require 'spec_helper'

describe BacklogItemsController do
  include Devise::TestHelpers
  fixtures :backlog_items

  let(:backlog_item) { mock_model(BacklogItem).as_null_object }

  before :each do
    @item1 = backlog_items :first_item
    @item2 = backlog_items :second_item
  end

  context "not signed in" do
    it "redirects index to login" do
      get :index

      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects archive to login" do
      get :archive

      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects new to login" do
      get :new

      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects create to login" do
      post :create, :backlog_item => { :name => "new backlog item" }

      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects edit to login" do
      get :edit, :backlog_item_id => 1

      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects update to login" do
      post :update, :backlog_item_id => 1, :backlog_item => { :name => "a" }

      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects delete to login" do
      delete :destroy, :backlog_item_id => 1

      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects toggle_complete to login" do
      get :toggle_complete, :backlog_item_id => 1

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "signed in" do
    before :each do
      user = User.create! :email => "me@me.com", :password => "long password"
      sign_in user
    end

    describe "#index" do
      it "assigns backlog_items" do
        BacklogItem.should_receive(:this_week).and_return "this week's items"

        get :index

        expect(assigns :backlog_items).to eq("this week's items")
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

        expect(response).to redirect_to(@item)
      end

      it "renders the new template when creation fails" do
        @item.should_receive(:save).and_return false

        post :create, :backlog_item => { :name => "" }

        expect(response).to render_template(:new)
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
        BacklogItem.should_receive(:find).with(backlog_item.id.to_s).and_return backlog_item
      end

      it "updates the backlog item" do
        backlog_item.should_receive(:update_attributes).with "name" => "a name"

        post :update, :backlog_item_id => backlog_item.id, :backlog_item => { :name => "a name" }
      end

      it "redirects back to referer when update is successful" do
        backlog_item.should_receive(:update_attributes).and_return true

        post :update, :backlog_item_id => backlog_item.id, :backlog_item => { :name => "a" }

        expect(response).to redirect_to("something")
      end

      it "assigns backlog_item to the correct instance when unsucessful" do
        backlog_item.should_receive(:update_attributes).and_return false

        post :update, :backlog_item_id => backlog_item.id, :backlog_item => { :name => "" }

        expect(assigns :backlog_item).to eq(backlog_item)
      end

      it "renders the edit page when unsuccessful" do
        backlog_item.should_receive(:update_attributes).and_return false

        post :update, :backlog_item_id => backlog_item.id, :backlog_item => { :name => "" }

        expect(response).to render_template(:edit)
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

        expect(response).to redirect_to("something")
      end
    end

    describe "#toggle_complete" do
      before :each do
        @request.env['HTTP_REFERER'] = "something"
      end

      it "toggles the backlog item completed attribute from false to true" do
        expect(@item1.completed).to be_false

        get :toggle_complete, :backlog_item_id => @item1.id

        assert_not_nil BacklogItem.find_by_id_and_completed(@item1.id, true)
      end

      it "toggles the backlog item completed attribute from true to false" do
        expect(@item2.completed).to be_true

        get :toggle_complete, :backlog_item_id => @item2.id

        assert_not_nil BacklogItem.find_by_id_and_completed(@item2.id, false)
      end

      it "redirects to the referer" do
        get :toggle_complete, :backlog_item_id => @item1.id

        expect(response).to redirect_to("something")
      end
    end
  end
end
