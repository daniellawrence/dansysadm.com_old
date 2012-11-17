# simple nagios

A quick look at a read-only web view of nagios, called 'simple nagios'.

This was written to allow the viewing of nagios as simple as possible, and the customizing of the nagios views as simple as possible.

This has been achieved by splitting the generation of the data from the presentation of the data using Mk_livestatus to gather the data from nagios.
And by using flask's templates and twitters bootstrap to present the data to the end user.

The project can be found over on git-hub [daniellawrence/simplenagios](https://github.com/daniellawrence/simplenagios).

screen shots
------------

This is a refreshed approach to the Tactical Overview or the tac.cgi.

![TAC](https://raw.github.com/daniellawrence/simplenagios/master/screenshots/tac.png "TAC")
