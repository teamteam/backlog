require 'spec_helper'
require 'rake'

Backlog::Application.load_tasks

describe "backlog:archive" do
  it "marks all backlog items without remaining tasks as archived" do
    completed_item = double BacklogItem
    incomplete_item = double BacklogItem

    BacklogItem.should_receive(:where).with(:archived => false).and_return [completed_item, incomplete_item]
    completed_item.stub_chain(:tasks, :empty?).and_return false
    completed_item.stub_chain(:tasks, :remaining, :empty?).and_return true
    completed_item.should_receive(:update_attribute).with :archived, true
    incomplete_item.stub_chain(:tasks, :empty?).and_return true
    incomplete_item.should_not_receive(:update_attribute).with :archived, true

    Rake::Task['backlog:archive'].invoke
  end
end
