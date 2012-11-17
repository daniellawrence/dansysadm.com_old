dansysadm.com
=============

Website for dansysadm.com

The website uses markdown and some css to build the HTML pages.

- __src__ contains markdown and css files that are generated into HTML
- __theme__ contains the header and footer files that are already HTML
- __generate_website.py__ the code that reads in the src files and turns the into HTML
- __settings__ contains settings like where the src files are and where are the going
- __deploy_local.sh__ A horrible hack to generate the pages and restart nginx
- __deploy_remote.sh__ A horrible hack to generate the pages, ship them to my web server and restart nginx
