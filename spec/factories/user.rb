FactoryGirl.define do

  factory :user do
    sequence(:name)     { |n| "Name #{n}"}
    sequence(:email)  { |n| "name#{n}@gmail.com" }
    sequence(:password) { |n| "password#{n}" }
  end

end