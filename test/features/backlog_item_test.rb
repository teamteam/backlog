require "test_helper"

feature "Backlog Item" do
  scenario "can view the backlog item" do
    backlog_item = backlog_items :first_item

    visit backlog_item_path(backlog_item)

    assert page.has_text?(backlog_item.name)
  end
end
