require 'spec_helper'

describe "Notification Emails" do
  include EmailSpec::Helpers
  include EmailSpec::Matchers
  include Rails.application.routes.url_helpers

  describe "Emails" do
    before :each do
      @item = mock_model BacklogItem, :name => "The Backlog Item Name"
      User.stub(:all).and_return [mock_model(User, :email => "teammate@example.com")]
    end

    describe "Create Item Email" do
      before :each do
        @email = BacklogItemMailer.create_item_email @item
      end

      it "should have the correct subject" do
        expect(@email).to have_subject "Backlog Item Created"
      end

      it "should include the name of the new item" do
        expect(@email).to have_body_text @item.name
      end
    end

    describe "Delete Item Email" do
      before :each do
        @email = BacklogItemMailer.delete_item_email @item
      end

      it "should have the correct subject" do
        expect(@email).to have_subject "Backlog Item Deleted"
      end

      it "should contain the name of the item" do
        expect(@email).to have_body_text @item.name
      end
    end

    describe "Update Item Email" do
      before :each do
        @email = BacklogItemMailer.update_item_email @item
      end

      it "should have the correct subject" do
        expect(@email).to have_subject "Backlog Item Updated"
      end

      it "should contain the item name" do
        expect(@email).to have_body_text @item.name
      end
    end
  end
end
