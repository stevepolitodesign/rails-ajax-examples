FactoryBot.define do
  factory :post do
    title { "My Post" }
    body { "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis. Suspendisse urna nibh, viverra non, semper suscipit, posuere a, pede." }
    author
  end
end
