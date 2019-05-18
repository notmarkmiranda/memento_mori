require "rails_helper"

describe TwilioService, type: :service do
  describe "self#send_confirmation_message" do
    let(:user) { create(:user, :confirmed) }

    subject { described_class.send_confirmation_message(user) }
    let(:client) { double("twilio_client") }
    let(:messages) { double("twilio_messages") }
    let(:from) { "+15005550006" }
    let(:create_args) do
      {
        from: from,
        to: user.phone_number,
        body: "Your confirmation number is #{user.confirmation_number}.",
      }
    end
    let(:response) { double("response") }

    before do
      allow_any_instance_of(TwilioService).to receive(:client).and_return(client)
      allow(client).to receive(:messages).and_return(messages)
      allow(messages).to receive(:create)
        .with(create_args)
        .and_return(double)
    end

    it "should return a message object" do
      subject

      expect(messages).to have_received(:create).with(create_args).once
    end
  end
end
