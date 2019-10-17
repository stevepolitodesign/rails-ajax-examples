FactoryBot.define do
  factory :comment do
    sequence(:body) { |n| "Comment #{n}" }
    post
  end
end
