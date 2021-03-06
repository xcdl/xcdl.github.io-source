[![Build Status](https://travis-ci.org/xcdl/xcdl.github.io-source.svg?branch=master)](https://travis-ci.org/xcdl/xcdl.github.io-source)

# The XCDL Web Site source

## Overview

This GitHub project, available from [xcdl/xcdl.github.io-source](https://github.com/xcdl/xcdl.github.io-source), contains the source files used to generate the **XCDL Web Site**.

## Destination URL

The **XCDL Web Site** is an organisation [GitHub Pages](https://pages.github.com) site, stored in the [xcdl/xcdl.github.io](https://github.com/xcdl/xcdl.github.io) Git and publicly available from [http://xcdl.github.io](http://xcdl.github.io).

## Jekyll

The web site is generated off-line by [Jekyll](http://jekyllrb.com). It cannot be generated by [GitHub Pages](https://pages.github.com) because it uses Jekyll plug-ins, considered unsafe and disabled by the GitHub Pages instance of Jekyll.

## Prerequisites

To be able to run the Jekyll build process, the `ruby` interpreter and the `gem` tool are required. In OS X 10.10.5, these tools are preinstalled, at least when the Developer Command Line tools are present.

```bash
$ ruby --version
ruby 2.0.0p481 (2014-05-08 revision 45883) [universal.x86_64-darwin14]
$ gem --version
2.0.14
$ sudo gem install jekyll
...
$ jekyll --version
jekyll 2.5.3
```

In addition, the several specific gems are required:

```bash
$ sudo gem install redcarpet jekyll-mentions jemoji jekyll-redirect-from jekyll-feed jekyll-sitemap jekyll-last-modified-at
```

## Clone Git

To manage the web site, a local copy of this repository is required.

```
$ git clone https://github.com/xcdl/xcdl.github.io-source.git xcdl.github.io-source.git
```

## Development

The current development cycle is edit-save-build-view.

The test build can be performed automatically by Jekyll when started in server mode.

```
$ cd xcdl.github.io-source.git
$ jekyll serve --baseurl "" --trace
```

The test build result is in the `_site_local` folder.

To view the result, point the browser to `localhost:4000`.

## Build

The final build can be performed by Jekyll using the `build` command.

```
$ cd xcdl.github.io-source.git
$ jekyll build --trace
```

## Publish

The final build result is in the `_site` folder.

This folder is configured as a submodule, linked to the [xcdl.github.io](https://github.com/xcdl/xcdl.github.io) project.

To publish, just commit this Git and the new site will be automatically updated.

## Folder structure

### Posts

All blog posts are in the `_posts` folder.

### Pages

All web pages are in the `pages` folder.

## Timezone

As per `_config.yml`, the default timezone is UTC. For other timezones, set it explicitly as offset (for example +0300)
