require "rails_helper"

describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of :phone_number }
    it { should validate_uniqueness_of :phone_number }
  end
  describe "relationships"

  describe "methods" do
    let(:user) { create(:user) }

    describe "#send_sms_with_token" do
      subject { user.send_sms_with_token }

      before { allow(TwilioService).to receive(:send_confirmation_message) }

      it "should call TwilioService" do
        subject

        expect(TwilioService).to have_received(:send_confirmation_message).with(user).once
      end
    end
  end
end
