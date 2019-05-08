FactoryBot.define do
  factory :user do
    phone_number { "3038476953" }

    trait :confirmed do
      confirmed { true }
    end

    trait :unconfirmed do
      confirmed { false }
    end
  end
end
