wahllokalfinder,cgn
===================
## System Requirements:
- `Ruby 2.3.1`
- `PostgreSQL` Versions 9.1 and up.

## Installation:
After cloning the repository, run:  
- ` $ bundle install `
- ` $ rails db:setup `
- ` $ rails import:stations `*
- ` $ rails import:addresses `*  
- ` $ rails import:cities `*  

  **\*NOTE:** Rake tasks may take some time until they import all records to Database.  
  **\*NOTE:** It may be necessary to add data csv files. Check [CSV Data Files](#placing-csv-data-files)
- Setting `ENV[ADMIN_USERNAME]` and `ENV[ADMIN_PASSWORD]` for RailsAdmin.

## Adding Cities:
Each city has 3 set of information:  
- **City details** :  which defines city name, slug, zip and other information.
- **City Stations** :  which is the city vote districts.
- **City Addresses** :  which is the city streets and its relation to stations.

### City Details
You can add this details with rake task `$ rails import:cities`  
You may edit cities data-file which is located at `docs/cities.csv`. Check [CSV Data Files](#placing-csv-data-files) for more information.  

One of city details is `city_house_type` which specify city housing number system, there are multiple type could be set: `normal`, `odd_even`, `mixed_odd_even` or `horseshoe`.

### City Stations
You can add stations with rake task `$ rails import:stations`  
Stations file should be existed in `docs/`, and follow wahllokalefinder data-files conventions.
Check [CSV Data Files](#placing-csv-data-files) to be able to place the files.  

### City Addresses
You can add addresses with rake task `$ rails import:addresses`  
Addresses file should be existed in `docs/`, and follow wahllokalefinder data-files conventions.
Check [CSV Data Files](#placing-csv-data-files) to be able to place the files.  

**Notes**
- It is also possible to add and edit previous entries with RailsAdmin `http://website/admin`
- Importer will ask for city and year to import.  
- It may take a while until it completes.


## Rake Tasks:
Wahllokalfinder has `importer` and `validator` rake tasks which help managing files and data in efficient and easy way.  
### Importer

#### Addresses Importer
`$ rails import:addresses`  
It asks about the specified city and year, then extracts the csv file (which you select through the importer) and save records to database.

#### Stations Importer
`$ rails import:stations`   
It asks about the specified city and year, then extracts stations from the csv file and save records to database.

#### Cities Importer
`$ rails import:cities`   
It extracts the csv file (which you select through the importer) and save selected cities that are in the file to database records.
### Validator

#### City Address Zip:
`$ rails validator:city_address_zip` is the task where you select a specific addresses file and validates its zip codes that are related to addresses.

## Placing CSV Data Files
### Convention
#### Files location
`cities.csv` should be located in `docs/` so the importer is able to locate it.  
`Stations.csv` and `Addresses.csv` files, should be moved to `docs/_CITY_/bundestagswahl-_YEAR_/` in order to get it accessible to `rake importer`.  

`_CITY_` is the name of city. EX: `koeln`  
`_YEAR_` is the bundestagswahl year. EX: `2017`

#### Files Structure:
All files that are accessible through rake tasks are semicolon-separated CSV files, and data must be structured as following:  

- **Cities:**
```
name;slug;zip;state;coordinates;city_housing_type
```
  * city_housing_type: one of the values ['normal', 'odd_even', 'mixed_odd_even', 'horseshoe']
  * zip is comma separated string. (Ex: "14461, 14467, 14469")


- **Addresses:** the structure may be deferent depending on city house type.
  * odd_even house type:
  ```
  zip;street;number_odd_from;number_odd_to;number_even_from;number_even_to;district_name;vote_district_id;landtag_election_district_id;local_election_district_id;bundestag_election_district_id
  ```  
  * mixed_odd_even house type, `number_variety` takes values: ['odd', 'even', 'all']:
  ```
  zip;street;number_from;;number_to;;number_variety;district_name;vote_district_id;landtag_election_district_id;local_election_district_id;bundestag_election_district_id
  ```

- **Stations:**
`vote_district_id;name;address_street;address_nr;address_nr_note;note;zip;full_address;phone;district;wheelchair_station`


If the new files are structured as mentioned previously, and it has the correct CSV formats (semicolon-separated entries), then it can be imported to database through the following commands:
- ` $ rails import:stations `*
- ` $ rails import:addresses `*  
- ` $ rails import:cities `*  

It is also able to edit and add records through RailsAdmin `http://website/admin`
