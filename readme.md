# Postmarkdown

A simple Rails blog engine powered by Markdown.

Postmarkdown is compatible with Rails 3 only and the gem is hosted on [RubyGems.org](http://rubygems.org/gems/postmarkdown).

## Features

* Markdown files for blog posts
* No database
* RSS Feed
* Customizable Routes
* Built-in minimal theme (optional)
* HTML5
* Rails engine (so you can override models, views, controllers, etc)
* Easily customized

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

    $ rails generate postmarkdown:override --all        # overrides all of the things
    $ rails generate postmarkdown:override --controller # overrides `app/controllers/posts_controller.rb`
    $ rails generate postmarkdown:override --model      # overrides `app/models/post.rb`
    $ rails generate postmarkdown:override --views      # overrides all files in directory `app/views/posts/`
    $ rails generate postmarkdown:override --theme      # overrides the layout and stylesheet

## RSS Feed

Postmarkdown comes prepared with a fully functional RSS feed.

You can take advantage of the built-in feed by adding the feed link to your HTML head tag. For example, simply add the following to your default layout:

    <head>
      <!-- include your stylesheets and javascript here... -->
      <%= yield :head %>
    </head>

To customize the feed title, add the following to an initializer (`config/initializers/postmarkdown.rb`):

    Postmarkdown::Config.options[:feed_title] = 'Custom Blog Title Goes Here'

To link to the feed in your app, simply use the route helper: `<%= link_to 'RSS Feed', posts_feed_path %>`

## Built-in Theme

Postmarkdown comes with minimal built-in theme for your convenience. To turn on the theme, add the following to an initializer (`config/initializers/postmarkdown.rb`):

    Postmarkdown::Config.options[:use_theme] = true

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

* Syntax highlighting for code blocks
* Generated routes should show example usage
* Support more file formats, eg. textile
* Pagination
* Built-in theme should have a link to the RSS Feed
* Generator tests

## Development

```
bundle
rake appraisal:install
rake # run the tests
```

## License

MIT License. Copyright 2011 Ennova.
