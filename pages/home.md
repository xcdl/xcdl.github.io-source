---
layout: main
title:  Welcome to XCDL!
permalink: /
author: Liviu Ionescu
---

## Introduction

The XCDL project defines an **eXtensible Component Definition Language** (CDL) and implements tools based on it to configure and build complex, package based, multi-variant (multi-architecture, multi-board, multi-toolchain) embedded projects. It is inspired by eCos CDL and also plans to incorporate some ARM CMSIS Pack concepts. The primary projects to benefit from XCDL are [µOS++ IIIe](http://micro-os-plus.livius.net/) (as content for the components), [xPacks](https://github.com/xpacks) (as repository for packs) and [GNU ARM Eclipse](http://gnuarmeclipse.github.io/)  (as graphical tools to manage the components).

## Credits

XCDL was definitely inspired by the eCos CDL, and many concepts are borrowed from it, including large excerpts from the eCos manuals, especially from [The eCos Component Writer’s Guide](http://ecos.sourceware.org/docs-2.0/cdl-guide/cdl-guide.html).

The XCDL Eclipse implementation also maintains a good degree of compatibility with the current [ARM CMSIS Packs (v1.x)](http://www.keil.com/pack/doc/CMSIS/Pack/html/index.html). More CMSIS Packs features are planned to be integrated, so that XCDL should be a superset of CMSIS Pack.

## Reference implementations

The reference implementation will include several Eclipse plug-ins as graphical configuration tools (part of [GNU ARM Eclipse](http://gnuarmeclipse.github.io/)), and several command line tools for non graphical environments (source code part of the XCDL project).

Although targeted to Eclipse, these specifications should not prevent other development environments to implement them, so, if needed, these specifications will be amended to make alternate implementations possible.

## Component Writer's Guide

* [XCDL concepts and rationals]({{ site.baseurl }}/concepts-and-rationals/)
* [XCDL packages]({{ site.baseurl }}/packages/)
* [The XCDL language]({{ site.baseurl }}/language/)
* [The build process]({{ site.baseurl }}/build-process/) (not yet updated for XCDL)
* The XCDL graphical tools

## Reference

* [The XCDL definitions reference]({{ site.baseurl }}/definitions-reference/)
* The XCDL command line tools reference

## SRS

* [The XCDL Software Requirement Specifications]({{ site.baseurl }}/srs/)

## How to use

TBD

## License

The XCDL software is released under the [MIT License](http://en.wikipedia.org/wiki/MIT_License).

## Miscellaneous

* [eCos CDL remarks and criticism]({{ site.baseurl }}/ecos-remarks/)
* [CMSIS Pack remarks and criticism]({{ site.baseurl }}/cmsis-remarks/)
* [XCDL remarks and criticism]({{ site.baseurl }}/xcdl-remarks/)
* [Project history]({{ site.baseurl }}/project-history/)
* [Scratchpad]({{ site.baseurl }}/scratchpad/)

## References

* [eCos](http://ecos.sourceware.org/) - _The embedded configurable operating system_ by Cygnus Solutions ([Wikipedia](http://en.wikipedia.org/wiki/ECos))
* Manual: _The eCos Component Writer’s Guide_, by Bart Veer and John Dallaway, published in 2001, available from [eCos Documentation](http://ecos.sourceware.org/docs-3.0/).
* Book: _Embedded software development with eCos_, by Anthony J. Massa, published in 2003 at Prentice Hall, available from [Amazon](http://www.amazon.com/Embedded-Software-Development-Anthony-Massa/dp/0130354732)
* Book: _Software Build Systems: Principles and Experience_, by Peter Smith, published in 2011 at Addison Wesley, available from [Amazon](http://www.amazon.com/Software-Build-Systems-Principles-Experience/dp/0321717287)
* IEEE Std 830-1998: _IEEE Recommended Practice for Software Requirements Specifications_, published in 1998
* [CMSIS-Pack](http://www.keil.com/pack/doc/CMSIS/Pack/html/index.html) - ARM mechanism to install software, device support, APIs, and example projects

## Distribution management systems

* [OpenEmbedded](http://www.openembedded.org/wiki/Main_Page) - the build framework for embedded Linux (with more detail in the Yocto documentation)
* [BitBake User Manual](http://www.yoctoproject.org/docs/current/bitbake-user-manual/bitbake-user-manual.html) ([PDF](http://www.yoctoproject.org/docs/current/bitbake-user-manual/bitbake-user-manual.pdf))
* [Gentoo Development Guide](https://devmanual.gentoo.org/index.html)
* [MacPorts Guide](https://guide.macports.org/)
* [Arch PKGBUILD](https://wiki.archlinux.org/index.php/PKGBUILD)

## Build tools

For an exhaustive list, see [Wikipedia](https://en.wikipedia.org/wiki/List_of_build_automation_software).

* [Apache Maven](https://maven.apache.org/) (written in Java, XML configuration files)
* [SCons](http://scons.org/) (configuration files are Python scripts)
* [RAKE - Ruby Make](https://github.com/ruby/rake) (tasks and dependencies in Ruby)
* [Gradle](https://gradle.org/) (written in Groovy)
* [CMake](http://www.cmake.org/) (written in C++; uses native builders like make)
* [Waf](https://github.com/waf-project/waf) (a build tool written in Python)
* [GNU Make](https://www.gnu.org/software/make/)

## Continuous integration

For an exhaustive list see [Wikipedia](https://en.wikipedia.org/wiki/Comparison_of_continuous_integration_software).

* [Hudson](http://hudson-ci.org/) (the original Sun project, donated by Oracle to the Eclipse Foundation)
* [Jenkins](http://jenkins-ci.org/) (the more active fork, backed by the project creator)
