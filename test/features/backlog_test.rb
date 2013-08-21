require "test_helper"

feature "Backlog" do
  scenario "can view the backlog" do
    visit backlog_path

    assert page.status_code == 200
  end

  scenario "remove item from the backlog" do
    backlog_item = backlog_items :first_item
    backlog_items(:second_item).delete

    visit backlog_path
    page.click_on "Delete"

    assert_nil BacklogItem.find_by_id backlog_item.id
  end
end
