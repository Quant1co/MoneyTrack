RSpec.describe CurrencyService do
    it do
        currency_service = CurrencyService.new "4308313cb49c9b275d52b3d0"
        puts currency_service.get_exchange_rates
    end
end