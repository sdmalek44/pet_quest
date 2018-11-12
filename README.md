  
# Pet Quest  
  
PetQuest is a pet adoption app that allows you to search pets in your area by breed, size, age and gender. On each search page you can click to view a specific animal, their information, a map of the location of the animals shelter, and a list of helpful books about training that particular breed of animal. I utilized the petfinder, google books, and mapbox APIs. Google Oauth was used for authentication. Redis and sidekiq were used for a job that sends an email to subscribers once a week containing new pets near their location.  

Ruby Version: 2.4.3  
Rails Version: 5.1.6  
  
## Heroku  
https://pet-quest.herokuapp.com/  

## Home Page  
<img width="1532" alt="screen shot 2018-11-12 at 4 02 51 pm" src="https://user-images.githubusercontent.com/30483194/48380452-0862ac00-e695-11e8-98da-aa7c24e3c0b2.png">

## Dog Search Page  
<img width="1661" alt="screen shot 2018-11-12 at 3 46 23 pm" src="https://user-images.githubusercontent.com/30483194/48380458-0b5d9c80-e695-11e8-9828-5e2460766ca0.png">
  
## Cat Search Page
<img width="1597" alt="screen shot 2018-11-12 at 3 51 08 pm" src="https://user-images.githubusercontent.com/30483194/48380461-0e588d00-e695-11e8-998b-ebd1092029fe.png">
  
## Cat Show Page  
<img width="1590" alt="screen shot 2018-11-12 at 3 51 52 pm" src="https://user-images.githubusercontent.com/30483194/48380462-0ef12380-e695-11e8-8e8d-0d397b7b81be.png">  
 
## Cat Training Resources  
<img width="1193" alt="screen shot 2018-11-12 at 3 52 11 pm" src="https://user-images.githubusercontent.com/30483194/48380614-a6ef0d00-e695-11e8-8949-90c396e614f6.png">


  

## Setup  
  
```
$ bundle install
$ rake db:{drop,create,migrate}  
$ rails s (to start server) 
(go to localhost:3000 in browser)  
```  

## Testing  
* to successfully run all tests you will need to obtain the petfinder api key
  - sign up for an account and obtain key at https://www.petfinder.com/developers/api-key  
  
```
(do the following to create an application.yml file)
$ figaro install 

(put following in new config/application.yml file)
GOOGLE_TOKEN: <oauth token obtained from google>  
PET_FINDER_TOKEN: <api key obtained from petfinder>

(to run tests)
$ bundle exec rspec 
``` 

## Start Redis Server  
 ```
 $ redis-server  
 
 ``` 
 
 ## Run Sidekiq 

``` 
$ bundle exec sidekiq  
```  
