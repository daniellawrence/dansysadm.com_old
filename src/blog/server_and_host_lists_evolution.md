# server and host lists evolution

Every place that I have worked at has had a centralized list of all the servers that they look after ( well all they know of ).

These lists have taken many on many forms and there might be something in the __age/matueatlty__ of the organizations hosting environment.


In our heads
------------

The first place that I worked at was using the "In our heads" method of listing the servers. 
There was only 2 so it was very easy to memorize. Then even had nice English names, so that made it even easier.
The was no point at adding any more complexity to the listing system, as any new staff memory would simply be told that the 2 hosts are "bob" and "john".

The Excel spreadsheet v0.1
--------------------------

The second place that I had the opportunity to work at had the "Excel spreadsheet" method of listing servers.
However it did extend past just a list of the 50-100 servers that we where looking after to include the hosts specs, serial numbers, etc.
This was rather handy when doing a hardware support call. As we had the '1-stop-shop' for all the hardware service providers questions.

The environment was static, I was there for a fixed term of 6 months we didn't add or remove any systems so updating the list and keeping to date was not an issue.
Also from the static environment there was never any conflict information of the versions of spread sheets. The only conflict was the spreadsheet vs __realife/relativity__ 

All and all it worked pretty well, the size of the environment and the static nature helped in this case.


The Excel spreadsheet v1.459
------------------------------

The 3 environment that I was exposed used the same style "Excel spreadsheet" to keep track of all things server.
The interesting part here was that it was for 2,000+ servers.
It was an environment that although never decommissioned hosts, it was always seaming to add them.
This let to multiple copies of the single source of truth, with conflicting data. 
One of the problem was that only a few people had access to update the spread-sheet.
New changes took some time to go into the system ( 1-3 days, depending on the change ) and this was at least daily occurrence.

*The process to update the host list*
- Download spread-sheet ( manual )
- Find a new host ( manual )
- Find the details to the new host ( manual )
- Update local spread-sheet ( manual )
- Send new spread-sheet to 'editor' ( manual )
- 'Editor' review and update spread-sheet ( manual )
- 'Editor' upload changes to website ( manual )
- rise and repeat.

*Key:* manual = Horrible task that I would rather avoid

*The problem*
Due to the lengthly process of getting "official" changes into to the spread sheet, it lead to a verity of forks of the data.
multiple different copies of the same data, lead to conflicts, then a corporate culture of not trusting the data.

This system worked to a degree, however it was very manual intensive to keep all the data update to date.

Pre-Hostinfo
--------

The fourth place that I was shifting bits around started off with a text file "hosts.txt" which was all thought was updated automatically by the build process.
The decommission process ( or lack there of ) did not update the list to remove old dead hosts.

The other problem with the "hosts.txt" file was that it was a line separated list of hostnames, nothing more. You couldn't find out "How many solaris boxes vs linux boxes?" for example. The data was not there.

The best part of the system was that it was automated, however the list offered less data than what was in the DNS zone files.


Hostinfo
-----------

While still at the fourth place, we retired the "hosts.txt" in place we started to use __hostinfo__[add link].

*Hostinfo* is a key-value database system that can be quired for the command line.

The big advantage of hostinfo is that it knows how to pull apart Solaris Explorers and Redhat SOS reports. An explorer is a tarball of commands that the hardware service provider will ask for during a support call.
Think of it as a tarball of /etc/ with some extra commands ( format, fdisk, vmstat, etc ).

The setup was to do the following to get the data into hostinfo

- Every sunday night run an explorer or SOS report on the system
- Send the output of the explorer to the hostinfo box ( say /hostinfo/exploreres and /hostinfo/sosreports )
- The explorer2hostinfo process then takes over:
-- Extracts the explorer
-- Loops over all the interesting files
-- Pulls apart the files to generate a python dictionary about the system 
-- Throws the dictionary into the hostinfo database

This gives me an automated CMDB ( Configuration Management Database ) of every single one of my systems on the network.
Because the data about the system (eg. GB of ram ) is straight from the system its authoritative and always less then a week old ( hooray for cron ).

Given that the data is command line accessible it also allows for interesting questions to be asked:

```sh
$ hostinfo os=solaris
hostname1
hostname2
...
hostnamen
```

The above command will print out the names of every single host that runs the OS of solaris.

And because its a unix command line tool we can add 2 simple commands to provide better information.

```sh
$ hostinfo os=solaris | wc -l
500
```

The above command will print out how many solaris boxes in my environment.

*Using hostinfo in scripts*

To further exploit the data in hostinfo, we can include the queries and results into automation scripts.

```sh
$ cat restart_alls_the_apaches.sh
#!/bin/bash
for i in $( hostinfo os=solaris apps=apache );
do
echo "restarting apache on $i"
ssh $i "sudo service apache2 restart"
done
```

I don't why I would want to do the above, however if i needed to restart apache on every system that runs apache on my network __I can__.
The big advantage here is that if some builds a new apache service or installs it on a system ( thanks rpm -qa and pkginfo ) i do not need to update the restart script.

Beyond hostinfo
---------------

Hostinfo data is a pull from __reallife/relativity___, what if we turned hostinfo into a push from hostinfo into __reallife/relaitivity___.

With the user of tools like hostinfo, visualization and puppet, why can't the action of *hostinfo_addhost* instead of only adding a host to the hostinfo database, Add the host to my environment.


The evolution 
-------------

My evolution of hosts lists looks something like this.

- Memorize your hosts
- Write down your hosts
- Write down some extra information about your hosts
- Automation of data gathering
- Automation of the environment based on data entry.

Looking back ( and forward for now ), the data management becomes more complex.
However in that complexity it allows for complex questions to be asked.

I can easy answer the question of how much ram is used by our apache systems

```sh
$ hostinfo -p ram_used apps=apache | total "$1 (mb) ram, used by $total systems"
5321 (mb) of ram, used by 20 systems
```

However I would like to be able to, is something like the below...

```sh
$ hostinfo_addsystem apps=apache
New apache server will be ready in 5 minutes
```

Maybe one day.
