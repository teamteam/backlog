# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Backlog::Application.load_tasks

MiniTest::Rails::Testing.default_tasks << "features"
MiniTest::Rails::Testing.default_tasks << "views"
