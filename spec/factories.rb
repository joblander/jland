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
end