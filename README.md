forum2discourse
===============

Imports from Vanilla or PunBB formats into a discourse instance.

USAGE
-----

1. Add forum2discourse gem to the discourse gemfile, and bundle install.
2. Export the F2D_CONNECTION_STRING environment variable to point at the PunBB
   or Vanilla database. This uses datamapper-style connection strings.
   (http://datamapper.org/getting-started.html) - for example:

```shell
$ export F2D_CONNECTION_STRING-mysql://root@127.0.0.1:3306/database_name
```

3. Run the relevant rake task within bundle exec

```shell
$ RAILS_ENV-production bundle exec rake forum2discourse:import_vanilla
$ RAILS_ENV-production bundle exec rake forum2discourse:import_punbb
```

NOTES
-----

In order for people to be able to use their existing user accounts, you will
need to manually reset each user's password; passwords/authentication methods
are not included.

EXTENDING
---------

To extend this library for another forum type:

1. Create 'lib/tasks/import_(type).rb' by copying existing.
2. Create 'lib/forum2discourse/models/(type)' to map the columns (see Vanilla models for an example)
    1. Each should respond to a to_discourse method that returns a
       Forum2Discourse::Models::Discourse::{Topic|Post|User|Category} instance
    2. Remember to define the relationships.
3. Create an exporter in 'lib/forum2discourse/exporters'.

COPYRIGHT
---------

Forum2Discourse is copyright (c) 2013 Initforthe Ltd (www.initforthe.com) and
Bytemark Hosting (www.bytemark.co.uk).

LICENSE
-------

GNU GPL v2. See LICENSE.txt
