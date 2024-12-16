# MoneyTrack

Сайт для отслеживания своих расходов и мониторинга валют

## Инструкции
Чтобы запустить проект локально нужно прописать в терминал следующее:    
*bundle install*  
*yarn install*  
*bundle exec rake db:create*  
*bundle exec rake db:migrate*  


Для запуска web-сервера и сборки клиента нужно выполнить:  
*foreman start -f Procfile.dev*  

Для сборки клиента без запуска сервера нужно выполнить:  
*foreman start -f Procfile.front*   


