# frozen_string_literal: true


class LoginedController < ApplicationController

  before_action :require_login

  def index
    # Здесь будет логика отображения данных для авторизованного пользователя
    $account = current_user.account
  end
end