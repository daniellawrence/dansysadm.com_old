dansysadm.com
=============

Website for <http://dansysadm.com> , See it in action

The website uses markdown and some css to build the HTML pages.


Features
--------
- Uses markdown2 to turn the markdown into HTML
- Separate Header and Footer pages allow for easy theme changes
- pygments used for code highlighting.

Installing
-----------

- Pull down the code
- Install the requirements
- Generate the website
- Start the SimpleHTTPServer

      $ git clone git@github.com:daniellawrence/dansysadm.com.git
      $ pip install -r requirements.txt
      $ python generate_website.py
      $ cd web
      $ python -m SimpleHTTPServer

------

- __src__ contains markdown and css files that are generated into HTML
- __theme__ contains the header and footer files that are already HTML
- __generate_website.py__ the code that reads in the src files and turns the into HTML
- __settings__ contains settings like where the src files are and where are the going
- __deploy_local.sh__ A horrible hack to generate the pages and restart nginx
- __deploy_remote.sh__ A horrible hack to generate the pages, ship them to my web server and restart nginx


TODO
-----

- Replace deploy_local.sh and deploy_remote.sh with a fabric script
- Add Tags or Topics to blog posts.
- Work out a way to support lots of blog posts ( re-work /src/blog/index.md )