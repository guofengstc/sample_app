# FactoryGirl.define do
#   factory :user do
#     # name     "Michael Hartl"
#     # email    "michael@example.com"
#     sequence(:name)  { |n| "Person #{n}" }
#     sequence(:email) { |n| "person_#{n}@example.com"} 
#     password "foobar"
#     password_confirmation "foobar"

#   end

#   factory :admin do
#     admin true
# 	name     "Example User"
# 	email    "example@railstutorial.org"
#     password "foobar"
#     password_confirmation "foobar"
#   end
# end

FactoryGirl.define do
  factory :user do
    # name     "Michael Hartl"
    # email    "michael@example.com"
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"} 
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end

  end
end