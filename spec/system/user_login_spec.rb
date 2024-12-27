# spec/system/user_login_spec.rb
require 'rails_helper'

RSpec.describe "Логин пользователя", type: :system do
  let!(:user) { User.create!(full_name: 'Ivan', email: 'ivan@example.com', phone: '89999999999', password: 'test1234') }

  it "заходит на /logined после корректного логина" do
    visit login_path
    fill_in "Email", with: "ivan@example.com"
    fill_in "Пароль", with: "test1234"
    click_button "Войти"

    expect(page).to have_content("Добро пожаловать, Ivan!")
    expect(current_path).to eq(logined_path)
  end
end
