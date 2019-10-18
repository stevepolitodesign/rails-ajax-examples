FactoryBot.define do
  factory :author do
    first_name { "Steve" }
    last_name { "Polito" }

    factory :author_with_posts do
      transient do
        post_count { 5 }
      end

      after(:create) do |author, evaluator|
        create_list(:post, evaluator.post_count, author: author)
      end
    end

  end
end
