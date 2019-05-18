class User < ApplicationRecord
  validates :phone_number, presence: true, uniqueness: true

  before_create :set_confirmation_number_and_expiration

  def confirmable(number)
    return false unless confirmation_still_current? && confirmation_numbers_match?(number)
    confirm!
  end

  def confirm!
    update(confirmed: true)
  end

  def send_sms_with_token
    TwilioService.send_confirmation_message(self)
  end

  private

  def calculate_expiration
    Time.now + 30.minutes
  end

  def confirmation_still_current?
    Time.current < confirmation_expiration
  end

  def confirmation_numbers_match?(number)
    confirmation_number == number
  end

  def random_six_digit_string
    "%06d" % rand(10**6)
  end

  def set_confirmation_number_and_expiration
    self.confirmation_number = random_six_digit_string
    self.confirmation_expiration = calculate_expiration
  end
end
