# app/services/stock_price_service.rb
require 'net/http'
require 'json'
require 'uri'

class StockPriceService
  BASE_URL = 'https://finnhub.io/api/v1/'

  def initialize(api_key)
    @api_key = api_key
  end

  def get_popular_tickers(limit = 30)
    # Получаем список самых популярных тикеров (например, топ-30 по рыночной капитализации)
    url = URI("#{BASE_URL}stock/symbol?exchange=US&token=#{@api_key}")
    response = Net::HTTP.get(url)
    data = JSON.parse(response)

    # Ограничиваем количество тикеров до 30
    data.first(limit).map { |stock| stock["symbol"] }
  rescue StandardError => e
    Rails.logger.error "Error fetching popular tickers: #{e.message}"
    []
  end

  def fetch_price(ticker)
    # Получаем текущую цену для тикера
    url = URI("#{BASE_URL}quote?symbol=#{ticker}&token=#{@api_key}")
    response = Net::HTTP.get(url)
    data = JSON.parse(response)

    # Извлекаем цену
    data.dig("c") # Текущая цена
  rescue StandardError => e
    Rails.logger.error "Error fetching price for #{ticker}: #{e.message}"
    nil
  end
end