# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new

  end

  def create
    # Находим пользователя по email
    user = User.find_by(email: params[:email])

    # Проверяем пароль методом authenticate
    if user && user.authenticate(params[:password])
      # Сохранить id пользователя в сессии, чтобы помнить, кто вошёл
      session[:user_id] = user.id
      redirect_to logined_path, notice: "Добро пожаловать, #{user.full_name}!"
    else
      # Если данные неверны, рендерим форму снова с сообщением об ошибке
      flash.now[:alert] = "Неверный email или пароль"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # Выход из аккаунта
    session[:user_id] = nil
    redirect_to home_path, notice: "Вы успешно вышли из аккаунта."
  end
end
