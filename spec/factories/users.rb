FactoryBot.define do
  factory :user do
    full_name { "Иван Петров" }
    email { "test@example.com" }
    phone { "89999999999" }
    password { "testpass123" }
  end
end