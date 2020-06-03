FactoryBot.define do
  factory :board do
    name { "MyString" }
    user { create :user }
  end
end
