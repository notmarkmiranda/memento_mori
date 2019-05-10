class TwilioService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def self.send_confirmation_message(user)
    new(user).send_confirmation_message!
  end

  def send_confirmation_message!
    client.messages.create(
      from: ENV['twilio_phone_number'],
      to: user.phone_number,
      body: "Your confirmation number is #{user.confirmation_number}."
    )
  end

  private

  def client
    @client ||= Twilio::REST::Client.new(
      ENV['twilio_account_sid'],
      ENV['twilio_auth_token']
    )
  end
end
