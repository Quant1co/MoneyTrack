require 'net/http'
require 'json'
require 'uri'

class CurrencyService
  BASE_URL = 'https://v6.exchangerate-api.com/v6/'

  def initialize(api_key)
    @api_key = api_key
  end

  # Метод для получения курсов валют относительно базовой валюты
  def get_exchange_rates(base_currency = 'USD')
    url = URI("#{BASE_URL}#{@api_key}/latest/#{base_currency}")
    response = Net::HTTP.get(url)
    data = JSON.parse(response)

    if data['result'] == 'success'
      # Извлекаем необходимые валюты
      rates = data['conversion_rates']
      {
        EUR: rates['EUR'],
        USD: rates['RUB'],
        CNY: rates['CNY']
      }
    else
      Rails.logger.error "Error fetching exchange rates: #{data['error-type']}"
      {}
    end
  rescue StandardError => e
    Rails.logger.error "Exception in get_exchange_rates: #{e.message}"
    {}
  end
end