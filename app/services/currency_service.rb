require 'net/http'
require 'json'
require 'uri'

class CurrencyService
  BASE_URL = 'https://v6.exchangerate-api.com/v6/'

  def initialize(api_key)
    @api_key = api_key
  end

  # Метод для получения курсов валют относительно базовой валюты RUB
  def get_exchange_rates(base_currency = 'RUB')
    url = URI("#{BASE_URL}#{@api_key}/latest/#{base_currency}")
    Rails.logger.info "Fetching exchange rates from URL: #{url}"
    response = Net::HTTP.get(url)
    Rails.logger.info "Received response: #{response}"
    data = JSON.parse(response)

    if data['result'] == 'success'
      rates = data['conversion_rates']
      Rails.logger.info "Fetched rates: #{rates}"
      {
        'USD' => rates['USD'].to_f,
        'EUR' => rates['EUR'].to_f,
        'CNY' => rates['CNY'].to_f,
        'TRY' => rates['TRY'].to_f,
        'KZT' => rates['KZT'].to_f
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
