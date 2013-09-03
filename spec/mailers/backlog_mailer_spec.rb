require 'spec_helper'

class TestMailer
  include BacklogMailer
end

describe BacklogMailer do
  describe "#recipients" do
    it "returns all users" do
      User.should_receive(:all).and_return [
        mock_model(User, :email => "teammate1@example.com"),
        mock_model(User, :email => "teammate2@example.com")
      ]

      expect(TestMailer.new.recipients).to eq "teammate1@example.com,teammate2@example.com"
    end
  end
end
