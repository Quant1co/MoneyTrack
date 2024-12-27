# spec/jobs/data_parser_job_spec.rb
require 'rails_helper'

RSpec.describe DataParserJob, type: :job do
  describe '#parse_advices' do
    let(:job_instance) { DataParserJob.new('https://journal.tinkoff.ru/flows/fin-advice/') }

    context 'когда загрузка страницы OK' do
      before do
        stub_request(:get, %r{tinkoff\.ru/flows/fin-advice})
          .to_return(
            status: 200,
            body: <<~HTML
              <html>
                <body>
                  <a class="_link_1dwdg_38">Совет 1</a>
                  <a class="_link_1dwdg_38">Совет 2</a>
                </body>
              </html>
            HTML
        )
      end

      it 'парсит и сохраняет советы в @advice_array' do
        job_instance.parse_advices
        expect(job_instance.advices).to eq(["Совет 1", "Совет 2"])
      end
    end

    context 'когда http-ответ не 200' do
      before do
        stub_request(:get, %r{tinkoff\.ru/flows/fin-advice})
          .to_return(status: 404, body: '')
      end

      it 'выводит ошибку и ничего не парсит' do
        expect { job_instance.parse_advices }.to output(/Ошибка загрузки страницы: 404/).to_stdout
        expect(job_instance.advices).to eq([])
      end
    end
  end
end
