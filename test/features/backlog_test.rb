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
    page.find("#remove-#{backlog_item.id}").click

    assert_nil BacklogItem.find_by_id backlog_item.id
  end

  scenario "can complete backlog item from the backlog" do
    backlog_item = backlog_items :first_item
    backlog_items(:second_item).delete

    visit backlog_path
    page.find("#toggle-#{backlog_item.id}").click

    assert_not_nil BacklogItem.find_by_name_and_completed backlog_item.name, true
  end

  scenario "can reopen backlog item from the backlog that is completed" do
    backlog_item = backlog_items :second_item
    backlog_items(:first_item).delete

    visit backlog_path
    page.find("#toggle-#{backlog_item.id}").click

    assert_not_nil BacklogItem.find_by_name_and_completed backlog_item.name, false
  end
end
