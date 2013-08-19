require "test_helper"

feature "Backlog" do
  scenario "can view the backlog" do
    visit backlog_path

    assert page.status_code == 200
  end
end
