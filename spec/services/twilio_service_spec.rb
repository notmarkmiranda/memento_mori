require 'rails_helper'

describe TwilioService, type: :service do
  describe 'self#send_confirmation_message' do
    let(:user) { create(:user, :confirmed) }

    subject { described_class.send_confirmation_message(user) }
    let(:client) { double('twilio_client') }
    let(:messages) { double('twilio_messages') }
    let(:from) { '+15005550006' }

    before do
      allow(client).to receive(:messages).and_return(messages)
      allow(messages).to receive(:create).with(from: from, to: user.phone_number, body: "Your confirmation number is #{user.confirmation_number}.")
    end

    it 'should return a message object' do
      response = subject
      
      expect(response.api_version).to eq('2010-04-01')
      expect(response.direction).to eq('outbound-api')
      expect(response.to).to eq("+1#{user.phone_number}")
    end
  end
end
