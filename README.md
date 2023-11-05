# Just To Do 
* Ruby version -> 3.2.2
* Rails version -> 7.0.8

## In this project I use database:
* PostgreSQL and PgAdmin4

## For execute this project:
1. Clone this repository or download it:<br>
    ```$ git clone https://github.com/DennisGabriel-Dev/JustToDo.git```

2. Enter the repository cloned and run bundle:<br>
    ```
    $ cd JustToDo
    $ bundle    
   ```
4. Enter in config/database.yml and configure with in your credentials
only change this fields: <br>
```
default: &default
  ...
  username: dennis   #your postgres' username
  password: root       #your postgres' password
  ...
```
4. Create database and migrate data:<br>
    ```$ rake db:create```<br>
    ```$ rake db:migrate```<br>
    Enter in your PgAdmin4 to see the database flux <br>
    The name database created was: `just_to_do2`
5. And Finally: <br>
  ```$ rails s```
