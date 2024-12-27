# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'валидации' do
    it 'валиден при корректных данных' do
      user = User.new(
        full_name: 'Иван Иванов',
        email: 'ivan@example.com',
        phone: '89999999999',
        password: 'test1234'
      )
      expect(user).to be_valid
    end

    it 'невалиден без email' do
      user = User.new(
        full_name: 'Иван Иванов',
        phone: '89999999999',
        password: 'test1234'
      )
      expect(user).not_to be_valid
      # Можно детальнее: expect(user.errors[:email]).to include("не может быть пустым")
    end

    it 'невалиден при коротком пароле' do
      user = User.new(
        full_name: 'Иван Иванов',
        email: 'ivan@example.com',
        phone: '89999999999',
        password: 'abc' # слишком короткий
      )
      expect(user).not_to be_valid
    end
  end

  describe 'метод create_default_saving' do
    it 'создаёт saving после create' do
      user = User.create!(
        full_name: 'TestUser',
        email: 'test@example.com',
        phone: '89991234567',
        password: 'test1234'
      )
      # У модели User есть колбэк after_create :create_default_saving
      expect(user.saving).not_to be_nil
      expect(user.saving.title).to eq('Моя Копилка')
    end
  end
end
