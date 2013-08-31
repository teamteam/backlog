require 'spec_helper'

describe 'backlog_items/index' do
  let(:backlog_item) { mock_model(BacklogItem) }

  before :each do
    assign :backlog_items, [backlog_item]
  end

  it "has a link to remove the backlog item" do
    backlog_item.stub_chain(:tasks, :remaining, :empty?).and_return true

    render

    expect(rendered).to have_link "Remove item"
  end

  it "has a link to edit the backlog item" do
    backlog_item.stub_chain(:tasks, :remaining, :empty?).and_return true

    render

    expect(rendered).to have_link "Edit item"
  end

  context "with tasks" do
    context "with remaining tasks" do
      it "shows the remaining task count" do
        backlog_item.stub_chain(:tasks, :remaining, :count).and_return 10
        backlog_item.stub_chain(:tasks, :remaining, :empty?).and_return false

        render

        expect(rendered).to have_content 10
        expect(rendered).not_to have_selector 'i.icon-ok'
      end
    end

    context "without remaining tasks" do
      it "shows completed checkmark" do
        backlog_item.stub(:completed).and_return true
        backlog_item.stub_chain(:tasks, :remaining, :count).and_return 0
        backlog_item.stub_chain(:tasks, :remaining, :empty?).and_return true

        render

        expect(rendered).to have_selector 'i.icon-ok.completed'
      end
    end
  end

  context "without tasks" do
    it "should should a check mark" do
      backlog_item.stub(:name).and_return "Spec Backlog Item Name"
      backlog_item.stub_chain(:tasks, :remaining, :count).and_return 0
      backlog_item.stub_chain(:tasks, :remaining, :empty?).and_return true

      render

      expect(rendered).to have_selector 'i.icon-ok'
      expect(rendered).not_to have_text 0
    end
  end
end
