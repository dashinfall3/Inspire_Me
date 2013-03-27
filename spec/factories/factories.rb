FactoryGirl.define do 

  factory :user, :aliases => [:creator] do
    sequence(:username) { |n| "Username#{n}" }
    sequence(:email) { |n| "e#{rand(100)}mail#{n}@ema#{rand(100)}il.com" }
    password 'password'
    admin true
  end

  factory :inspiration do
    sequence(:content) { |n| "Content #{n} more content!"}
    status 0
    creator
  end

  factory :photo do
    sequence(:caption) { |n| "Caption#{n}" }
    inspiration
    user
  end

end
