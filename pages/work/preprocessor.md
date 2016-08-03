---
layout: page
permalink: /work/preprocessor/
title: XCDL Preprocessor syntax thoughts
author: Liviu Ionescu
---

## Problem

Define a template mechanism to generate source files, based on various external definitions.

## Requirements

* interfere as little as possible with the file language
* do not interfere with other tools, like Doxygen
* be relatively simple to process
* syntax must be as standard as possible

## Embed metadata inside comments

The natural implementation of the first requirement is similar to that used by Doxygen, i.e. insert the template metadata as standard comments.

This has two major advantages:

* the template files do not introduce a new syntax, but are regular source files, that can be edited with current editors, and do not interfere with syntax colouring;
* the template files can be reformatted with existing formatters.

## Inspiration

Although there are many other preprocessing solutions, none that I know meets the requirements.

### Jekyll

The [Jekyll](https://jekyllrb.com) static web generator uses the [Liquid](https://shopify.github.io/liquid/) metadata, which comes in two types: tags (for flow control) and object/filters (for inserting content).

```
{% raw  %}{% if user %}
  hello("{{ user.name }}!");
{% endif %}
  url="{{ url | append: ".html" }}";{% endraw %}
```

Embedding this into comments would look like this:

```
{% raw  %}/* {% if user %} */
  hello("/* {{ user.name }} */!");
/* {% endif %} */
  url="/* {{ url | append: ".html" }} */";
```

The syntax remains relatively easy to read, but it introduces a new language, that needs to be parsed and processed.

### ST CubeMX

CubeMX uses `.ftl` files with a complex script syntax, that use opening and possibly closing tags (`[if]`, `[/if]`), and substitutions encoded like macros (`${argument.name}`).

```
[#ftl]
[#-- macro generateConfigModelCode --]

[#macro generateConfigModelCode configModel inst nTab index]
[#if configModel.methods??] [#-- if the pin configuration contains a list of LibMethods--]
    [#assign methodList = configModel.methods]
[#else]
    [#if configModel.methods??]
        [#assign methodList = configModel.libMethod]  
    [/#if]
[/#if]
[#assign writeConfigComments=false]
[#if methodList?? ]
[#list methodList as method]
    [#if method.status=="OK"][#assign writeConfigComments=true][/#if]
[/#list]
[#if writeConfigComments]
[#if configModel.comments??] #t#t/**${configModel.comments?replace("#t","#t#t")} #n#t#t*/[/#if]
[/#if]
... ${argument.name} ...
```

The syntax controls the details of the expansion to the latest details, including generating tabs and new lines (`#t`, `#n`), so the template file is not really a source file, and embedding the metadata as comments doesn't make much sense.

If done, it would look like this:

```
/*
[#ftl]
[#-- macro generateConfigModelCode --]

[#macro generateConfigModelCode configModel inst nTab index]
[#if configModel.methods??] [#-- if the pin configuration contains a list of LibMethods--]
    [#assign methodList = configModel.methods]
[#else]
    [#if configModel.methods??]
        [#assign methodList = configModel.libMethod]  
    [/#if]
[/#if]
[#assign writeConfigComments=false]
[#if methodList?? ]
[#list methodList as method]
    [#if method.status=="OK"][#assign writeConfigComments=true][/#if]
[/#list]
[#if writeConfigComments]
[#if configModel.comments??] #t#t/**${configModel.comments?replace("#t","#t#t")} #n#t#t*/[/#if]
[/#if]
*/
... /* ${fargument.name} */ ...
```

(The files are in the `db/templates` folder; on macOS this is located below `STM32CubeMX.app/Contents/Resources`).

### Infineon DAVE

In DAVE 4 templates are stored as `.tmpl` files and use full [Groovy](http://www.groovy-lang.org) scripts (which look very familiar to Java programmers).

```
package Model.Common;

out.print("""
/*******************************************************************************
 Copyright (c) 2014, Infineon Technologies AG                                 **
 All rights reserved.                                                         **
*******************************************************************************/

/*******************************************************************************
 * @brief This function initializes the Apps Init Functions.
 *
 * @param[in]  None
 *
 * @return  DAVE_STATUS_t <BR>
 *
 * <b>Reentrant: No </b><BR>
 *
 ******************************************************************************/

DAVE_STATUS_t DAVE_Init(void)
{
  DAVE_STATUS_t init_status;

  init_status = DAVE_STATUS_SUCCESS;

 """);

def appsList = daveEnv.project.getTopLevelApps();
def apps = [];
def appName
def instanceLabel

 for (def app : appsList ) {
 	 if(app.initProvider) {
 		 apps.add(app);
	 }
}
out.print("""     

/** @Initialization of Apps Init Functions */

""");
 for (def app : apps ) {
	 appName = app.getClass().getSimpleName()
	 instanceLabel = app.getInstanceLabel()
out.print("""
  if (init_status == DAVE_STATUS_SUCCESS)
  {
    /**  Initialization of ${appName} App instance ${instanceLabel} */
    init_status = (DAVE_STATUS_t)${appName}_Init(&${instanceLabel});
  }  
""");

}
out.print("""

  return init_status;
} /**  End of function DAVE_Init */
""");
```

The actual content is included with triple quote strings and substitutions are performed on the way, using the `${appName}` syntax.

By using a fully fledged script language, the template engine is very powerful.

Templates can be found in `Infineon\D_LibraryStore_4.1\DeviceFeatures\pack\2.0.0\CE_Templates\TLE`

### Freescale Processor Expert

The late Processor Expert is probably the grand-dad of all component code-generating solutions. It was designed as the ultimate solution, and indeed it provides lots of features, but at the cost of a very high complexity. (for an overview, please read this [article](https://mcuoneclipse.com/2015/10/18/overview-processor-expert/)).

There are many XML file with lots of definitions.

The templates are `.drv` files, and the syntax looks like:

```
%-
%INTERFACE
%define! Settings Common\FAT_FileSystemSettings.Inc
%define! Abstract Common\FAT_FileSystemAbstract.Inc
%include Common\Header.h

#ifndef __%'ModuleName'_H
#define __%'ModuleName'_H

/* MODULE %ModuleName. */
/* Wrappers to FatFS types and constants */
#define %'ModuleName'%.FATFS            FATFS
#define %'ModuleName'%.DIR              DIR
#define %'ModuleName'%.FIL              FIL
#define %'ModuleName'%.FILINFO          FILINFO
#define %'ModuleName'%.FS_READONLY      _FS_READONLY
#define %'ModuleName'%.USE_LFN          _USE_LFN
#define %'ModuleName'%.MAX_LFN          _MAX_LFN
#define %'ModuleName'%.FS_REENTRANT     _FS_REENTRANT
#define %'ModuleName'%.MAX_SS           _MAX_SS
#define %'ModuleName'%.FS_RPATH         _FS_RPATH
#define %'ModuleName'%.FRESULT          FRESULT
#define %'ModuleName'%.DRESULT          DRESULT

%ifdef SharedModules
/* Include shared modules, which are used for whole project */
  %for var from IncludeSharedModules
#include "%'var'.h"
  %endfor
%endif
/* Include inherited beans */
%ifdef InhrSymbolList
  %for var from InhrSymbolList
#include "%@%var@ModuleName.h"
  %endfor
%endif
...
%-************************************************************************************************************
%-BW_METHOD_BEGIN RenameFile
%ifdef RenameFile
%define! ParsrcFileName
%define! PardstFileName
%define! Pario
%define! RetVal
%include Common\FAT_FileSystemRenameFile.Inc
/*!
 * \brief Renames a file
 * \param[in] srcFileName Source/existing file name
 * \param[in] dstFileName Destination/new file name
 * \param[in] io IO handler for output
 * \return Error code, ERR_OK for success.
 */
uint8_t %'ModuleName'%.%RenameFile(const uint8_t *srcFileName, const uint8_t *dstFileName, const %@Shell@'ModuleName'%.StdIOType *io)
{
  %'ModuleName'%.FRESULT fres;

  if (%'ModuleName'%.isWriteProtected((uint8_t*)"")) {
    %@Shell@'ModuleName'%.SendStr((unsigned char*)"disk is write protected!\r\n", io->stdErr);
    return ERR_FAILED;
  }
  fres = %'ModuleName'%.rename((char*)srcFileName, (char*)dstFileName);
  if(fres!=FR_OK) {
    FatFsFResultMsg((unsigned char*)"rename failed", fres, io);
    return ERR_FAILED;
  }
  return ERR_OK;
}

%endif %- RenameFile
%-BW_METHOD_END RenameFile
%-************************************************************************************************************
```

The point of Processor Expert is to implement some kind of objects, with each instance fully generated from a template. People I respect consider that once the components are written, using them is quite convenient. The real challenge is to write these components, and this process can be done only with Processor Expert.

The components can be found in the `C:\ProgramData\Processor Expert\PEXDRV_PE5_3` folder

## Scripting proposal

It looks like using a kind of scripting language is inevitable. Defining a custom one, even inspired by an existing solution, is possible, but implementing it requires significant efforts.

With the omnipresent JavaScript, a better solution might be to implement the scripting part in JavaScript.

The DAVE idea to have the entire template as a script is one option. An even better option would be to generate this script.

So, the main idea is to design things in such a way to allow a relatively simple conversion of the entire template to a JavaScript, and to execute it.

## JavaScript implementations

Mature JavaScript implementations are now available for most platforms and languages, for example:

* [Go Otto](https://github.com/robertkrimen/otto)
* [Java Rhino](https://github.com/mozilla/rhino)


## Possible syntax solutions

Assuming the tags need to be encoded as comments, for C/C++ these are two solutions:

* `/*JS ... */` and `//JS`
* `/*@ ... */` and `//@ ...`

## JavaScript

With the choice for JavaScript and the requirement that scripts be encoded as comments, the templates can be converted to JavaScript and then interpreted as such.

For example:

```
/*JS if (variable==="value") { */
... C/C++ lines ...
/*JS } */
```
translates into:

```
if (variable==="value") {
o("... C/C++ lines ...\n");
}
```

where `o()` is a function that outputs the string to the destination file.

Substitutions are identified and the generated JavaScript code converts the values to strings and outputs them.

```
#define VARIABLE ($(value+1))
```

translates to:
```
o("#define VARIABLE (");o(String(value+1));o(")\n");
```

## Choices

### `/*JS` vs `/*@`

Personally I prefer `/*JS`, but it is one character longer. The lower case alternative (`/*js`) is also possible.

### `/*$()*/` vs shorter `$()`

The first version seems easier to parse, since it stops at the first occurrence of `)*/`, but is longer and is less readable.

The second version is definitely more attractive, but requires a more elaborate parsing of the content. For C/C++, the syntax overlaps a legal expression (`$` is a legal identifier, so `$()` is actually a function call).

Please note that formatters may add a space in front of the parenthesis (like `$ ()`).

## Examples

With these conventions, the above samples would look like:

```
/*JS if (defined(user)) { */
  hello("$(user.name)!");
/*JS } */
  url="$(append(url,'.html')";
```
