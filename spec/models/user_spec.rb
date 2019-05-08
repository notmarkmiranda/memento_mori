require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :phone_number }
    it { should validate_uniqueness_of :phone_number }
    
  end
  describe 'relationships'
  describe 'methods'
end
