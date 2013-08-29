require 'spec_helper'

describe Task do
  it "requires a name" do
    expect(Task.new).not_to be_valid
    expect(Task.new(:name => "Complete me")).to be_valid
  end
end
