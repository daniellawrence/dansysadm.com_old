#!/usr/bin/env python
"""
Take some static files and turn it into static html. 

TODO:
* Auto-generate /blog/blog.index page based on files in that dir
* Do git branching for production and dev uploads
"""
import os
import markdown2
import shutil
import settings

def generate_page(page_file, header_html, footer_html, root):
    """
    Take a markdown page name, a header, a footer and its location and
    turn it into a full html page, ready to be uploaded to a remote system.
    """
    # Remove the .md file extension from the page_file into the page_name
    page_name = page_file.replace('.md','')

    output_dir = settings.output_dir
    # generate the path to the page based on the root and page_name
    page_path = '%(root)s/%(page_file)s' % locals()

    # Generate the directory where the complied html will end up 
    dir_target = '%(output_dir)s/%(root)s' % locals()
    dir_target = dir_target.replace('/src','')

    # Generate the location where the complied html will end up 
    page_target = '%(dir_target)s/%(page_name)s.html' % locals()
    print "%(page_path)s -> %(page_target)s" % locals()

    # Make sure the output directory is on the system
    if not os.path.exists( dir_target ):
        os.mkdir( dir_target )

    # Read in the source page ( as markdown )
    page_markdown = open( page_path ).read()
    # Create a markdown2 object
    markdowner = markdown2.Markdown(extras=["fenced-code-blocks","fenced_code", "pyshell"])
    # Convert the markdown into html
    page_html = markdowner.convert( page_markdown )

    # Write the file into the target area.
    f = open( page_target , 'w')
    f.write( header_html )
    f.write( page_html )
    f.write( footer_html )
    f.close()

def main():
    """
    Read the headers and footers and generate all the pages in the input_dir.
    """

    # Read in the header file
    header_html = open(settings.header_file).read()

    # Read in the footer file
    footer_html = open(settings.footer_file).read()

    input_dir = settings.input_dir 
    output_dir = settings.output_dir

    # copy all the static content to the output_dir,
    shutil.copytree('%(input_dir)s/static' % locals() ,'%(output_dir)s/static' % locals())

    for (root, dir_name, files ) in os.walk(input_dir):
        for src_file in files:
            if not src_file.endswith('.md'):
                continue
            generate_page( src_file, header_html, footer_html, root )
        

if __name__ == '__main__':
	main()
