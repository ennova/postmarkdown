---
title: Example Post
<%- if author = Postmarkdown::Util.git_config('user.name') -%>
author: <%= author %>
<%- end -%>
<%- if email = Postmarkdown::Util.git_config('user.email') -%>
email: <%= email %>
<%- end -%>
---

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

# Markdown Formatting

[Reference](http://daringfireball.net/projects/markdown/syntax)

---

# Headers

## Header 2

### Header 3

---

# Emphasis

*italic* **bold**
_italic_ __bold__

---

# Links and Images

An [example](http://url.com/ "Title") Reference-style labels (titles are optional):

![Placeholder Kitten](http://placekitten.com/200/300)

---

# Lists

1. Foo
2. Bar

Unordered, with nesting:

* Abacus
  * answer
* Bubbles
  1. bunk
  2. bupkis
    * BELITTLER
  3. burper
* Cunning

---

# Preformatted Code Blocks

Indent every line of a code block by at least 4 spaces or 1 tab.

    This is a preformatted
    code block.
