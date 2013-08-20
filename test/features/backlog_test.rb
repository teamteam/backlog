require "test_helper"

feature "Backlog" do
  scenario "can view the backlog" do
    visit backlog_path

    assert page.status_code == 200
  end

  scenario "can view a backlog item from the backlog" do
    backlog_item = BacklogItem.create :name => "Backlog Item Name"
    backlog_item2 = BacklogItem.create :name => "Backlog Item Name 2"

    visit backlog_path
    click_link backlog_item.name

    assert page.has_text?(backlog_item.name)
    assert page.has_no_text?(backlog_item2.name)
  end
end
