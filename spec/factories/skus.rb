FactoryBot.define do
  factory :sku do
    spec { Faker::Name.name }
    quantity { Faker::Number.between(from: 10, to: 10) }

    product
  end
end
