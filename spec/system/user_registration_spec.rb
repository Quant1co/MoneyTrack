# spec/system/user_registration_spec.rb
require 'rails_helper'

RSpec.describe "Регистрация пользователя", type: :system do
  it "Успешная регистрация" do
    # 1. Открываем страницу регистрации
    visit register_path

    # 2. Заполняем поля
    fill_in "Полное имя", with: "Тестовый Пользователь"
    fill_in "Email", with: "tester@example.com"
    fill_in "Номер телефона", with: "89991112233"
    fill_in "Пароль", with: "password123"
    fill_in "Подтверждение пароля", with: "password123"

    # 3. Нажимаем кнопку
    click_button "Зарегистрироваться"

    # 4. Проверяем, что редиректнуло на login или отобразилась надпись
    expect(page).to have_content("Регистрация успешно завершена!")
    expect(current_path).to eq(login_path) # например
  end

  it "Ошибка при некорректном пароле" do
    visit register_path
    fill_in "Пароль", with: "12"
    fill_in "Подтверждение пароля", with: "12"
    click_button "Зарегистрироваться"

    # Предположим, отобразится ошибка
    expect(page).to have_content("Пароль не соответствует требованиям")
  end
end
