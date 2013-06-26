forum2discourse
===============

Exports various (initially PunBB) forum data to JSON ready to be imported into discourse

USAGE
=====

  Forum2Discourse::Exporter.new(:punbb, {options}).perform

Alternatively:

  forum2discourse --from punbb 
    --table-prefix myforum_         // optional, default nil
    --database <connection string>  // mandatory

connection string =
  
  sqlite:///path/to/project.db
  mysql://user:password@hostname/database
  postgres://user:password@hostname/database
