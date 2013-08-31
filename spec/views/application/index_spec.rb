require 'spec_helper'

describe 'application/index' do
  it "shows Coming Soon if you are not signed in" do
    view.stub(:user_signed_in?).and_return false

    render

    expect(rendered).to have_content "Coming Soon"
    expect(rendered).not_to have_content "View Backlog"
  end

  it "shows a View Backlog link if you are signed in" do
    view.stub(:user_signed_in?).and_return true

    render

    expect(rendered).to have_content "View Backlog"
    expect(rendered).not_to have_content "Coming Soon"
  end
end
