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



### Сборка под linux:
1. Устанавливаем ruby on rails
2. Postgress. Для установки гема pg, нужен postgres Устанавливаем postgres: `sudo apt install postgresql postgresql-contrib` (Возможно придется ещё поставить `sudo apt install libpq-dev`)
3. Устанавливаем гемы-зависимости для этого проекта (их можно посмотерть с помощью команды bunlde list или в Gemfile) с помощью команды `bundle install` или `bundle install --gemfile /<Путь к вашему гемфайлу>/Gemfile`
4. Проводим миграцию бд. Для этого: 
    1. Создаем новую роль в постгресс `sudo -u postgres createuser --interactive`,
        Enter name of role to add: (Называем также как и ваше имя пользователя в linux. Например Egor)
        Shall the new role be a superuser? (y/n) Выбераем Y 
    2. Создаем навую бд `sudo -u postgres createdb (Название вашей роли. Например Egor)`

    3. Проводим миграцию бд `bundle exec rake db:create` и `bundle exec rake db:migrate`

5. Теперь мы можем собрать проект `rails s` 
6. В терминале появиться надпись Listening on http://127.0.0.1:3000 переходи по этому адресу. Если все норм, то вы увидите наш вебсайт
7. Если у вас отсутствуют файлы application.js их необходимо добавить в assets/builds/

### Запуск юнит тестов
Для запуска тестов необходимо 
1. Накатить миграцию в тестовую бд `rails db:migrate RAILS_ENV=test` 
2. Прописать `bundle install`
3. Вызвать тесты `rspec` 


