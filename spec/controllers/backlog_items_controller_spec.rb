require 'spec_helper'

describe BacklogItemsController do
  describe "#index" do
    it "assigns backlog_items" do
      expected_value = "BacklogItem.all return value"
      BacklogItem.should_receive(:all).and_return expected_value

      get :index

      expect(assigns :backlog_items).to eq(expected_value)
    end
  end
end
