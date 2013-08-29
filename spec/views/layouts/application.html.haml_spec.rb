require 'spec_helper'

describe 'layouts/application' do
  context "unauthenticated" do
    before :each do
      view.stub(:user_signed_in?).and_return false
    end

    it "does not display nav when current_user is not present" do
      render
      expect(rendered).not_to have_selector "nav"
    end
  end

  context "authenticated" do
    before :each do
      view.stub(:user_signed_in?).and_return true
    end

    context "with navigation" do
      before :each do
        render
      end

      it "contains a link to view the archive" do
        expect(rendered).to have_link("Archive", :href => archive_backlog_path)
      end

      it "contains a link to create a new item" do
        expect(rendered).to have_link("New Item", :href => new_backlog_item_path)
      end

      it "contains a link to sign out" do
        expect(rendered).to have_link("Sign Out", :href => destroy_user_session_path)
      end

    end

    context "without navigation" do
      before :each do
        assign :without_navigation, true
        render
      end

      it "does not display navigation when without_navigation is true" do
        expect(rendered).not_to have_selector "nav"
      end
    end
  end
end
