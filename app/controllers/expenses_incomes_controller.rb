class ExpensesIncomesController < ApplicationController
  before_action :set_main_account

  def create
    @expense_income = @main_account.expenses_incomes.build(expense_income_params)

    if @expense_income.save
      redirect_to main_account_path(@main_account), notice: 'Операция успешно добавлена.'
    else
      render 'main_accounts/account'
    end
  end

  private

  def set_main_account
    @main_account = current_user.main_account
  end

  def expense_income_params
    params.require(:expense_income).permit(:description, :sum, :operation_type)
  end
end
