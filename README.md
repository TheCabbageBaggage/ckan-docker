# How to use ckan-docker
```
git clone https://github.com/TheCabbageBaggage/ckan-docker.git
#or
git clone git@github.com:TheCabbageBaggage/ckan-docker.git
```

To use your configuartions copy your ```production.ini``` and ```env``` file into the newly created folder, or modify the existing ones. After starting ckan-docker with

```
docker-compose up
```
you have to run run 
```
docker exec ckan /usr/local/bin/ckan-paster --plugin=ckan datastore set-permissions -c /etc/ckan/production.ini | docker exec -i db psql -U ckan
```
to set all necessary permissions. After this step you can add a superuser with:
```
docker exec -it ckan /usr/local/bin/ckan-paster --plugin=ckan sysadmin -c /etc/ckan/production.ini add johndoe
```

### ToDo
* Setting permissions during set uo
* adding a superuser during the initialisation -> userdata in external file

### Problems
```postgis``` si complaining that a role ```postgres``` is not existing, even if no user is using this role. Despite that CKAN works fine.
```
UTC [58] FATAL:  role "postgres" does not exist
```
