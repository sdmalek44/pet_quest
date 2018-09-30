# Pet Quest

PetQuest is a pet adoption app that allows you to search pets in your area by breed, size, age and gender. On each search page you can click to view a specific animal, their information, a map of the location of the shelter they are at, and a list of helpful books about training that particular breed of animal. I used the petfinder, google books, and mapbox apis. Google Oauth was used for authentication. Redis and sidekiq were used for a job that sends an email to subscribers once a week containing new pets near their location.  

Ruby Version: 2.4.3  
Rails Version: 5.1.6  
  
  
## Setup  
  
```
$ bundle install
$ rake db:{drop,create,migrate}  
$ rails s (to start server) 
(go to localhost:3000 in browser)  
```

## Run Test Suite  

``` 
$ rspec 

or 

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
