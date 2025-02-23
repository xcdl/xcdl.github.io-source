---
layout: main
title:  "The XCDL component framework"
permalink: /
author: Liviu Ionescu
---

## DEPRECATION Notice

The **XCDL component framework** is now part of the
[xPack Project](https://xpack.github.io), and
the xCDL functionality is documented in the
[xcdl](https://xpack.github.io/xcdl/) website.

## Introduction

The [XCDL project](https://github.com/xcdl) defines and implements a component framework, as a set of metadata and a collection of tools specifically designed to configure and build complex, package based, multi-variant (multi-architecture, multi-board, multi-toolchain) embedded projects. It is inspired by eCos CDL and also incorporates some ARM CMSIS Pack concepts. The primary projects to benefit from XCDL are:

- [xPacks](https://github.com/xpacks) (as repository for packages/components)
- [µOS++ IIIe](http://micro-os-plus.livius.net/) (as content for the components)
- [GNU ARM Eclipse](http://gnuarmeclipse.github.io/)  (as graphical tools to manage the components).

The XCDL project is hosted on [GitHub](https://github.com/xcdl).

## Credits

XCDL was definitely inspired by the eCos CDL, and many concepts are borrowed from it, including large excerpts from the eCos manuals, especially from [The eCos Component Writer’s Guide](http://ecos.sourceware.org/docs-2.0/cdl-guide/cdl-guide.html).

The XCDL Eclipse implementation also maintains a good degree of compatibility with the current [ARM CMSIS Packs (v1.x)](http://www.keil.com/pack/doc/CMSIS/Pack/html/index.html). More CMSIS Packs features are planned to be integrated, so that XCDL should be a superset of CMSIS Pack.

## Reference implementations

The reference implementation will include several Eclipse plug-ins as graphical configuration tools (part of [GNU ARM Eclipse](http://gnuarmeclipse.github.io/)), and several command line tools for non graphical environments (source code part of the XCDL project).

Although targeted to Eclipse, these specifications should not prevent other development environments to implement them, so, if needed, these specifications will be amended to make alternate implementations possible.

## Component Writer's Guide

- [Rationals]({{ site.baseurl }}/guide/rationals/)
- [Concepts]({{ site.baseurl }}/guide/concepts/)
- [Packages]({{ site.baseurl }}/guide/packages/)
- [Repositories]({{ site.baseurl }}/guide/repositories/)
- [Metadata]({{ site.baseurl }}/guide/metadata/)
- [The build process]({{ site.baseurl }}/guide/build-process/) (not yet updated for XCDL)
- The XCDL graphical tools

## Reference

- [Metadata]({{ site.baseurl }}/reference/metadata/)
- [command line tools]({{ site.baseurl }}/reference/commands/) (work in progress)

## SRS

- [The XCDL Software Requirement Specifications]({{ site.baseurl }}/srs/)

## How to use

TBD

## Work in progress

- [Scratchpad]({{ site.baseurl }}/work/scratchpad/)
- [Template preprocessor syntax]({{ site.baseurl }}/work/preprocessor/)

## Developer

- [JavaScript style guide]({{ site.baseurl }}/develop/js-style-guide/)

## License

The XCDL software is released under the [MIT](https://opensource.org/licenses/MIT).

## Remarks and criticism

- [eCos CDL]({{ site.baseurl }}/criticism/ecos/)
- [CMSIS Pack]({{ site.baseurl }}/criticism/cmsis/)
- [XCDL]({{ site.baseurl }}/criticism/xcdl/)

## References

- [eCos](http://ecos.sourceware.org/) - _The embedded configurable operating system_ by Cygnus Solutions ([Wikipedia](http://en.wikipedia.org/wiki/ECos))
- Manual: _The eCos Component Writer’s Guide_, by Bart Veer and John Dallaway, published in 2001, available from [eCos Documentation](http://ecos.sourceware.org/docs-3.0/).
- Book: _Embedded software development with eCos_, by Anthony J. Massa, published in 2003 at Prentice Hall, available from [Amazon](http://www.amazon.com/Embedded-Software-Development-Anthony-Massa/dp/0130354732)
- Book: _Software Build Systems: Principles and Experience_, by Peter Smith, published in 2011 at Addison Wesley, available from [Amazon](http://www.amazon.com/Software-Build-Systems-Principles-Experience/dp/0321717287)
- IEEE Std 830-1998: _IEEE Recommended Practice for Software Requirements Specifications_, published in 1998
- [CMSIS-Pack](http://www.keil.com/pack/doc/CMSIS/Pack/html/index.html) - ARM mechanism to install software, device support, APIs, and example projects

## Distribution management systems

- [OpenEmbedded](http://www.openembedded.org/wiki/Main_Page) - the build framework for embedded Linux (with more detail in the Yocto documentation)
- [BitBake User Manual](http://www.yoctoproject.org/docs/current/bitbake-user-manual/bitbake-user-manual.html) ([PDF](http://www.yoctoproject.org/docs/current/bitbake-user-manual/bitbake-user-manual.pdf))
- [Gentoo Development Guide](https://devmanual.gentoo.org/index.html)
- [MacPorts Guide](https://guide.macports.org/)
- [Arch PKGBUILD](https://wiki.archlinux.org/index.php/PKGBUILD)
- [NPM](https://www.npmjs.com) - the package manager for JS (special interest for the packet.json format)
- [yotta](http://yottadocs.mbed.com) - mbed module manager

## IoT development environments

- [mBed OS](https://www.mbed.com/en/development/mbed-os/#)
- [Apache mynewt](https://mynewt.apache.org)

## Build tools

For an exhaustive list, see [Wikipedia](https://en.wikipedia.org/wiki/List_of_build_automation_software).

- [Apache Maven](https://maven.apache.org/) (written in Java, XML configuration files)
- [SCons](http://scons.org/) (configuration files are Python scripts)
- [RAKE - Ruby Make](https://github.com/ruby/rake) (tasks and dependencies in Ruby)
- [buildr](http://buildr.apache.org) - Apache Buildr is a build system for Java-based applications
- [Gradle](https://gradle.org/) (written in Groovy)
- [CMake](http://www.cmake.org/) (written in C++; uses native builders like make)
- [Waf](https://github.com/waf-project/waf) (a build tool written in Python)
- [GNU Make](https://www.gnu.org/software/make/) (the classical tool; hopeless for folders with spaces)

## Continuous integration

For an exhaustive list see [Wikipedia](https://en.wikipedia.org/wiki/Comparison_of_continuous_integration_software).

- [Hudson](http://hudson-ci.org/) (the original Sun project, donated by Oracle to the Eclipse Foundation)
- [Jenkins](http://jenkins-ci.org/) (the more active fork, backed by the project creator)
- [Travis](https://travis-ci.org) (the GitHub prefered solution, very good integration)

## JavaScript resources

- [Book: JavaScript: The Definitive Guide (6th Edition) by David Flanagan](http://www.amazon.com/JavaScript-Definitive-Guide-Activate-Guides/dp/0596805527/)
- [Book: JavaScript: The Good Parts by Douglas Crockford](http://www.amazon.com/JavaScript-Good-Parts-Douglas-Crockford/dp/0596517742/)
- [Crockford JavaScript](http://www.crockford.com/javascript/)
  - [Private Members in JavaScript](http://www.crockford.com/javascript/private.html)
  - [Classical Inheritance in JavaScript](http://javascript.crockford.com/inheritance.html)
- [node.js](https://nodejs.org/en/)
- [npm](https://www.npmjs.com/)
- [Felix Geisendörfer's Node.js Style Guide](https://github.com/felixge/node-style-guide)
