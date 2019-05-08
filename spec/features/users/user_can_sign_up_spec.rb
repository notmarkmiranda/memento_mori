require 'rails_helper'

describe 'sign up and confirm flow', type: :feature do
  describe 'as a visitor' do
    it 'allows a user to sign up' do
      visit sign_up_path

      fill_in 'Phone Number', with: '3038476953'
      click_button 'Sign Up!'

      expect(page).to have_content('Enter Confirmation Code!')
    end
  end


  describe 'after creating, but before confirming' do
    let(:user) { create(:user, :unconfirmed) }
    it 'allows a user to confirm themselves' do
      visit confirm_user_path(user)

      fill_in 'Enter Confirmation Code!', with: user.confirmation_number
      click_button 'Confirm My Account!'

      expect(page).to have_content('You have confirmed your account!')
    end
  end
end
