require 'spec_helper'

describe Task do
  it "requires a name" do
    expect(Task.new).not_to be_valid
    expect(Task.new(:name => "Complete me")).to be_valid
  end

  it "is not completed by default" do
    expect(Task.new.completed).to be_false
  end

  describe "#toggle_complete" do
    it "toggles false to true" do
      task = Task.new :name => "Spec Task Name", :backlog_item_id => 1, :completed => false
      task.toggle_complete

      expect(task.completed).to be_true
    end

    it "toggles true to false" do
      task = Task.new :name => "Spec Task Name", :backlog_item_id => 1, :completed => true
      task.toggle_complete

      expect(task.completed).to be_false
    end
  end
end
