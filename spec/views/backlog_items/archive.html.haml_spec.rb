require 'spec_helper'

describe 'backlog_items/archive' do

  it "handles no items gracefully" do
    assign :backlog_items, []

    render
    expect(rendered).to include "No archived items"
  end

  it "shows archived items" do
    assign :backlog_items, [mock_model(BacklogItem, :name => "Archived item")]

    render
    expect(rendered).to include "Archived item"
  end
end
