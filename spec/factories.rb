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

  factory :simply_hired_search_results, :class => :open_struct do
    title 'title'
    url 'http://jobsite.com'
    description 'job description'
    post_date '12/12/2011'
    source 'some company'
    city 'pittsburgh'
    state 'pa'
    country 'US'
  end
end