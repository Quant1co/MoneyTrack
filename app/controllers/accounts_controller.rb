class AccountsController < ApplicationController

  def index
    @account = current_user.account
    @transactions = @account.transactions.order(created_at: :desc)
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = current_user.account.transactions.build(transaction_params)
    if @transaction.save
      # Обновить баланс
      update_balance(@transaction)
      redirect_to accounts_path, notice: 'Transaction recorded successfully.'
    else
      render :new
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:name, :amount, :transaction_type)
  end

  def update_balance(transaction)
    if transaction.transaction_type == 'income'
      current_user.account.balance += transaction.amount
    elsif transaction.transaction_type == 'expense'
      current_user.account.balance -= transaction.amount
    end
    current_user.account.save
  end
end

