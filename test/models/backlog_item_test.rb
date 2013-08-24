require 'test_helper'

describe BacklogItem do
  it "requires name to be created" do
    backlog_item = BacklogItem.new

    assert backlog_item.invalid?
  end
end
