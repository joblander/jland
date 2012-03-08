FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "foo#{n}@example.com" }
    password "something"
    password_digest "something"
  end

  factory :position do
    name "position_name"
    pstatus "to_apply"
    association :user, :factory => :user
  end

  factory :related_email do
    sequence(:guid) { |n| "aaa#{n}" }
    association :position, :factory => :position
  end
end