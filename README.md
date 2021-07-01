# Decentraland documentation

## Setup

1.  Add your site and author details in `_config.yml`.
2.  Add your Google Analytics, Disqus and MailChimp keys to `_config.yml`.
3.  Get a workflow going to see your site's output (with [CloudCannon](https://app.cloudcannon.com/) or Jekyll locally).

## Develop

Base was built with [Jekyll](http://jekyllrb.com/) version 3.8.4, but should support newer versions as well.

Install the dependencies with [Bundler](http://bundler.io/):

```bash
$ bundle install
```

Run `jekyll` commands through Bundler to ensure you're using the right versions:

```bash
$ bundle exec jekyll serve --incremental
```

While jekyll is running, you can open the locally hosted version of the docs site on a browser, using [http://127.0.0.1:4000/](http://127.0.0.1:4000/). As you make changes to the source material, the generated site should be updated when reloading.

## Develop (Docker)

if you have [Docker](https://www.docker.com/) you also can run your development environment with the follow command

```bash
docker run --rm -p 4000:4000 \
  --volume="$PWD:/srv/jekyll" \
  --volume="$PWD/.vendor/bundle:/usr/local/bundle" \
  -it jekyll/jekyll:3.8.4 \
  jekyll serve --incremental
```

## Editing

Please use Visual Studio Code with Prettier extension to have a consistent coding style

### Posts

- Add, update or remove a post in the _Posts_ collection.
- The tutorials page is organised by categories.
- Change the defaults when new posts are created in `_posts/_defaults.md`.

### Menu

- Add post to menu editing `_data/menu.yml`

### Navigation

- Exposed as a data file to give clients better access.
- Set in the _Data_ / _Navigation_ section.

### Footer

- Exposed as a data file to give clients better access.
- Set in the _Data_ / _Footer_ section.

---

Base template was made by [CloudCannon](http://cloudcannon.com/), the Cloud CMS for Jekyll.
