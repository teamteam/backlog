require 'toggleable'

class DummyToggleableModel
  include Toggleable
end

describe DummyToggleableModel do
  let(:dummy) { DummyToggleableModel.new }

  it "toggles false to true" do
    dummy.stub(:completed).and_return false
    dummy.should_receive(:update_attribute).with(:completed, true)

    dummy.toggle_completed
  end

  it "toggles true to false" do
    dummy.stub(:completed).and_return true
    dummy.should_receive(:update_attribute).with(:completed, false)

    dummy.toggle_completed
  end

  it "raises error when attribute doesn't exist" do
    expect{dummy.toggle_completed}.to raise_error(NoMethodError)
  end
end
