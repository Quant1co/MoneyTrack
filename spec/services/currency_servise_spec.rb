# spec/services/currency_service_spec.rb
require 'rails_helper'

RSpec.describe CurrencyService do
  let(:api_key) { 'dummy_api_key' }
  let(:service) { described_class.new(api_key) }

  describe '#get_exchange_rates' do
    context 'когда ответ успешный' do
      before do
        # Подделываем URL и возвращаем JSON
        stub_request(:get, %r{https://v6\.exchangerate-api\.com/v6/.*/latest/RUB})
          .to_return(
            status: 200,
            body: {
              result: 'success',
              conversion_rates: {
                'USD' => 0.0123,
                'EUR' => 0.0114,
                'CNY' => 0.08,
                'TRY' => 0.14,
                'KZT' => 5.78
              }
            }.to_json,
            headers: { 'Content-Type' => 'application/json' }
          )
      end

      it 'возвращает нужные курсы' do
        result = service.get_exchange_rates('RUB')
        expect(result).to eq(
                            'USD' => 0.0123,
                            'EUR' => 0.0114,
                            'CNY' => 0.08,
                            'TRY' => 0.14,
                            'KZT' => 5.78
                          )
      end
    end

    context 'когда ответ содержит ошибку' do
      before do
        stub_request(:get, %r{https://v6\.exchangerate-api\.com/v6/.*/latest/RUB})
          .to_return(
            status: 200,
            body: {
              result: 'error',
              'error-type': 'invalid-key'
            }.to_json,
            headers: { 'Content-Type' => 'application/json' }
          )
      end

      it 'возвращает пустой хэш' do
        result = service.get_exchange_rates('RUB')
        expect(result).to eq({})
      end
    end

    context 'когда произошла сетевая ошибка' do
      before do
        stub_request(:get, %r{https://v6\.exchangerate-api\.com/})
          .to_raise(SocketError.new('Failed to open TCP connection'))
      end

      it 'возвращает пустой хэш и пишет лог' do
        expect(Rails.logger).to receive(:error).with(/Exception in get_exchange_rates/)
        result = service.get_exchange_rates('RUB')
        expect(result).to eq({})
      end
    end
  end
end
