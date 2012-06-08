===========
Gemavatar
==========

About
-----

``Gemavatar`` is a ``Redmine`` plugin for replacing the gravatars (they must 
be enabled) with the jpeg pictures stored in the ldap that ``Redmine`` is 
configured to work with.

Installation
------------

hg clone this repository while being inside the redmine /vendor/plugins 
directory(It must be done with the user that runs the server, so it has
the proper permissions):

    hg clone https://apuimedo@vgerndvud465.gemalto.com/hg/ldap_gemalto_avatar gemavatar

Add the necessary stuff to the database.

    rake db:migrate_plugins

Restart the server.

Checking that it works
----------------------

Just go to your user page, and your avatar should be visible there.
