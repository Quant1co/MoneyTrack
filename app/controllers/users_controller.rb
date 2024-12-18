# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # После успешной регистрации перенаправляем на страницу входа
      redirect_to login_path, notice: "Регистрация успешно завершена!"
    else
      # Если валидации не прошли, отобразим форму заново с ошибками
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :phone, :password, :password_confirmation)
  end
end
