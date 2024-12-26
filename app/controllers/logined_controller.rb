# frozen_string_literal: true


class LoginedController < ApplicationController

  before_action :require_login
  # app/controllers/logined_controller.rb
    # Отображение списка избранных акций пользователя
    def index
      @arr_advices = Advice.all
      $account = current_user.account
      @favorites = current_user.favorites
      $saving = current_user.saving || current_user.create_saving(title: "Новая копилка", target_amount: 1000, current_balance: 0)

      respond_to do |format|
        format.html
        format.json { render json: @favorites }
      end
    end

    #Добавление акции в избранное
    def create
      ticker = params[:ticker]
      stock = $stocks.find { |s| s[:ticker] == ticker }

      if stock.nil?
        render json: { success: false, message: "Акция #{ticker} не найдена." }, status: :not_found
        return
      end

      favorite = current_user.favorites.new(ticker: stock[:ticker], price: stock[:price])

      if favorite.save
        render json: { success: true, message: "#{stock[:ticker]} добавлена в избранное." }, status: :created
      else
        render json: { success: false, errors: favorite.errors.full_messages }, status: :unprocessable_entity
      end
    end


    # Удаление акции из избранного
    def destroy
      ticker = params[:ticker]
      favorite = current_user.favorites.find_by(ticker: ticker)

      if favorite&.destroy
        render json: { success: true, message: "#{ticker} удалена из избранного." }, status: :ok
      else
        render json: { success: false, message: "Не удалось удалить #{ticker} из избранного." }, status: :unprocessable_entity
      end
    end

    private

    # Метод для установки текущего пользователя (предполагается, что он уже определён)
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    # Метод для проверки аутентификации пользователя
    def require_login
      unless current_user
        redirect_to login_path, alert: 'Пожалуйста, войдите в систему.'
      end
    end
end