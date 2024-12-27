FactoryBot.define do
  factory :user do
    full_name { "Иван Петров" }
    email { "test@example.com" }
    phone { "8(999)999-9999" }
    password { "testpass123" }
  end
end