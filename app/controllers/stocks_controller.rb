class StocksController < ApplicationController

  def data
    api_key = 'cti2ophr01qm6mulvs80cti2ophr01qm6mulvs8g'

    service = StockPriceService.new(api_key)

    #Получаем тикеры популярных акций
    @tickers = service.get_popular_tickers(15)

    #tickers = ['AAPL', 'MSFT', 'AMZN', 'TSLA', 'GOOG', 'META', 'NVDA', 'BRK.A', 'JNJ', 'JPM', 'V', 'PG', 'WMT', 'HD', 'KO']

    $stocks = @tickers.map do |ticker|
      price = service.fetch_price(ticker)
      { ticker: ticker, price: price } if price
    end.compact
    render json: $stocks
  end
end
