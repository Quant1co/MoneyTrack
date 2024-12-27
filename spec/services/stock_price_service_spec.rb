# spec/services/stock_price_service_spec.rb
require 'rails_helper'

RSpec.describe StockPriceService do
  let(:api_key) { 'dummy_api_key' }
  let(:service) { described_class.new(api_key) }

  describe '#fetch_price' do
    context 'когда ответ успешный' do
      before do
        stub_request(:get, %r{https://finnhub\.io/api/v1/quote\?symbol=TSLA.*})
          .to_return(
            status: 200,
            body: { c: 750.50 }.to_json, # c = current price
            headers: { 'Content-Type' => 'application/json' }
          )
      end

      it 'возвращает текущую цену' do
        price = service.fetch_price('TSLA')
        expect(price).to eq(750.50)
      end
    end

    context 'когда произошла ошибка JSON' do
      before do
        stub_request(:get, %r{https://finnhub\.io/api/v1/quote.*})
          .to_return(status: 200, body: "not-valid-json")
      end

      it 'возвращает nil и пишет лог' do
        expect(Rails.logger).to receive(:error).with(/Error fetching price for TSLA/)
        price = service.fetch_price('TSLA')
        expect(price).to be_nil
      end
    end
  end
end
