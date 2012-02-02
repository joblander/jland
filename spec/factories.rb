Factory.define :user do |f|
  f.sequence(:email) { |n| "foo#{n}@example.com" }
  f.password "something"
  f.password_digest "something"
end

Factory.define :position do |f|
  f.name "position_name"
  f.association :user, :factory => :user
end

