# spec/requests/sessions_request_spec.rb
require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "POST /login" do
    let!(:user) { User.create!(full_name: 'Ivan', email: 'ivan@example.com', phone: '8(999)999-9999', password: 'test1234') }

    context "с корректными данными" do
      it "логинит пользователя и редиректит" do
        post login_path, params: { email: 'ivan@example.com', password: 'test1234' }
        expect(response).to redirect_to(logined_path)
        follow_redirect!
        expect(response.body).to include("Добро пожаловать, Ivan!")
      end
    end

    context "с неправильным паролем" do
      it "возвращает ошибку и не логинит" do
        post login_path, params: { email: 'ivan@example.com', password: 'wrongpass' }
        expect(response).to have_http_status(:unprocessable_entity)
        # Или :unprocessable_entity, если вы так рендерите
        expect(response.body).to include("Неверный email или пароль")
      end
    end
  end

  describe "GET /logout" do
    it "разлогинивает и редиректит на /" do
      get logout_path
      expect(response).to redirect_to(home_path)
    end
  end
end

