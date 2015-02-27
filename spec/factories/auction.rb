FactoryGirl.define do

  factory :auction do
    sequence(:name)     { |n| "Name for auction #{n}"}
    sequence(:details)  { |n| "Details for auction #{n}" }
    end_date            DateTime.current + 3.days
    reserve_price       50
  end

end