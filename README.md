# Just To Do 
* Ruby version -> 3.2.2
* Rails version -> 7.0.8

## In this project I use database:
* PostgreSQL, Hotwire Framework in addition to Ruby on Rails

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
  username: postgres   #your postgres' username
  password: root       #your postgres' password
  ...
```
4. Create database and migrate data:<br>
    ```$ rails db:create```<br>
    ```$ rails db:migrate```<br>
    Enter in your PostgreSQL database to see the database flux <br>
    The name database created was: `just_to_do2`
5. And Finally: <br>
  ```$ rails s```
