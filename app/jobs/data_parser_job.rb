require 'httparty'
require 'nokogiri'

class DataParserJob < ApplicationJob

    def initialize(url)
      @url = url
      @advice_array = [] # Массив для хранения советов
    end

    def parse_advices
      response = HTTParty.get(@url)
      if response.code == 200
        document = Nokogiri::HTML(response.body)
        document.css('a._link_1dwdg_38').each do |paragraph|
          @advice_array << paragraph.text # Извлечение текста
        end
      else
        puts "Ошибка загрузки страницы: #{response.code}"
      end
    end

    def advices
      @advice_array
    end
end

