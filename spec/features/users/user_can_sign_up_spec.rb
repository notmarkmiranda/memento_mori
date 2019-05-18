require "rails_helper"

describe "sign up and confirm flow", type: :feature do
  describe "as a visitor" do
    it "allows a user to sign up" do
      visit sign_up_path

      fill_in "Phone Number", with: "3038476953"
      click_button "Sign Up!"

      expect(page).to have_content("Enter Confirmation Code!")
    end

    describe "if the number is already taken" do
      let(:user) { create(:user, :unconfirmed) }

      it "does not allow a user to sign up" do
        visit sign_up_path

        fill_in "Phone Number", with: user.phone_number
        click_button "Sign Up!"

        expect(page).to have_content("Phone Number")
      end
    end
  end

  describe "after creating, but before confirming" do
    let(:user) { create(:user, :unconfirmed, confirmation_expiration: Time.now) }

    describe "with the correct confirmation number" do
      it "allows a user to confirm themselves" do
        visit confirm_user_path(user)

        fill_in "Enter Confirmation Code!", with: user.confirmation_number
        click_button "Confirm My Account!"

        expect(page).to have_content("You have confirmed your account!")
      end
    end

    describe "with the incorrect confirmation number" do
      it "does not allow a user to confirm" do
        visit confirm_user_path(user)

        fill_in "Enter Confirmation Code!", with: "asdf"
        click_button "Confirm My Account!"

        expect(page).to have_content("Enter Confirmation Code!")
        expect(page).not_to have_content("You have confirmed your account!")
      end
    end

    describe "with an expired confirmation number" do
      it "does not allow a user to confirm" do
        user
        travel 31.minutes do
          visit confirm_user_path(user)

          fill_in "Enter Confirmation Code!", with: user.confirmation_number
          click_button "Confirm My Account!"

          expect(page).to have_content("Enter Confirmation Code!")
          expect(page).not_to have_content("You have confirmed your account!")
        end
      end
    end
  end
end
