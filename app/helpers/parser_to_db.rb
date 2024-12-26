
class ParserToDb < DataParserJob

  def initialize(arr)
    @arr = arr
  end

  def save_to_db()
    @arr.each do |advice|
      # Создаём запись в базе данных только если её ещё нет
      Advice.find_or_create_by(content: advice[17..-1])
    end
  end
end