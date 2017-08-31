wahllokalfinder,cgn
===================
## System Requirements:
- `Ruby 2.3.1`
- `PostgreSQL` Versions 9.1 and up.
## Installation:
After cloning the repository, run:  
- ` $ bundle install `
- ` $ rails db:setup `
- ` $ rails import:stations `
- ` $ rails import:addresses `  

  **NOTE:** Last task may take a while until importing all records to Database.  
  **NOTE:** It may be necessary to add city through  rails-admin (check bellow)
- Setting `ENV[ADMIN_USERNAME]` and `ENV[ADMIN_PASSWORD]` for RailsAdmin.

## Adding Cities:
### FILES
In order to add a new city to WAHLLOKALFINDER, there must be `Stations` and `Addresses` semicolon-separated CSV files, and thosee files must be structured as following:  

- **Addresses:** `zip;street;number_odd_from;number_odd_to;number_even_from;number_even_to;district_name;vote_district_id;landtag_election_district_id;local_election_district_id;bundestag_election_district_id`  

- **Stations:**
`vote_district_id;name;address_street;address_nr;address_nr_note;note;zip;full_address;phone;district;wheelchair_station`  

Both files should be moved to `docs/_CITY_/bundestagswahl-_YEAR_/` in order to get it accessible to `rake importer`.
- `_CITY_` is the name of city. EX: `koeln`
- `_YEAR_` is the bundestagswahl year. EX: `2017`

If the new files are structured as mentioned previously, and it has the correct CSV formats (semicolon-separated entries), then it can be imported to database through the following commands:
- ` $ rails import:stations `
- ` $ rails import:addresses `

Importer will ask for city and year to import.  
It may take a while until it completes.

### ENTRIES
After importing records from CSV files, as described previously, the city must be available from home page:

Go to RailsAdmin => cities => new

- Name: `Köln`  
- Slug: `koeln`  
- Zip:
```
[ 50667 ,50668 ,50670 ,50672 ,50674 ,50676 ,50677 ,50678 ,50679 ,50733 ,50735 ,50737 ,50739 ,50765 ,50767 ,50769 ,50823 ,50825 ,50827 ,50829 ,50858 ,50859 ,50931 ,50933 ,50935 ,50937 ,50939 ,50968 ,50969 ,50996 ,50997 ,50999 ,51061 ,51063 ,51065 ,51067 ,51069 ,51103 ,51105 ,51107 ,51109 ,51143 ,51145 ,51147 ,51149 ,51467 ]
```   
- State: `Nordrhein-Westfalen`  
- Coordinates: `6.9500000, 50.9333300`

**NOTE:** `Zip` and `Coordinates` for existed cities which are available in `docs/` are written inside `Wiki`
