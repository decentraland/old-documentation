# Decentraland documentation

## Setup

1.  Add your site and author details in `_config.yml`.
2.  Add your Google Analytics, Disqus and MailChimp keys to `_config.yml`.
3.  Get a workflow going to see your site's output (with [CloudCannon](https://app.cloudcannon.com/) or Jekyll locally).

## Develop

Base was built with [Jekyll](http://jekyllrb.com/) version 3.4.3, but should support newer versions as well.

Install the dependencies with [Bundler](http://bundler.io/):

```bash
$ bundle install
```

Run `jekyll` commands through Bundler to ensure you're using the right versions:

```bash
$ bundle exec jekyll serve --incremental
```

## Editing

Please use Visual Studio Code with Prettier extension to have a consistent coding style

#### Posts

- Add, update or remove a post in the _Posts_ collection.
- The tutorials page is organised by categories.
- Change the defaults when new posts are created in `_posts/_defaults.md`.

#### Post Series

To create a new series:

- Add a new document to the `sets` collection.
- Set the `title` and `description`.

To add a tutorial/post to a series:

- Add a `set` field to the tutorial front matter which points to the file name of the desired set without the `.md` extension. e.g. If I have a set at `_sets/getting-started.md` I would use this in my tutorial front matter: `set: getting-started`.
- Add a `set_order` field to the tutorial front matter and specify a number. This is the tutorials order in the set.

#### Navigation

- Exposed as a data file to give clients better access.
- Set in the _Data_ / _Navigation_ section.

#### Footer

- Exposed as a data file to give clients better access.
- Set in the _Data_ / _Footer_ section.

---

Base template was made by [CloudCannon](http://cloudcannon.com/), the Cloud CMS for Jekyll.
