# spec/models/saving_spec.rb
require 'rails_helper'

RSpec.describe Saving, type: :model do
  describe 'валидации' do
    it 'валиден при корректных данных' do
      saving = Saving.new(
        title: 'Моя копилка',
        target_amount: 1000.0,
        current_balance: 0.0,
        user: User.create!(
          full_name: 'TestUser',
          email: 'test@example.com',
          phone: '89991234567',
          password: 'test1234'
        )
      )
      expect(saving).to be_valid
    end

    it 'невалиден без title' do
      saving = Saving.new(
        target_amount: 1000.0,
        current_balance: 0.0
      )
      expect(saving).not_to be_valid
    end
  end

  describe 'методы deposit/withdraw' do
    let(:user) { User.create!(full_name: 'TestUser', email: 'test2@example.com', phone: '89991234567', password: 'test1234') }
    let(:saving) { Saving.create!(title: 'TestGoal', target_amount: 1000, current_balance: 100, user: user) }

    it 'успешно депозит' do
      saving.deposit(50)
      expect(saving.current_balance).to eq(150)
    end

    it 'ошибка при депозите с отрицательной суммой' do
      expect { saving.deposit(-20) }.to raise_error(ArgumentError, 'Сумма должна быть больше 0')
    end

    it 'успешно снимает средства' do
      saving.withdraw(50)
      expect(saving.current_balance).to eq(50)
    end

    it 'ошибка при снятии с недостаточным балансом' do
      expect { saving.withdraw(200) }.to raise_error(ArgumentError, 'Недостаточно средств')
    end
  end
end
