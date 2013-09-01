require 'spec_helper'
require 'rake'

Backlog::Application.load_tasks

describe "backlog:archive" do
  it "marks all backlog items without remaining tasks as archived" do
    completed = mock_model BacklogItem
    not_completed = mock_model BacklogItem

    BacklogItem.should_receive(:where).with(:archived => false).and_return [not_completed, completed]
    not_completed.stub_chain(:tasks, :remaining, :empty?).and_return false
    completed.stub_chain(:tasks, :remaining, :empty?).and_return true
    completed.should_receive(:update_attribute).with :archived, true

    Rake::Task['backlog:archive'].invoke
  end
end
