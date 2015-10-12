---
layout: page
permalink: /work/preprocessor/
title: XCDL Preprocessor syntax thoughts
author: Liviu Ionescu
---

## Requirements

* do not interfere with C/C++ preprocessor, so that tools that process C/C++ (like Eclipse style formatter and Doxygen) are not confused; for C/C++, this leads to the solution of making XCDL preprocessor lines C++ comments, starting with `//`; for other languages a similar comment based syntax should be available
* do not interfere with other tools, like Doxygen
* be relatively simple to process
* expression syntax must be as standard as possible, preferably close to JavaScript

## Inspiration

* GitHub Jekyll
* Freescale Processor Expert
* Infineon DAVE
* ST CubeMX

## Ideas

* DAVE uses full Groovy scripts as templates; why not use the more standard JavaScript, but with a special syntax to avoid explicit out.print()?

## JavaScript implementations

* [Go Otto](https://github.com/robertkrimen/otto)
* [Java Rhino](https://github.com/mozilla/rhino)


## Possible syntax solutions

JavaScript syntax:

* `//@ ...`
* `//JS ...`
* `//EMEA ...`
* ~~`//! ...`~~ conflicts with Doxygen
* ~~`//> ...`~~ not fortunate, Doxygen use `//!<`

Custom syntax:

* `//XCDL @if`
* `//@ if`
* `//$ if`


## JavaScript

The templates are converted to JavaScript and then interpreted as such.

For example:

```
//@ if (defined(var)) {
... C/C++ lines ...
//@ }
```
translates into:

```
if (defined(var)) {
out.print("... C/C++ lines ...\n");
}
```

To include another file, and possibly pass some extra definitions:

```
//@ include("file-name")
//@ include("file-name", {name:'Ken',address:'secret',unused:true})
```

## Custom syntax

### include _file-name_ _[params ...]_
### if _expression_

Examples:

* `if $(var)` - true if variable was defined
* `if "..."` - true if string is non empty
