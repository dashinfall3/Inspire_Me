FactoryGirl.define do 

  factory :user do
    sequence(:username) { |n| "Username#{n}" }
    sequence(:email) { |n| "email#{n}@email.com" }
    password 'password'
  end

  factory :inspiration do
    sequence(:content) { |n| "Content #{n} more content!"}
  end

end
