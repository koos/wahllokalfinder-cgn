wahllokalfinder-cgn
===================
## System Requirements:
- `Ruby 2.3.1`
- `PostgreSQL` Versions 9.1 and up are supported.
## Installation:
After cloning the repository, run:  
- ` $ bundle install `
- ` $ rails db:setup `
- ` $ rails import:stations `
- ` $ rails import:addresses `

  **NOTE:** Last 2 tasks may take a while until importing all records to Database.  
  **NOTE:** Check `/lib/tasks/importer` for loaded CSV files.
