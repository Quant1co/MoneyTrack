# spec/helpers/parser_to_db_spec.rb
require 'rails_helper'

RSpec.describe ParserToDb do
  describe '#save_to_db' do
    it 'сохраняет советы в Advice, исключая дубликаты' do
      arr = ["Новый совет 1", "Новый совет 2", "Новый совет 1"]
      parser = ParserToDb.new(arr)

      expect { parser.save_to_db }.to change { Advice.count }.by(2)
      # "Новый совет 1" повторяется
      expect(Advice.last.content).to eq("Новый совет 2")
    end
  end
end
