# spec/requests/logined_request_spec.rb
require 'rails_helper'

RSpec.describe "LoginedController", type: :request do
  let!(:user) do
    User.create!(full_name: 'LoginedUser',
                 email: 'login@example.com',
                 phone: '8(999)123-4567',
                 password: 'pass1234')
  end

  describe "GET /logined" do
    context "когда пользователь залогинен" do
      before do
        # устанавливаем user_id в сессии
        post login_path, params: { email: user.email, password: 'pass1234' }
      end

      it "открывает страницу логина" do
        get logined_path
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Популярные акции")
      end
    end

    context "когда пользователь не залогинен" do
      it "редиректит на /login" do
        get logined_path
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "POST /logined" do
    # добавление акции в избранное
    let!(:stock_ticker) { 'AAPL' }

    before do
      # логинимся
      post login_path, params: { email: user.email, password: 'pass1234' }
    end

    it "добавляет акцию в избранное" do
      post logined_path, params: { ticker: stock_ticker }
      expect(response).to have_http_status(:created)
      expect(Favorite.last.ticker).to eq(stock_ticker)
    end
  end

  describe "DELETE /logined" do
    let!(:fav) { Favorite.create!(ticker: 'TSLA', price: 1000, user: user) }

    before do
      post login_path, params: { email: user.email, password: 'pass1234' }
    end

    it "удаляет акцию из избранного" do
      delete logined_path, params: { ticker: 'TSLA' }
      expect(response).to have_http_status(:ok)
      expect(Favorite.find_by(ticker: 'TSLA')).to be_nil
    end
  end
end

