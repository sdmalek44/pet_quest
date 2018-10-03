# Pet Quest

PetQuest is a pet adoption app that allows you to search pets in your area by breed, size, age and gender. On each search page you can click to view a specific animal, their information, a map of the location of the shelter they are at, and a list of helpful books about training that particular breed of animal. I used the petfinder, google books, and mapbox apis. Google Oauth was used for authentication. Redis and sidekiq were used for a job that sends an email to subscribers once a week containing new pets near their location.  

Ruby Version: 2.4.3  
Rails Version: 5.1.6  
  
## Heroku  
https://pet-quest.herokuapp.com/  
  

## Setup  
  
```
$ bundle install
$ rake db:{drop,create,migrate}  
$ rails s (to start server) 
(go to localhost:3000 in browser)  
```  

## Testing  
* to successfully run all tests you will need to obtain 2 keys
  - oauth token from google https://developers.google.com/identity/protocols/OAuth2 
  - petfinder api key at https://www.petfinder.com/developers/api-key  
  
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
