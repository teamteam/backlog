require 'spec_helper'
require 'rake'

Backlog::Application.load_tasks

describe "backlog:archive" do
  fixtures :backlog_items

  before :each do
    Rake::Task['backlog:archive'].invoke
  end

  it "ignores non-completed items" do
    backlog_item = backlog_items :first_item

    assert_not_nil BacklogItem.find_by_id_and_archived(backlog_item.id, false)
  end

  it "sets archive to true on completed items" do
    backlog_item = backlog_items :second_item

    assert_not_nil BacklogItem.find_by_id_and_archived(backlog_item.id, true)
  end
end
