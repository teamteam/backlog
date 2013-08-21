require "test_helper"

feature "Backlog Item" do
  scenario "can view the backlog item" do
    backlog_item = backlog_items :first_item

    visit backlog_item_path(backlog_item)

    page.must_have_content backlog_item.name
  end

  scenario "can remove the backlog item" do
    backlog_item = backlog_items :first_item

    visit backlog_item_path(backlog_item)
    page.click_on "Delete"

    assert_nil BacklogItem.find_by_id backlog_item.id
  end
end
