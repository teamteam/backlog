require 'spec_helper'

describe Task do
  it "requires a name" do
    expect(Task.new).not_to be_valid
    expect(Task.new(:name => "Complete me")).to be_valid
  end

  it "is not completed by default" do
    expect(Task.new.completed).to be_false
  end

  context "ordering" do
    it "is ordered by created_at" do
      task1 = Task.create :name => "first task", :created_at => DateTime.now
      task2 = Task.create :name => "second task", :created_at => DateTime.yesterday

      tasks = Task.all

      expect(tasks.count).to eq(2)
      expect(tasks.first).to eq(task2)
      expect(tasks.last).to eq(task1)
    end
  end

  describe "::remaining" do
    it "returns remaining tasks" do
      Task.create :name => "completed task", :completed => true
      task = Task.create :name => "not completed", :completed => false

      expect(Task.remaining.count).to eq(1)
      expect(Task.remaining.first).to eq(task)
    end
  end
end
