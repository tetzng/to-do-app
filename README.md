# ToDoApp

## Description

シンプルなタスク管理アプリ

## Requirement

- Ruby 2.7+
- Rails 6.0+

## Installation

```sh
$ git clone https://github.com/tetzng/to-do-app.git
$ cd to-do-app
$ bundle install
$ rails db:create db:migrate
```

## Deploy

```sh
$ heroku login
$ heroku create app_name
$ git push heroku master
$ heroku run rails db:migrate
```

## DB

|Task||
|---|--|
|name|string|
|description|string|
|status|integer|
|deadline|datetime|
|priority|integer|
|user_id|integer|

|Label||
|--|--|
|name|string|

|TaskLabel||
|--|--|
|task_id|integer|
|label_id|integer|

|User||
|--|--|
|name|string|
|email|string|
|password|string|
