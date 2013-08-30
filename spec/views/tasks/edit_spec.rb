require 'spec_helper'

describe "tasks/edit" do
  it "has an edit task form" do
    render
    expect(rendered).to have_selector "form"
  end
end
