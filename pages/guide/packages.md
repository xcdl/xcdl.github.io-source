---
layout: page
permalink: /guide/packages/
title: XCDL packages
author: Liviu Ionescu
---

For a package to be usable in the XCDL component framework it must conform to certain rules imposed by the framework. Packages must be distributed in a form that is understood by the component repository administration tool. For each package there must be a top-level XCDL metadata file which describes the package to the component framework. There are certain portability requirements related to how a package gets built, so that the package can be used in a variety of host environments. In addition to these rules, the component framework provides a number of guidelines. It is not mandatory for the packages to strictly conform to all guidelines, but sticking to them can simplify certain operations.

## Packages

### What is a package?

An XCDL package is:

1. a folder containing a valid `.xpack` file;
2. a gzipped tarball containing 1);
3. a URL that resolves to 2);
4. a Git URL that, when cloned, results in 1).

The definition is inspired from the [NPM](https://docs.npmjs.com/misc/developers#what-is-a-package) package definition, and is intentionally Git and JavaScript centric, as these technologies are considered mature and worth considering.

Although the XCDL language will probably remain based on XML, equivalent definitions can be expressed in JSON, and maintaining compatibility with JSON is considered a kind of validation that the definitions are simple and consistent.

### Package contents

In addition to the `.xpack` metadata file, a typical package contains the following:

*  some number of source files (.c/.cpp) and header files (.h). The project artefact (library or executable) will be created using these files. Some source files may serve other purposes, for example to provide a linker script;
*  exported header files which define the interface provided by the package;
*  online documentation, for example reference pages for each exported function;
*  some number of test cases, shipped in source format, allowing users to check that the package is working as expected on their particular hardware and in their specific configuration;
*  other XCDL metadata files describing the package to the configuration system.

It is also conventional to have a per-package `ChangeLog` file used to keep track of changes to that package. This is especially valuable to end users of the package who may not have convenient access to the source code control system used to manage the master copy of the package, and hence cannot find out easily what has changed. Often it can be very useful to the main developers as well.

Any given packages need not contain all of these.

Some packages may not have any source code: it is possible to have a package that merely defines a common interface which can then be implemented by several other packages, especially in the context of device drivers; however it is still common to have some code in such packages to avoid replicating shareable code in all of the implementation packages. Similarly it is possible to have a package with no exported header files, just source code that implements an existing interface: for example an ethernet device driver might just implement a standard interface and not provide any additional functionality. Packages do not need to come with any on-line documentation, although this may affect how many people will want to use the package. Much the same applies to per-package test cases.

### Package layout

The component framework has a recommended per-package folder layout which splits the package contents on a functional basis:

    Packages/ilg/xyzw/current
    ├── .xpack
    ├── .xcdl
    ├── ChangeLog
    ├── README.md
    ├── doc
    ├── include
    ├── src
    └── tests

For example, if a package has an `include` sub-folder then the component framework will assume that all header files in and below that folder are **exported header files** and will do the right thing at build time. Similarly if there is *doc* property indicating the location of online documentation then the component framework will first look in the `doc` subfolder.

Except for the name and location of the `.xpack` file, this folder layout is just a guideline, it is not enforced by the component framework. For simple packages it often makes more sense to have all of the files in just one directory. For example a package could just contain the files hello.cpp, hello.h, hello.html. By default hello.h will be treated as an exported header file, although this can be overridden with the includeFiles property. Assuming there is a doc property referring to hello.html and there is no doc sub-directory then the tools will search for this file relative to the package’s top-level and everything will just work. Much the same applies to hello.cpp.

## The `.xpack` file

### root element

The root element for `.xpack` files is `package`:

    <?xml version="1.0" encoding="UTF-8" standalone="no" ?>

    <package>
      ..
    </package>

### `name`

A string that, together with the `parent`, must uniquely identify the project node in the local repository hierarchy. It does not need to match the GitHub repository name, althought usually it is closely related.

The parent path must have at least one level, and generally defines the originator of the package (user or organization).

The XML syntax:

    <name>"parent/string"</name>

The JSON Syntax (string):

    "name": "string"

Example:

    <name>/ilg/STM32/F4/HAL</name>

### `description`

A paragraph with a reasonably detailed description of the package.

The XML syntax:

    <description>long string</description>

The JSON Syntax (string):

    "description": "long string"

Example:

    <description>The STM32F4 HAL library.</description>

### `repository`

The place where the package repository is located. This is helpful for people who want to contribute.

The XML syntax:

    <repository>
      <type>string</type>
      <url>string</url>
    </repository>

The JSON syntax (array of objects):

    "repository": {
      "type": "string",
      "url": "string"
    }

Support for the `git` type is mandatory. Other types, like `svn`, might be added later.

Example:

    <repository>
      <type>git</type>
      <url>https://github.com/xpacks/arm-cmsis-core.git</url>
    </repository>

### `releases`

The list, in reverse order, of all versions of the package publicly released.

The XML syntax:

    <releases>
      <release name="semver">
        <description>long string</description>
        <date>iso-date</date>
        <properties>
          <property name="string">value</string>
          ...
        </properties>
      </release>
    </releases>

The JSON syntax (array of objects):

    "releases": [
      {
        "name": "semver",
        "description": "long string",
        "date": "iso-date",
        "property1": "value1",
        "property2": "value2",
        ...
      }
    ]

TODO:

* archiveUrl
* repository tag

### `keywords`

An array of strings, intended to help searches identify a package.

The XML syntax:

    <keywords>
      <keyword>string1</keyword>
      <keyword>string2</keyword>
      ...
    </keywords>

The JSON syntax (array of strings):

    "keywords": [
      "string1",
      "string2",
      ...
    ]

### `homepage`

The full URL to the project home page, either a separate web or a GitHub/SourceForge/etc project page.

The XML syntax:

    <homepage>url</homepage>

The JSON syntax (string):

    "homepage": "url"

### `bugs`

The full URL to the project's issue tracker and / or the email address to which issues should be reported. These are helpful for people who encounter issues with your package.

The XML syntax:

    <bugs>
      <url>string</url>
      <email>string</email>
    </bugs>

The JSON syntax (object):

    "bugs": {
      "url": "string",
      "email": "string"
    }

Example:

    <bugs>
      <url>https://github.com/gnuarmeclipse/plug-ins/issues/1</url>
    </bugs>


### `license`

A string identifying the license for the package, so that people know how they are permitted to use it.

The XML syntax:

    <license>string</license>

The JSON syntax (string):

    "license": "string"

The license is identified by a short ID, selected from the list of [SPDX license IDs](https://spdx.org/licenses/), ideally one that is [OSI](http://opensource.org/licenses/alphabetical) approved.

If the package is licensed under multiple common licenses, use an [SPDX license expression syntax version 2.0](http://npmjs.com/package/spdx) string, like this:

    <license>(ISC OR GPL-3.0)</license>

If the license hasn't been assigned an SPDX identifier, or if it is a custom license, use the following valid SPDX expression:

    <license>SEE LICENSE IN filename</license>

Then include a file named `filename` at the top level of the package.

Finally, if you do not wish to grant others the right to use a private or unpublished package under any terms, use:

    <license>UNLICENSED</license>

### `maintainers`

The maintainers are the persons who maintain the package (may be different from the persons who created the source files packaged in the package). The first maintainer is the person who created the package. The array extends at the end.

The XML syntax:

    <maintainers>
      <maintainer name="string">
        <email>string</string>
        <url>string</url>
      </maintainer>
    </maintainers>

The JSON syntax (array of objects):

    "maintainers": [
      {
        "name": "string",
        "email": "string",
        "url": "string"
      }
    ]

### `contributors`

The contributors are the persons who contributed to the content of the package. The first contributor is the person who created the source files available in the package. The array extends at the end.

The XML syntax:

    <contributors>
      <contributor name="string">
        <email>string</string>
        <url>string</url>
      </contributor>
      ...
    </contributors>

The JSON syntax (array of objects):

    "contributors": [
      {
        "name": "string",
        "email": "string",
        "url": "string"
      }
    ]

### `dependencies`

Dependencies are specified in a simple object that maps a package name to a version range. The version range is a string which has one or more space-separated descriptors. Dependencies can also be identified with a tarball or git URL.

The XML syntax:

    <dependencies>
      <package name="string">
        <version>string</version>
      </package>
    </dependencies>

The JSON syntax (object):

    "dependencies": {
      "string": "string",
      ...
    }

The syntax for the version string is based on [semver](http://semver.org/), with the following expressions (inspired from NPM):

* `version` Must match version exactly
* `>version` Must be greater than version
* `>=version` etc
* `<version`
* `<=version`
* `~version` "Approximately equivalent to version" See semver(7)
* `^version` "Compatible with version" See semver(7)
* `1.2.x` 1.2.0, 1.2.1, etc., but not 1.3.0
* `*` Matches any version
* `""` (just an empty string) Same as *
* `version1 - version2` Same as >=version1 <=version2
* `range1 || range2` Passes if either range1 or range2 are satisfied.

Future versions may also support:

* http://.../file.tgz
* git://...
* github://user/repo
* tag
* path/path/path (???)

Example:

    <package>
      <name>/ilg/stm32/f4/cmsis</name>
      ...
      <dependencies>
      <package name="arm/cmsis">
        <version>&gt;=4.4.0</version>
      </package>
      </dependencies>
      ...
    </package>

### `ignored`

The `ignored` is used to keep stuff out of the binary package. It uses the same syntax as `.gitignore` to exclude files when creating the binary archive.

The XML syntax:

    <ignored>
      <path>string</path>
      ...
    </ignored>

The JSON syntax (array of strings):

    "ignored": [
      "string",
      ...
    ]

Example:

    <ignored>
      <path>/.settings/</path>
    </ignored>


## Making a package distribution

Developers of new XCDL packages are advised to distribute their packages in the form of XCDL package distribution files. Packages distributed in this format may be added to existing XCDL component repositories in a robust manner using the Package Administration Tool. This chapter describes the format of package distribution files and details how to prepare an eCos package for distribution in this format.

### The XCDL package distribution file format

XCDL package distribution files are zipped archives which contain both the source code for one or more XCDL packages and a data file containing package information to be added to the component repository content list. The distribution files are subject to the following rules:

TODO: update for XCDL, this currently refers to eCos

1.  The data file must be named pkgadd.db and must be located in the root of the tar archive. It must contain data in a format suitable for appending to the eCos repository database (ecos.db). the Section called Updating the ecos.db database in Chapter 3 describes this data format. Note that a database consistency check is performed by the eCos Administration Tool when pkgadd.db has been appended to the database. Any new target entries which refer to unknown packages will be removed at this stage.
2.  The package source code must be placed in one or more $(package-path)/$(version) directories in the tar archive, where each $(package-path) directory path is specified as the directory attribute of one of the packages entries in pkgadd.db.
3.  An optional license agreement file named pkgadd.txt may be placed in the root of the tar archive. It should contain text with a maximum line length of 79 characters. If this file exists, the contents will be presented to the user during installation of the package. The eCos Package Administration Tool will then prompt the user with the question "Do you accept all the terms of the preceding license agreement?". The user must respond "yes" to this prompt in order to proceed with the installation.
4.  Optional template files may be placed in one or more templates/$(template_name) directories in the tar archive. Note that such template files would be appropriate only where the packages to be distributed have a complex dependency relationship with other packages. Typically, a third party package can be simply added to an eCos configuration based on an existing core template and the provision of new templates would not be appropriate. the Section called Templates in Chapter 6 contains more information on templates.
5.  The distribution file must be given a .epk (not .tar.gz) file extension. The .epk file extension serves to distinguish eCos package distributions files from generic gzipped GNU tar archives. It also discourages users from attempting to extract the package from the archive manually. The file browsing dialog of the eCos Package Administration Tool lists only those files which have a .epk extension.
6.  No other files should be present in the archive.
7.  Files in the tar archive may use LF or CRLF line endings interchangably. The eCos Administration Tool ensures that the installed files are given the appropriate host-specific line endings.
8.  Binary files may be placed in the archive, but the distribution of object code is not recommended. All binary files must be given a .bin suffix in addition to any file extension they may already have. For example, the GIF image file myfile.gif must be named myfile.gif.bin in the archive. The .bin suffix is removed during file extraction and is used to inhibit the manipulation of line endings by the eCos Administration Tool.

### Preparing XCDL packages for distribution

TODO: define the procedure to pack the content of a package folder to an archive.

## Credits

The initial content of this page was based on *Chapter 2. Package Organization* of *The eCos Component Writer’s Guide*, by Bart Veer and John Dallaway, published in 2001.
