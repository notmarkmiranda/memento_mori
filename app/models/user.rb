class User < ApplicationRecord
  validates :phone_number, presence: true, uniqueness: true

  before_create :set_confirmation_number

  def confirmable(number)
    return false unless confirmation_number == number
    confirm!
  end

  def confirm!
    update(confirmed: true)
  end

  private

  def set_confirmation_number
    self.confirmation_number = random_six_digit_string
  end

  def random_six_digit_string
    '%06d' % rand(10 ** 6)
  end
end
