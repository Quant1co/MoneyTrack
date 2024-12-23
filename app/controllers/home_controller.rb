# frozen_string_literal: true

class HomeController < ApplicationController
  def index

    if current_user
      session[:user_id] = nil
    end

    # advice_data = DataParserJob.new('https://journal.tinkoff.ru/flows/fin-advice/')
    # advice_data.parse_advices
    # advice = ParserToDb.new(advice_data.advices)
    # advice.save_to_db
    $arr_advices = Advice.all


    api_key = '4308313cb49c9b275d52b3d0'
    service = CurrencyService.new(api_key)

    # Получаем курсы валют относительно USD
    #$rates = service.get_exchange_rates

  end

end
