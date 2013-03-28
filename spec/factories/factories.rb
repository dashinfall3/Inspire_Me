FactoryGirl.define do 

  factory :user, :aliases => [:creator, :voter] do
    sequence(:username) { |n| "Username#{n}" }
    sequence(:email) { |n| "e#{rand(100)}mail#{n}@ema#{rand(100)}il.com" }
    password 'password'
    admin true
  end

  factory :inspiration do
    sequence(:content) { |n| "Content #{n} more #{rand(999)}content!"}
    status 0
    creator
  end

  factory :photo do
    sequence(:caption) { |n| "Caption#{n}" }
    inspiration
    user
  end

  factory :vote do
    voter
    photo
  end

end
