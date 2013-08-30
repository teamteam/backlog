Given /^I am logged in$/ do
  user = User.create(
    :email => 'me@me.com',
    :password => 'long password',
    :password_confirmation => 'long password'
  )

  visit new_user_session_path
  fill_in "user_email", :with => user.email
  fill_in "user_password", :with => user.password
  click_button "Sign in"
end

Given /^a backlog item exists$/ do
  @backlog_item = BacklogItem.create :name => "something"
end

Given /^I'm on the new task page$/ do
  visit backlog_item_path @backlog_item
  click_on "New task"
end

Given /^a task exists$/ do
  @task = Task.create :name => "Complete me", :backlog_item => @backlog_item
end

Given /^I'm on the backlog item page$/ do
  visit backlog_item_path @backlog_item
end

When /^I edit the task$/ do
  click_on "Edit task"
  fill_in "Name", :with => "Edited task"
  click_on "Update"
end

When /^I mark the task as complete$/ do
  click_on "Complete task"
end

When /^I enter the new task info$/ do
  fill_in "Name", :with => "My new task"
end

When /^submit$/ do
  click_on "Create"
end

When /^I view the backlog$/ do
  visit backlog_path
end

When /^I remove the task$/ do
  click_on "Remove task"
end

Then /^the task should be gone$/ do
  expect(page).not_to have_content "My new task"
end

Then /^I should see the remaining task count$/ do
  expect(page).to have_content 1
end

Then /^I should see the task on the item$/ do
  assert_not_nil Task.find_by_name "My new task"
  visit backlog_item_path @backlog_item

  expect(page).to have_content "My new task"
  expect(page).to have_selector '.tasks' do |tasks|
    expect(tasks).not_to have_selector 'i.icon-ok.completed'
  end
end

Then /^the task shows up as completed$/ do
  assert_not_nil Task.find_by_completed true
  expect(page).to have_selector '.tasks' do |tasks|
    expect(tasks).to have_selector 'i.icon-ok.completed'
  end
end

Then /^the task should be edited$/ do
  visit backlog_item_path @backlog_item

  expect(page).not_to have_content "My new task"
  expect(page).to have_content "Edited task"
end
