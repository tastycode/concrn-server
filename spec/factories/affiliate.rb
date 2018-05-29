FactoryBot.define do
  sequence :affiliate_name do |n|
    "Las Vegas Rangers #{n}"
  end

  factory :affiliate do
    name { generate(:affiliate_name) }
  end
end
