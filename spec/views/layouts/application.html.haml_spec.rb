require 'spec_helper'

describe 'layouts/application' do
  before :each do
    render
  end

  it "contains a link to view the archive" do
    expect(rendered).to have_link("Archive", :href => archive_backlog_path)
  end

  it "contains a link to create a new item" do
    expect(rendered).to have_link("New Item", :href => new_backlog_item_path)
  end
end
