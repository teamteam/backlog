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

  it "shows an edit item link" do
    assign :backlog_items, [mock_model(BacklogItem, :name => "Archived item")]

    render
    expect(rendered).to have_link "Edit item"
  end

  it "shows a remove item link" do
    assign :backlog_items, [mock_model(BacklogItem, :name => "Archived item")]

    render
    expect(rendered).to have_link "Remove item"
  end
end
