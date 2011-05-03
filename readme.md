# Postmarkdown

A simple Rails blog engine powered by markdown.

Postmarkdown is compatible with Rails 3 only and the gem is (soon to be) hosted on [RubyGems.org](http://rubygems.org).

## Installation

Simply add Postmarkdown to your Gemfile and bundle it up:

    gem 'postmarkdown'

Then, run the generator to setup Postmarkdown for your application:

    $ rails generate postmarkdown:install

The above command performs the following actions:

* Create the directory `app/posts/`. This directory is where your markdown files will live.
* Generate an example post using today's date, eg. `app/posts/2011-01-01-example-post.markdown`.
* Add some routes. By default the routes are setup underneath the path `/posts/*`, to customize these routes check out the Customizing Routes section below.

## Usage

### Generate a new Post

Here's an example of how to generate a new post using a slug and publish date:

    $ rails generate postmarkdown:post test-post --date=2011-01-01

The above command will create the file `app/posts/2011-01-01-test-post.markdown`, which you can edit and add content to.

### View the Post

Open `http://localhost:3000/posts` in your browser and you should be able to navigate to your new post. The URL for your new post is `http://localhost:3000/posts/2011/01/01/test-post`.

## Overriding Files

The easiest way to customize the Postmarkdown functionality or appearance is by using the override generator. This generator can copy files from the Postmarkdown core and place them into your Rails app. For example:

    $ rails generate postmarkdown:override --controller # overrides `app/controllers/posts_controller.rb`
    $ rails generate postmarkdown:override --model      # overrides `app/models/post.rb`
    $ rails generate postmarkdown:override --views      # overrides all files in directory `app/views/posts/`

## RSS Feed

Postmarkdown comes prepared with a fully functional RSS feed.

You can take advantage of the built-in feed by adding the feed link to your HTML head tag. For example, simply add the following to your default layout:

    <head>
      <!-- include your stylesheets and javascript here... -->
      <%= yield :head %>
    </head>

To customize the feed title, add the following to your application.rb:

    Postmarkdown::Config.options[:feed_title] = 'Custom Blog Title Goes Here'

To link to the feed in your app, simply use the route helper: `<%= link_to 'RSS Feed', posts_feed_path %>`

## Customizing Routes

By default Postmarkdown will setup all routes to go through the `/posts/*` path. For example:

    http://example.com/posts                      # lists all posts
    http://example.com/posts/2011                 # lists all posts from 2011
    http://example.com/posts/2011/01              # lists all posts from January 2011
    http://example.com/posts/2011/01/01           # lists all posts from the 1st of January 2011
    http://example.com/posts/2011/01/01/test-post # show the specified post

You can change the default route path by modifying the 'postmarkdown' line in `routes.rb`. For example:

    postmarkdown :as => :blog

This will produce the following routes:

    http://example.com/blog                      # lists all posts
    http://example.com/blog/2011                 # lists all posts from 2011
    http://example.com/blog/2011/01              # lists all posts from January 2011
    http://example.com/blog/2011/01/01           # lists all posts from the 1st of January 2011
    http://example.com/blog/2011/01/01/test-post # show the specified post

You can also customize the `posts#show` route via the `:permalink_format` option:

    postmarkdown :as => :blog, :permalink_format => :day   # URL: http://example.com/blog/2011/01/01/test-post
    postmarkdown :as => :blog, :permalink_format => :month # URL: http://example.com/blog/2011/01/test-post
    postmarkdown :as => :blog, :permalink_format => :year  # URL: http://example.com/blog/2011/test-post
    postmarkdown :as => :blog, :permalink_format => :slug  # URL: http://example.com/blog/test-post

What about mapping Postmarkdown to root? We got you covered:

    postmarkdown :as => ''
    root :to => 'posts#index'

## Example Directory Structure

    ├── app
    │   ├── controllers
    │   ├── helpers
    │   ├── mailers
    │   ├── models
    │   ├── posts (where your markdown files live)
    │   │   ├── 2011-04-01-example-1.markdown
    │   │   ├── 2011-04-02-example-2.markdown
    │   │   ├── 2011-04-03-example-3.markdown
    │   │   ├── 2011-04-04-example-4.markdown
    │   └── views
    │       └── posts (overridable)
    │           ├── _feed_link.html.haml
    │           ├── _post.html.haml
    │           ├── feed.xml.builder
    │           ├── index.html.haml
    │           └── show.html.haml

## TODO

### Before Launch
  * <del>Route: `postmarkdown :permalink_format => :slug`</del>
  * <del>Add info about blog at root to readme</del>
  * <del>RSpec tests for routes</del>
  * <del>Support more markdown file extensions, eg. `*.md, *.mkd, *.mdown`</del>
  * Text for when there's no posts on the index page, eg. 'There are no posts'
  * <del>Fix pre code blocks</del>
  * RSpec acceptance test for pre code blocks (= vs ~)
  * <del>RSpec model tests for author and email</del>
  * RSpec tests for the xml feed
  * Set default feed title to app name + route path
    * For example, `TestApp::Application` with the route `postmarkdown :as => :awesome_blog` would generate the feed title would be 'Test App Awesome Blog'

### After Launch
  * Redcarpet (and syntax highlighting)
  * Better comments in generated routes
  * Code comments (RDoc quality)
  * Pagination? Use a gem or basic custom solution? Support will\_paginate if possible, otherwise custom solution using the config module.
  * Support more file formats, eg. textile

## License

MIT License. Copyright 2011 Ennova.
