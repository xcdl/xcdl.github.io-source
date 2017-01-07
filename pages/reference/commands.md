---
layout: page
permalink: /reference/commands/
title: The commands line reference
author: Liviu Ionescu

tocLevels: 1
---

## Introduction

This chapter contains reference information for the XCDL / xPack command line applications.

TODO: add/update content

## xpack

The `xpack` command is the XCDL package manager, equivalent to `npm`.

For reference, see [npm](https://docs.npmjs.com).

### access

Similar to `npm access`.

### build

Similar to `npm build`, but it might have different semantics.

### cache

Similar to `npm cache`.

### completion

Similar to `npm completion`.

### config

Similar to `npm config`.

### deprecate

Similar to `npm deprecate`.

### dist-tag

Similar to `npm dist-tag`.

### init

Similar to `npm init`.

### install

Similar to `npm install`.

### login

Similar to `npm login`.

### logout

Similar to `npm logout`.

### ls

Similar to `npm ls`.

### owner

Similar to `npm owner`.

### pack

Similar to `npm pack`.

### ping

Similar to `npm ping`.

### publish

Similar to `npm publish`.

### run-script

Similar to `npm run-script`.

Run scripts, similarly to `npm run-script name`. It should allow to pass arguments `npm run-script name -- 1 2 3` and possibly use configs.

Inspired from [How to Use npm as a Build Tool](https://www.keithcirkel.co.uk/how-to-use-npm-as-a-build-tool/).

Warning: running scripts on Windows requires attention.

### search

Similar to `npm search`.

### star

Similar to `npm star`.

### stars

Similar to `npm stars`.

### uninstall

Similar to `npm uninstall`.

### unpublish

Similar to `npm unpublish`.

### update

Similar to `npm update`.

### unstar

Similar to `npm unstar`.

### version

Similar to `npm version`.

### whoami

Similar to `npm whoami`.

## xcdl

Commands to manipulate the XCDL metadata.

TODO: define.

### make

Possibly a more generic version of `xpack build`, if XCDL can be extended with features specific to cmake/autotools/etc.

Perform a sequence of tasks to make something, similar to `make`. 

## xsvd

This group of commands are currently used to generate the files used by GNU ARM Eclipse QEMU.

**XSVD** files are the XCDL equivalent of CMSIS SVD files, but in JSON instead of XML.

### convert

Convert a CMSIS SVD file to XSVD.

### patch

Modify an XSVD file by adding definitions from a patch file.

### gen-code

Generate source code for QEMU peripherals.



