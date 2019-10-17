FactoryBot.define do
  factory :post do
    sequence(:title){ |n| "Post #{n}" }
    sequence(:body) { |n| "Post Body #{n}" }
    author

    factory :post_with_comments do
      transient do
        comment_count { 5 }
      end

      after(:create) do |post, evaluator|
        create_list(:comment, evaluator.comment_count, post: post)
      end
    end

  end
end
