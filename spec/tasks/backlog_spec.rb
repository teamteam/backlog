require 'spec_helper'
require 'rake'

Backlog::Application.load_tasks

describe "backlog:archive" do
  it "marks all complete items as archived" do
    completed = mock_model BacklogItem, :completed => true
    completed.should_receive(:update_attribute).with :archived, true
    BacklogItem.should_receive(:where).with(:completed => true, :archived => false).and_return [completed]

    Rake::Task['backlog:archive'].invoke
  end
end
