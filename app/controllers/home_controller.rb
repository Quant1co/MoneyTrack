# frozen_string_literal: true

class HomeController < ApplicationController
  def index

    if current_user
      redirect_to logined_path
    end

    advice_data = DataParserJob.new('https://journal.tinkoff.ru/flows/fin-advice/')
    advice_data.parse_advices
    advice = ParserToDb.new(advice_data.advices)
    advice.save_to_db
    $arr_advices = Advice.all


    api_key = 'cti2ophr01qm6mulvs80cti2ophr01qm6mulvs8g'

    service = StockPriceService.new(api_key)

    #Получаем тикеры популярных акций
    #@tickers = service.get_popular_tickers

    tickers = ['AAPL', 'MSFT', 'AMZN', 'TSLA', 'GOOG', 'META', 'NVDA', 'BRK.A', 'JNJ', 'JPM', 'V', 'PG', 'WMT', 'HD', 'KO']
    $stocks = tickers.map do |ticker|
    price = service.fetch_price(ticker)
    { ticker: ticker, price: price } if price
    end.compact


    api_key = '4308313cb49c9b275d52b3d0' # Замените на ваш API-ключ
    service = CurrencyService.new(api_key)

    # Получаем курсы валют относительно USD
    $rates = service.get_exchange_rates

  end
end
