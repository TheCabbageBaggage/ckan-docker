# How to use ckan-docker

#### First steps
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

#### Defining the enviroment variables
The volume names slightly differ from the original ones.

```
# Find the path to a named volume
docker volume inspect ckandocker_ckan_home | jq -c '.[] | .Mountpoint'
# "/var/lib/docker/volumes/docker_ckan_config/_data"

export VOL_CKAN_HOME=`docker volume inspect ckandocker_ckan_home | jq -r -c '.[] | .Mountpoint'`
echo $VOL_CKAN_HOME

export VOL_CKAN_CONFIG=`docker volume inspect ckandocker_ckan_home | jq -r -c '.[] | .Mountpoint'`
echo $VOL_CKAN_CONFIG

export VOL_CKAN_STORAGE=`docker volume inspect ckandocker_ckan_storage | jq -r -c '.[] | .Mountpoint'`
echo $VOL_CKAN_STORAGE

````

## ToDo
* Setting permissions during set uo
* adding a superuser during the initialisation -> userdata in external file

## Problems
#### Postgis

```postgis``` is complaining that a role ```postgres``` is not existing, even if no user is using this role. Despite that CKAN works fine.
```
UTC [58] FATAL:  role "postgres" does not exist
```
#### Creating a Public Dataset with a DOI
When creating a public dataset with an DOI this will lead to an ```internal server error```. The ckan doi extension runs into the follwing error.
```
file "/usr/lib/ckan/venv/src/ckanext-doi/ckanext/doi/lib.py", line 160, in build_metadata
ckan          |     if pkg_dict['license_id'] != 'notspecified':
ckan          | KeyError: 'license_id'

```

This documentation is based on [Installing CKAN with Docker Compose](https://docs.ckan.org/en/2.8/maintaining/installing/install-from-docker-compose.html)


