require 'spec_helper'

describe 'backlog_items/archive.html.haml' do

  it "handles no items gracefully" do
    assign :backlog_items, []

    render
    rendered.should include "No archived items"
  end

  it "shows archived items" do
    assign :backlog_items, [mock_model(BacklogItem, :name => "Archived item")]

    render
    rendered.should include "Archived item"
  end
end
