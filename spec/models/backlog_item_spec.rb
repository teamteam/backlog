require 'spec_helper'

describe BacklogItem do
  fixtures :backlog_items

  describe "creation" do
    it "requires a name" do
      expect(BacklogItem.new).not_to be_valid

      expect(BacklogItem.new(:name => "something")).to be_valid
    end

    it "defaults archived to false" do
      expect(BacklogItem.new(:name => 'something').archived).to be_false
    end
  end

  describe "ordering" do
    it "order" do
      @item1 = backlog_items :first_item
      @item1.update_attribute :created_at, DateTime.now

      @item2 = backlog_items :second_item
      @item2.update_attribute :created_at, DateTime.yesterday

      items = BacklogItem.all
      expect(items.count).to eq(2)
      expect(items.first).to eq(@item2)
      expect(items.last).to eq(@item1)
    end
  end

  describe "::archived" do
    it "returns only archived items" do
      archived_item = BacklogItem.create :name => "something", :archived => true
      BacklogItem.create :name => "something else", :archived => false

      expect(BacklogItem.archived.count).to eq(1)
      expect(BacklogItem.archived.first).to eq(archived_item)
    end

    it "orders archived items by last update" do
      first_item = BacklogItem.create :name => "first item", :archived => true, :updated_at => DateTime.now
      second_item = BacklogItem.create :name => "second item", :archived => true, :updated_at => DateTime.yesterday

      expect(BacklogItem.archived.first).to eq(first_item)
      expect(BacklogItem.archived.last).to eq(second_item)
    end
  end

  describe "::this_week" do
    it "returns open items" do
      BacklogItem.delete_all
      BacklogItem.create :name => "something", :archived => true
      BacklogItem.create :name => "something else", :archived => false

      expect(BacklogItem.this_week.count).to eq(1)
    end
  end

  describe "#remaining_tasks" do
    it "returns remaining tasks" do
      backlog_item = BacklogItem.create :name => "something"
      backlog_item.tasks.should_receive(:remaining).and_return ["stub task"]

      expect(backlog_item.tasks.remaining.empty?).to be_false
    end
  end
end
