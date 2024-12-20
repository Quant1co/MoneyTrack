# app/services/stock_price_service.rb
require 'net/http'
require 'json'
require 'uri'

class StockPriceService
  BASE_URL = 'https://finnhub.io/api/v1/'

  def initialize(api_key)
    @api_key = api_key
  end

  # def get_popular_tickers(limit = 10)
  #   # Получаем список самых популярных тикеров
  #   url = URI("#{BASE_URL}stock/symbol?exchange=US&token=#{@api_key}")
  #   response = Net::HTTP.get(url)
  #   data = JSON.parse(response)
  #   data.first(limit).map { |stock| stock["symbol"] }
  # rescue StandardError => e
  #   Rails.logger.error "Error fetching tickers: #{e.message}"
  #   []
  # end

  def fetch_price(ticker)
    # Получаем текущую цену для тикера
    #tickers = ['AAPL', 'MSFT', 'AMZN', 'TSLA', 'GOOG', 'META', 'NVDA', 'BRK.A', 'JNJ', 'JPM', 'V', 'PG', 'WMT', 'HD', 'KO']

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