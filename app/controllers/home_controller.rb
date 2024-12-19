# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    advice_data = DataParserJob.new('https://journal.tinkoff.ru/flows/fin-advice/')
    advice_data.parse_advices
    advice = ParserToDb.new(advice_data.advices)
    advice.save_to_db
    @arr_advices = Advice.all


    api_key = 'cti2ophr01qm6mulvs80cti2ophr01qm6mulvs8g'

    service = StockPriceService.new(api_key)

    # Получаем тикеры популярных акций
    @tickers = service.get_popular_tickers

    @stocks = @tickers.map do |ticker|
      price = service.fetch_price(ticker)
      { ticker: ticker, price: price } if price
    end.compact

  end
end
