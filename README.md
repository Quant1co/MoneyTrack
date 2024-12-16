# MoneyTrack

Сайт для отслеживания своих расходов и мониторинга валют

## Инструкции
Чтобы запустить проект локально нужно прописать в терминал следующее:
/*bash*/
bundle install
yarn install
bundle exec rake db:create
bundle exec rake db:migrate


Для запуска web-сервера и сборки клиента нужно выполнить:
/*bash*/
foreman start -f Procfile.dev

Для сборки клиента без запуска сервера нужно выполнить:
/*bash*/
foreman start -f Procfile.front 


