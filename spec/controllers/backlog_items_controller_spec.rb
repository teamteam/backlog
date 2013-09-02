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
      context "successful" do
        before :each do
          BacklogMailer.stub_chain :create_item_email, :deliver
          backlog_item.should_receive(:save).and_return true
        end

        it "should send new item email" do
          BacklogItem.should_receive(:new).and_return backlog_item
          email = double
          email.should_receive :deliver
          BacklogMailer.should_receive(:create_item_email).and_return email

          post :create, :backlog_item => { :name => "new backlog item" }
        end

        it "creates a new backlog item" do
          BacklogItem.should_receive(:new).with(:name => "new backlog item").and_return backlog_item

          post :create, :backlog_item => { :name => "new backlog item" }
        end

        it "redirects to the backlog" do
          BacklogItem.should_receive(:new).and_return backlog_item

          post :create, :backlog_item => { :name => "" }

          expect(response).to redirect_to(backlog_item)
        end

      end

      context "unsuccessful" do
        before :each do
          BacklogItem.should_receive(:new).and_return backlog_item
          backlog_item.should_receive(:save).and_return false
        end

        it "renders the new backlog item template" do
          post :create, :backlog_item => { :name => "" }

          expect(response).to render_template(:new)
        end
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
        @request.env['HTTP_REFERER'] = ''
        BacklogItem.should_receive(:find).with(backlog_item.id.to_s).and_return backlog_item
      end

      it "should send update item email" do
        email = double
        email.should_receive :deliver
        BacklogMailer.should_receive(:update_item_email).and_return email

        post :update, :backlog_item_id => backlog_item.id, :backlog_item => { :name => "a name" }
      end

      it "updates the backlog item" do
        backlog_item.should_receive(:update_attributes).with "name" => "a name"

        post :update, :backlog_item_id => backlog_item.id, :backlog_item => { :name => "a name" }
      end

      context "successful" do
        before :each do
          backlog_item.should_receive(:update_attributes).and_return true
        end

        it "redirects back to referer when update is successful" do
          @request.env['HTTP_REFERER'] = 'something'

          post :update, :backlog_item_id => backlog_item.id, :backlog_item => { :name => "a" }

          expect(response).to redirect_to("something")
        end
      end

      context "unsuccessful" do
        before :each do
          backlog_item.should_receive(:update_attributes).and_return false
        end

        it "assigns backlog_item to the correct instance when unsucessful" do
          post :update, :backlog_item_id => backlog_item.id, :backlog_item => { :name => "" }

          expect(assigns :backlog_item).to eq(backlog_item)
        end

        it "renders the edit page when unsuccessful" do
          post :update, :backlog_item_id => backlog_item.id, :backlog_item => { :name => "" }

          expect(response).to render_template(:edit)
        end
      end
    end

    describe "#destroy" do
      it "should send update item email" do
        email = double
        email.should_receive :deliver
        BacklogMailer.should_receive(:delete_item_email).and_return email

        delete :destroy, :backlog_item_id => backlog_item.id
      end

      it "deletes the item" do
        BacklogItem.should_receive(:delete).with backlog_item.id.to_s

        delete :destroy, :backlog_item_id => backlog_item.id
      end

      it "redirects to the backlog" do
        BacklogItem.should_receive(:delete).with backlog_item.id.to_s

        get :destroy, :backlog_item_id => backlog_item.id

        expect(response).to redirect_to(backlog_path)
      end
    end
  end
end
