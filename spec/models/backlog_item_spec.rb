require 'spec_helper'

describe BacklogItem do
  fixtures :backlog_items

  describe "creation" do
    it "requires a name" do
      BacklogItem.new.should_not be_valid

      BacklogItem.new(:name => "something").should be_valid
    end

    it "defaults archived to false" do
      BacklogItem.new(:name => 'something').archived.should be_false
    end

    it "defaults completed to false" do
      BacklogItem.new(:name => 'something').completed.should be_false
    end
  end

  describe "ordering" do
    it "order" do
      @item1 = backlog_items :first_item
      @item1.update_attribute :created_at, DateTime.now

      @item2 = backlog_items :second_item
      @item2.update_attribute :created_at, DateTime.yesterday

      items = BacklogItem.all
      items.count.should eq(2)
      items.first.should eq(@item2)
      items.last.should eq(@item1)
    end
  end

  describe "::archived" do
    it "returns only archived items" do
      archived_item = BacklogItem.create :name => "something", :archived => true
      BacklogItem.create :name => "something else", :archived => false

      BacklogItem.archived.count.should eq(1)
      BacklogItem.archived.first.should eq(archived_item)
    end
  end

  describe "::this_week" do
    it "returns open items" do
      BacklogItem.delete_all
      BacklogItem.create :name => "something", :archived => true
      BacklogItem.create :name => "something else", :archived => false

      BacklogItem.this_week.count.should eq(1)
    end
  end
end
