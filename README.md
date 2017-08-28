wahllokalfinder,cgn
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

## Adding Cities:
**An Example:** Go to RailsAdmin => cities => new

Name: `Köln`  
Zip:
`[
50667 ,50668 ,50670 ,50672 ,50674 ,50676 ,50677 ,50678 ,50679 ,50733 ,50735 ,50737 ,50739 ,50765 ,50767 ,50769 ,50823 ,50825 ,50827 ,50829 ,50858 ,50859 ,50931 ,50933 ,50935 ,50937 ,50939 ,50968 ,50969 ,50996 ,50997 ,50999 ,51061 ,51063 ,51065 ,51067 ,51069 ,51103 ,51105 ,51107 ,51109 ,51143 ,51145 ,51147 ,51149 ,51467
]
`  
State: `Nordrhein-Westfalen`  

This will be available from home page.
