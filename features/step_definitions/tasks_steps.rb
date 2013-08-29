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
  visit new_task_path @backlog_item
end

When /^I enter the new task info$/ do
  fill_in "Name", :with => "My new task"
end

When /^submit$/ do
  click_on "Create"
end

Then /^I should see the task on the item$/ do
  assert_not_nil Task.find_by_name "My new task"
  visit backlog_item_path @backlog_item
  expect(page).to have_content "My new task"
end
