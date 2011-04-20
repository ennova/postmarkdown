# Postmarkdown

A simple Rails blog engine powered by markdown.

Postmarkdown is compatible with Rails 3 only and the gem is (soon to be) hosted on [RubyGems.org](http://rubygems.org).

## Installation

Simply add Postmarkdown to your Gemfile and bundle it up:

  gem 'postmarkdown'

Run the generator to setup Postmarkdown for your application:

  $ rails generate postmarkdown:install # not implemented yet

The above command performs the following actions:

* Creates a `posts` directory underneath `app`. This directory is where your markdown files will live.
* Adds some routes. By default the routes are setup underneath `/posts/*`, but you can customize this in `config/routes.rb`.

## Usage

## Generate post

Here's an example of how to generate a new post using a slug:

  $ rails generate postmarkdown:post 2011-01-01-test-post # not implemented yet

The above command will create the file `app/posts/2011-01-01-test-post.markdown`, which you can edit and add content to.

## View post

Open `http://localhost:3000/posts` in your browser and you should be able to navigate to your new post. The URL for your new post is `http://localhost:3000/posts/2011/01/test-post`.
