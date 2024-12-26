class SavingsController < ApplicationController
  before_action :set_saving, only: [:show, :update, :deposit, :withdraw]

  def show
    # Если у пользователя нет копилки, создаем её.
    #
    $saving = Saving.find_by(user_id: current_user.id)

    # Если у пользователя нет копилки, создаем её
    if $saving.nil?
      $saving = Saving.create(user_id: current_user.id, title: "Новая копилка", current_balance: 0, target_amount: 1000)
    end
    end

  def update
    if $saving.update(saving_params)
      redirect_to saving_path($saving), notice: 'Копилка обновлена.'
    else
      render :show
    end
  end

  def deposit
    amount = params[:amount].to_f

    if amount > 0
      $saving.current_balance += amount
      $saving.save
      redirect_to saving_path($saving), notice: "Добавлено #{amount} ₽."
    else
      redirect_to saving_path($saving), alert: 'Введите корректную сумму.'
    end
  end

  def withdraw
    amount = params[:amount].to_f

    if amount > 0 && $saving.current_balance >= amount
      $saving.current_balance -= amount
      $saving.save
      redirect_to saving_path($saving), notice: "Снято #{amount} ₽."
    else
      redirect_to saving_path($saving), alert: 'Недостаточно средств или некорректная сумма.'
    end
  end

  private

  def set_saving
    $saving = current_user.saving || current_user.create_saving(title: "Новая копилка", target_amount: 0, current_balance: 0)
  end

  def saving_params
    params.require(:saving).permit(:title, :target_amount)
  end
  end


