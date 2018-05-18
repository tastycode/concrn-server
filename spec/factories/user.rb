FactoryBot.define do
end
FactoryBot.define do
  sequence :email do |n|
    "streetmom#{n}@concrn.org"
  end

  factory :user do
    email { generate(:email) }
    password "securepassword"
  end
end
