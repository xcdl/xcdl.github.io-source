---
layout: page
permalink: /guide/packages/
title: XCDL packages
author: Liviu Ionescu
---

For a package to be usable in the XCDL component framework it must conform to certain rules imposed by the framework. Packages must be distributed in a form that is understood by the component repository administration tool. For each package there must be a top-level XCDL file which describes the package to the component framework. There are certain portability requirements related to how a package gets built, so that the package can be used in a variety of host environments. In addition to these rules, the component framework provides a number of guidelines. It is not mandatory for the packages to strictly conform to all guidelines, but sticking to them can simplify certain operations.

## Component repositories

Generally a component repository is a managed collection of packages.

### Packages and the local component repository

All development tools using XCDL packages include a local component repository. Similarly to the CMSIS Pack repository, this is a local folder structure where all installed packages are located. The component framework comes with an administration tool that allows new packages or new versions of a package to be installed, old packages to be removed, and so on. Each package has its own folder hierarchy within the component repository. Keeping several packages in a single folder is illegal.

To better accommodate the package separation for multi-vendor cases, the local folder hierarchy start with a folder with the vendor/originator name.

    Packages/
    ├── ARM
    ├── ilg
    ├── Keil
    ├── Nuvoton
    ├── lwIP
    └── wolfSSL

Below each vendor there are hierarchies of packages. Unrelated packages are all stored just below the vendor folder.

    Packages
    ├── ARM
    │   └── CMSIS
    ├── Keil
    │   ├── ARMCortex_DFP
    │   ├── MDK-Middleware
    │   ├── STM32F0xx_DFP
    │   ├── STM32F1xx_DFP
    │   ├── STM32F2xx_DFP
    │   ├── STM32F3xx_DFP
    │   ├── STM32F4xx_DFP
    │   ├── STM32L0xx_DFP
    │   ├── STM32L1xx_DFP
    │   ├── STM32NUCLEO_BSP
    │   ├── STM32W1xx_DFP
    │   └── V2M-MPS2_CMx_BSP
    ├── lwIP
    │   └── lwIP
    └── wolfSSL
        └── CyaSSL

After unpacking, the administrative tools change the protection bits of the component files to read/only, to prevent inadvertent changes while using the components.

### Remote/archives repositories

To save space and to simplify management, each XCDL package is packed into a ZIP archive. To make these archives public, the usual method of distribution is via a web server, each archive having its own URL.

### Individual packages

For individually distributed archived packages, the component framework should be able to manage these files, unpack and add their content to the local component repository.

### Git/local development trees

For component developers the usual package life cycle of pack/publish/fetch/unpack is not only useless, but may have a significant impact on the speed of the debug/test cycle.

For these cases it should be possible to directly use local folders where the packages are already unpacked.

Since these development folders are usually linked to revision control systems (like Git), another useful feature for the component framework would be to directly manage remote Git repositories.

For obvious reasons, contrary to the other files in the local repository, these files are not set to read/only.

TODO: define details >>>>>>>>>>>>>>>>

## Repository content brief

For each remote repository there is a summary content file enumerating the public packages with their full URLs and just enough information to build a brief outline of the package.

These files, usually named *content.xml* are managed by the administration tool. The various configuration tools read in these files when they start-up to obtain information about the various packages that have been installed.

For repositories of other types, like CMSIS Pack, which do not provide a *content.xml* file, the component framework provides a specific way of browsing the repository definition files and composing an equivalent *content.xml*, later cached locally.

An example of such file is presented below:

    <?xml version="1.0" encoding="UTF-8"?>

    <root version="1.1">
      <repository name="Keil">
        <description>Keil CMSIS packs repository</description>
        <properties>
          <property name="type">cmsis.repo</property>
          <property name="repo.url">http://www.keil.com/pack/index.idx</property>
          <property name="generator">GNU ARM Eclipse Plug-ins</property>
          <property name="date">20140620141046</property>
        </properties>
        <packages>
          <package name="CMSIS">
            <description>CMSIS (Cortex Microcontroller Software Interface Standard)</description>
            <versions>
              <version name="4.1.0">
                <description>- CMSIS-Driver   2.02  (incompatible update)</description>
                <properties>
                  <property name="type">cmsis.pack</property>
                  <property name="vendor.name">ARM</property>
                  <property name="pack.name">CMSIS</property>
                  <property name="version.name">4.1.0</property>
                  <property name="archive.url">http://www.keil.com/pack/ARM.CMSIS.4.1.0.pack</property>
                  <property name="archive.name">ARM.CMSIS.4.1.0.pack</property>
                  <property name="archive.size">62260982</property>
                  <property name="dest.folder">ARM/CMSIS/4.1.0</property>
                  <property name="pdsc.name">ARM.CMSIS.pdsc</property>
                  <property name="date">2014-06-12</property>
                </properties>
                <outline>
                  <devicefamily name="ARM Cortex M0">
                    <property name="vendor.name">ARM</property>
                    <property name="vendor.id">82</property>
                  </devicefamily>
                  <devicefamily name="ARM Cortex M0 plus">
                    <property name="vendor.name">ARM</property>
                    <property name="vendor.id">82</property>
                  </devicefamily>
                  <devicefamily name="ARM Cortex M3">
                    <property name="vendor.name">ARM</property>
                    <property name="vendor.id">82</property>
                  </devicefamily>
                  <devicefamily name="ARM Cortex M4">
                    <property name="vendor.name">ARM</property>
                    <property name="vendor.id">82</property>
                  </devicefamily>
                  ...
                  <board name="uVision Simulator">
                    <description>uVision Simulator</description>
                    <property name="vendor.name">Keil</property>
                  </board>
                  <component name="CMSIS / CORE">
                    <description>CMSIS-CORE for Cortex-M, SC000, and SC300</description>
                  </component>
                  <component name="Device / Startup">
                    <description>System and Startup for Generic ARM Cortex-M0 device</description>
                  </component>
                  <component name="Device / Startup / C Startup">
                    <description>System and Startup for Generic ARM Cortex-M0 device</description>
                  </component>
                  ...
                  <example name="DSP_Lib Class Marks example (uVision Simulator)">
                    <description>DSP_Lib Class Marks example</description>
                    <property name="example.name">DSP_Lib Class Marks example</property>
                  </example>
                  <example name="DSP_Lib Convolution example (uVision Simulator)">
                    <description>DSP_Lib Convolution example</description>
                    <property name="example.name">DSP_Lib Convolution example</property>
                  </example>
                  ...
                </outline>
                <external>
                  <board name="uVision Simulator">
                    <property name="vendor.name">Keil</property>
                  </board>
                </external>
              </version>
              <version name="4.0.0">
                <description>- CMSIS-Driver   2.00  Preliminary (incompatible update) ...</description>
                <properties>
                  <property name="type">cmsis.pack</property>
                  <property name="vendor.name">ARM</property>
                  <property name="pack.name">CMSIS</property>
                  <property name="version.name">4.0.0</property>
                  <property name="archive.url">http://www.keil.com/pack/ARM.CMSIS.4.0.0.pack</property>
                  <property name="archive.name">ARM.CMSIS.4.0.0.pack</property>
                  <property name="archive.size">0</property>
                  <property name="dest.folder">ARM/CMSIS/4.0.0</property>
                  <property name="pdsc.name">ARM.CMSIS.pdsc</property>
                </properties>
              </version>
              <version name="3.20.4">
                <description>- CMSIS-RTOS 4.74 (see revision history for details) ...</description>
                <properties>
                  <property name="type">cmsis.pack</property>
                  <property name="vendor.name">ARM</property>
                  <property name="pack.name">CMSIS</property>
                  <property name="version.name">3.20.4</property>
                  <property name="archive.url">http://www.keil.com/pack/ARM.CMSIS.3.20.4.pack</property>
                  <property name="archive.name">ARM.CMSIS.3.20.4.pack</property>
                  <property name="archive.size">52095025</property>
                  <property name="dest.folder">ARM/CMSIS/3.20.4</property>
                  <property name="pdsc.name">ARM.CMSIS.pdsc</property>
                </properties>
              </version>
              ...
            </versions>
          </package>
        </packages>
      </repository>
    </root>

## Package versioning

Below each package directory there can be one or more version sub-directories, named after the versions. This is a requirement of the component framework: it must be possible for users to install multiple versions of a package and select which one to use for any given application. This has a number of advantages to users: most importantly it allows a single component repository to be shared between multiple users and multiple projects, as required; also it facilitates experiments, for example it is relatively easy to try out the latest version of some package and see if it makes any difference. There is a potential disadvantage in terms of disk space. However since XCDL packages generally consist of source code intended for small embedded systems, and given typical modern disk sizes, keeping a number of different versions of a package installed will usually be acceptable. The administration tool can be used to remove versions that are no longer required.

    Packages/ilg
    └── Xyzw
        ├── 3.20.3
        ├── 3.20.4
        ├── 4.1.0
        └── current

The version *current* is special. Typically it corresponds to the very latest version of the package when using Git like local repositories, i.e. versions that were not frozen in a release.

All other subdirectories of a package correspond to specific releases of that package. The component framework allows users to select the particular version of a package they want to use, but by default the most recent one will be used. This requires some rules for ordering version numbers, a difficult task because of the wide variety of ways in which versions can be identified.

## Package contents and layout

A typical package contains the following:

1.  Some number of source files (.c/.cpp) and header files (.h). The project artefact (library or executable) will be created using these files. Some source files may serve other purposes, for example to provide a linker script.
2.  Exported header files which define the interface provided by the package.
3.  On-line documentation, for example reference pages for each exported function.
4.  Some number of test cases, shipped in source format, allowing users to check that the package is working as expected on their particular hardware and in their specific configuration.
5.  One or more CDL scripts describing the package to the configuration system.

It is also conventional to have a per-package *ChangeLog* file used to keep track of changes to that package. This is especially valuable to end users of the package who may not have convenient access to the source code control system used to manage the master copy of the package, and hence cannot find out easily what has changed. Often it can be very useful to the main developers as well.

Any given packages need not contain all of these. It is compulsory to have at least one XCDL file describing the package, otherwise the component framework would be unable to process it. The name of this file is fixed and the component framework will search for it in two locations, in the following order:

    ${package_root}/meta/xcdl.xml
    ${package_root}/xcdl.xml

Some packages may not have any source code: it is possible to have a package that merely defines a common interface which can then be implemented by several other packages, especially in the context of device drivers; however it is still common to have some code in such packages to avoid replicating shareable code in all of the implementation packages. Similarly it is possible to have a package with no exported header files, just source code that implements an existing interface: for example an ethernet device driver might just implement a standard interface and not provide any additional functionality. Packages do not need to come with any on-line documentation, although this may affect how many people will want to use the package. Much the same applies to per-package test cases.

The component framework has a recommended per-package folder layout which splits the package contents on a functional basis:

    Packages/ilg/Xyzw/current
    ├── ChangeLog
    ├── doc
    ├── include
    ├── meta
    │   └── xcdl.xml
    ├── src
    └── tests

For example, if a package has an *include* sub-folder then the component framework will assume that all header files in and below that folder are **exported header files** and will do the right thing at build time. Similarly if there is *doc* property indicating the location of on-line documentation then the component framework will first look in the doc sub-folder.

This folder layout is just a guideline, it is not enforced by the component framework. For simple packages it often makes more sense to have all of the files in just one directory. For example a package could just contain the files hello.cpp, hello.h, hello.html and xcdl.xml. By default hello.h will be treated as an exported header file, although this can be overridden with the includeFiles property. Assuming there is a doc property referring to hello.html and there is no doc sub-directory then the tools will search for this file relative to the package’s top-level and everything will just work. Much the same applies to hello.cpp and xcdl.xml.

### Build artefact types

The whole purpose of the XCDL components is to be used as reusable building blocks when creating standard artefacts like libraries and executables. It should be possible to create an executable from multiple libraries, each built from separate XCDL components.

The main development environment targeted by XCDL is Eclipse, so it should support the creation and management of CDT projects. As such, the definitions of the XCDL components should provide all information required by Eclipse CDT. Since XCDL is a superset of CMSIS Pack, it should be perfectly possible for the Eclipse projects to use/refer definitions provided by CMSIS Pack packages, like the list of devices/boards and their specific hardware details.

As a alternate to Eclipse, it should be possible to create XCDL projects entirely using command line tools.

### Outline of the new project process

Creating new projects generally starts with the target selection, usually a board. The board refer to the device, which refers to the core, so most details required by the Eclipse cross build plug-in can be set automatically.

The alternate, for cases when a board definition is not available, is to select the device from the list of known devices, known from the CMSIS Packs definitions.

The next step is to select a template, which will later simplify the individual component selection.

The *New C/C++ Project* wizard should not directly go to configuring the components, but create a project with the default setting, and then open the separate configuration editor.

This separate editor should be available at any time during the lifespan of the project, and can be invoked, for example, by editing the .xcdlconfig.xml file, and/or by using custom menu entries.

### Outline of the build process

The full build process is moulded after the Eclipse CDT build system. It is described in [The build process](/The_build_process "wikilink"), but a summary is appropriate here. A build involves several directory structures:

1.  The component repository. This is where all the package source code is held, along with XCDL files, documentation, and so on. For build purposes a component repository is read-only. Application developers will only modify the component repository when installing or removing packages, via the administration tool. Component writers will typically work with Git/local component repositories, which are read/write.
2.  The local source tree. This is where artefact specific files are located. For Eclipse projects, this is the project folder. The artefacts are built using the source files in this tree and selected source files from the component repository. Upon user request, the component framework tools may copy files from the component repository to the local source tree. Several artefacts can be constructed from one local source tree, usually variants of the same configuration, like Debug/Release, but this is not restricted by the framework, with special care it might be possible to build artefacts for different boards from the same source tree. For a given local source tree there is a single .xcdlconfig.xml file, containing one XCDL configuration for each artefact to be build.
3.  The build tree. Each configuration has its own build tree. For Eclipse projects, this is the output folder of each Eclipse build configuration. The build tree contains only intermediate files, object files and final artefact, list files, map files, etc. Once a build is complete, the build tree contains no information that is useful for application development and can be wiped, although this would slow down any rebuilds following changes to the configuration.
4.  An optional install tree, where the newly created artefacts are copied in a custom build step like *make install*. Eclipse projects do not use such a tree, but leave the artefacts to be used directly from the build tree.

When used inside Eclipse, the build process involves the following steps:

1.  Given a configuration, the component framework is responsible for updating the current project to match the definitions in the .xcdlconfig.xml. This extra step is implemented in a custom Eclipse builder, that requires, to be activated, a custom *nature* to be added to the project. The order of the builders associated to a project is significative, and the XCDL builder must be executed before the CDT builder. The usual case assumes that the actual source files are linked to those in the component repository. If, during the project creation, the user chose to keep local copies of the packs file, these are now copied locally.
2.  After the source files are linked and all required folders are created, the component framework generates the configuration headers, also in the specific build tree locations.
3.  The CDT builder is invoked and the library or executable artefact is created in the build tree.

When invoked from a command line, the build process involves the following steps:

1.  Given a configuration, the component framework is responsible for creating all the folders required during the build. If these folders already exist then the component framework is responsible for any clean-ups that may be necessary, for example if a package has been removed then all related files should be expunged from the build and install trees. The configuration header files will be generated at this time. Depending on the host environment, the component framework will also generate makefiles or some other way of building the various packages. Every time the configuration is modified this step needs to be repeated, to ensure that all option consequences take effect. Care is taken that this will not result in unnecessary rebuilds.
2.  The first step in an actual build is to make sure that the install tree contains all exported header files. All compilations will use the install tree’s include directory as one of the places to search for header files.
3.  All source files relevant to the current configuration get compiled. This involves a set of compiler flags initialized on a per-target basis, with each package being able to modify these flags, and with the ability for the user to override the flags as well. Care has to be taken here to avoid inappropriate target-dependencies in packages that are intended to be portable. The component framework has built-in knowledge of how to handle C, C++ and assembler source files. The `<sourceFile>` property is used to list the files that should get compiled. All object files end up in the build tree.
4.  The component framework provides support for custom build steps, using the make_object and make properties. The results of these custom build steps can either be object files that should end up in a library, or other files such as a linker script. It is possible to control the order in which these custom build steps take place, for example it is possible to run a particular build step before any of the compilations happen.

### Configurable source code

All packages should be totally portable to all target hardware (with the obvious exceptions of HAL and device driver packages). They should also be totally bug-free, require the absolute minimum amount of code and data space, be so efficient that cpu time usage is negligible, and provide lots of configuration options so that application developers have full control over the behavior. The configuration options are optional only if a package can meet the requirements of every potential application without any overheads. It is not the purpose of this guide to explain how to achieve all of these requirements.

The XCDL component framework does have some important implications for the source code: compiler flag dependencies; package interfaces vs. implementations; and how configuration options affect source code.

#### Compiler flag dependencies

Wherever possible component writers should avoid dependencies on particular compiler flags. Any such dependencies are likely to impact portability. For example, if one package needs to be built in big-endian mode and another package needs to be built in little-endian mode then usually it will not be possible for application developers to use both packages at the same time; in addition the application developer is no longer given a choice in the matter. It is far better for the package source code to adapt the endianness at compile-time, or possibly at run-time although that will involve code-size overheads.

#### Package interfaces and implementations

The component framework provides encapsulation at the package level. A package *A* has no way of accessing the implementation details of another package *B* at compile-time. In particular, if there is a private header file somewhere in a package’s *src* sub-folder then this header file is completely invisible to other packages. Any attempts to cheat by using relative pathnames beginning with ../.. are generally doomed to failure because of the presence of package version directories. There are two ways in which one package can affect another: by means of the exported header files, which define a public interface; or via the XCDL scripts.

This encapsulation is a deliberate aspect of the overall XCDL component framework design. In most cases it does not cause any problems for component writers. In some cases enforcing a clean separation between interface and implementation details can improve the code. Also it reduces problems when a package gets upgraded: component writers are free to do pretty much anything on the implementation side, including renaming every single source file; care has to be taken only with the exported header files and with the XCDL data, because those have the potential of impacting other packages. Application code is similarly unable to access package implementation details, only the exported interface.

Very occasionally the inability of one package to see implementation details of another does cause problems. One example occurs in HAL packages, where it may be desirable for the architectural, variant and platform HAL’s to share some information that should not be visible to other packages or to application code. This may be addressed in the future by introducing the concept of friend packages, just as a C++ class can have friend functions and classes which are allowed special access to a class internals. It is not yet clear whether such cases are sufficiently frequent to warrant introducing such a facility.

#### Source code and configuration options

Configurability usually involves source code that needs to implement different behavior depending on the settings of configuration options. It is possible to write packages where the only consequence associated with various configuration options is to control what gets built, but this approach is limited and does not allow for fine-grained configurability. There are three main ways in which options could affect source code at build time:

1.  The component code can be passed through a suitable preprocessor, either an existing one such as m4 or a new one specially designed with configurability in mind. The original sources would reside in the component repository and the processed sources would reside in the build tree. These processed sources can then be compiled in the usual way.
    This approach has two main advantages. First, it is independent from the programming language used to code the components, provided reasonable precautions are taken to avoid syntax clashes between preprocessor statements and actual code. This would make it easier in future to support languages other than C and C++. Second, configurable code can make use of advanced preprocessing facilities such as loops and recursion.

    The disadvantage is that component writers would have to learn about a new preprocessor and embed appropriate directives in the code. This makes it much more difficult to turn existing code into components, and it involves extra training costs for the component writers. The extra definitions might also confuse document generating utlities like Doxygen.

2.  Compiler optimizations can be used to elide code that should not be present, for example:
  ```
          ...
          if (OS_INTEGER_NUMBER_UARTS > 0) {
            ...
          }
          ...
```

  If the compiler knows that OS_INTEGER_NUMBER_UARTS is the constant number 0 then it is a trivial operation to get rid of the unnecessary code. The component framework still has to define this symbol in a way that is acceptable to the compiler, typically by using a const variable or a preprocessor symbol. In some respects this is a clean approach to configurability, but it has limitations:

    -   it cannot be used in the declarations of data structures or classes, nor does it provide control over entire functions
    -   in addition it may not be immediately obvious that this code is affected by configuration options, which may make it more difficult to understand
    -   even if the condition does not evaluate to true, and the optimiser gets rid of the code, it still requires the elided code to be syntactically correct, which sometimes it is not possible, due to missing references.

3.  Existing language preprocessors can be used. In the case of C or C++ this would be the standard C preprocessor, and configurable code would contain a number of `#ifdef` and `#if` statements.
  ```
        #if defined(OS_DEBUG_INFRA_DEBUG_PRECONDITIONS)
          ...
        #endif

        ...

        #if (OS_INTEGER_NUMBER_UARTS > 0)
          ...
        #endif
```

  This approach has the advantage that the C preprocessor is a technology that is both well-understood and widely used. There are also disadvantages: the preprocessing facilities are rather limited; and some people (including ourselves) consider the technology to be ugly, generally decreasing program readability.

#### Preprocessor definitions

The current component framework generates configuration header files with C preprocessor `#define`s for each option (typically, there various properties which can be used to control this). It is up to component writers to decide whether to use preprocessor `#ifdef` statements or language constructs such as if. At present there is no support for languages which do not involve the C preprocessor.

#### C++11 **constexpr**

The second type of definitions that the component framework should support are *C++11 constexpr* definitions. These definitions are the typed equivalent of the preprocessor definitions, but with some significant differences:

-   are processed by the compiler, not the preprocessor; this has the advantage of allowing type checks
-   can be grouped in name spaces; this minimise the risk of name clashes

  ```
    namespace one
    {
      constexpr int variable = 1234;
    }
```

It is recommended to use constexpr expressions for all options providing values, and limit the use of preprocessor definitions only to control which parts of the code is included, i.e. definitions like `#if defined(OS_INCLUDE_SOME_FUNCTIONALITY)`.

TODO: add definitions to support constexpr to properties.

### Exported header files

A package’s exported header files should specify the interface provided by that package, and avoid any implementation details. However there may be performance or other reasons why implementation details occasionally need to be present in the exported headers.

Configurability has a number of effects on the way exported header files should be written. There may be configuration options which affect the interface of a package, not just the implementation. It is necessary to worry about nested `#include`’s and how this affects package and application builds. A special case of this relates to whether or not exported header files should `#include` configuration headers. These configuration headers are exported, but should only be `#include`’d when necessary.

#### Configurable functionality

Many configuration options affect only the implementation of a package, not the interface. However some options will affect the interface as well, which means that the options have to be tested in the exported header files. Some implementation choices, for example whether or not a particular function should be inlined, also need to be tested in the header file because of language limitations.

Consider a configuration option OS_INCLUDE_KERNEL_MUTEX_TIMEDLOCK which controls whether or not a function os_mutex_timedlock() is provided. The exported kernel header file *os/kernel/kapi.h* could contain the following:

    #include <pkgconf/kernel.h>
    ...
    #ifdef OS_INCLUDE_KERNEL_MUTEX_TIMEDLOCK
    extern bool os_mutex_timedlock(os_mutex_t*);
    #endif

This is a correct header file, in that it defines the exact interface provided by the package at all times. However is has a number of implications. First, the header file is now dependent on pkgconf/kernel.h, so any changes to kernel configuration options will cause *os/kernel/kapi.h* to be out of date, and any source files that use the kernel interface will need rebuilding. This may affect sources in the kernel package, in other packages, and in application source code. Second, if the application makes use of this function somewhere but the application developer has misconfigured the system and disabled this functionality anyway then there will now be a compile-time error when building the application. Note that other packages should not be affected, since they should impose appropriate constraints on OS_INCLUDE_KERNEL_MUTEX_TIMEDLOCK if they use that functionality (although of course some dependencies like this may get missed by component developers).

An alternative approach would be:

    extern bool os_mutex_timedlock(os_mutex_t*);

Effectively the header file is now lying about the functionality provided by the package. The first result is that there is no longer a dependency on the kernel configuration header. The second result is that an application file using the timedlock function will now compile, but the application will fail to link. At this stage the application developer still has to intervene, change the configuration, and rebuild the system. However no application recompilations are necessary, just a relink.

Theoretically it would be possible for a tool to analyze linker errors and suggest possible configuration changes that would resolve the problem, reducing the burden on the application developer. No such tool is planned in the short term.

It is up to component writers to decide which of these two approaches should be preferred. Note that it is not always possible to avoid `#include`’ing a configuration header file in an exported one, for example an option may affect a data structure rather than just the presence or absence of a function. Issues like this will vary from package to package.

#### Nested `#include`’s

As a general rule, unnecessary `#include`’s should be avoided. A header file should `#include` only those header files which are absolutely needed for it to define its interface. Any additional `#include`’s make it more likely that package or application source files become dependent on configuration header files and will get rebuilt unnecessarily when there are minor configuration changes.

#### Including configuration headers

Exported header files should avoid `#include`’ing configuration header files unless absolutely necessary, to avoid unnecessary rebuilding of both application code and other packages when there are minor configuration changes. A `#include` is needed only when a configuration option affects the exported interface, or when it affects some implementation details which is controlled by the header file such as whether or not a particular function gets inlined.

There are a couple of ways in which the problem of unnecessary rebuilding could be addressed. The first would require more intelligent handling of header file dependency handling by the tools (especially the compiler) and the build system. This would require changes to various non-XCDL tools. An alternative approach would be to support finer-grained configuration header files, for example there could be a file pkgconf/libc/inline.h controlling which functions should be inlined. This could be achieved by some fairly simple extensions to the component framework, but it makes it more difficult to get the package header files and source code correct: a C preprocessor `#ifdef` directive does not distinguish between a symbol not being defined because the option is disabled, or the symbol not being defined because the appropriate configuration header file has not been `#include`’d. It is likely that a cross-referencing tool would have to be developed first to catch problems like this, before the component framework could support finer-grained configuration headers.

### Package documentation

On-line package documentation should be in HTML format. The component framework imposes no special limitations: component writers can decide which version of the HTML specification should be followed; they can also decide on how best to cope with the limitations of different browsers. In general it is a good idea to keep things simple.

### Test cases

Packages should normally come with one or more test cases. This allows application developers to verify that a given package works correctly on their particular hardware and in their particular configuration, making it slightly more likely that they will attempt to find bugs in their own code rather than automatically blaming the component writers.

#### Google Test

XCDL itself does not include a specific testing infrastructure and tests may use any C/C++ testing infrastructure.

µOS++ fully supports the [Google Test](http://code.google.com/p/googletest/) & [Google Mock](http://code.google.com/p/googlemock/) testing infrastructure, and XCDL should be able to configure the environment required to run these tests.

#### Running tests on the host

If possible, tests should be written highly portable, and should be able to run on the host, as command line applications returning a non-zero exit code if the test failed.

#### Continuous integration

XCDL should provide support to collect information about all tests contributed by all packages available in a configuration and run all of them from a scriptable environment, in order to facilitate integration into continuous integration tools like [Hudson](http://en.wikipedia.org/wiki/Hudson_(software)).

#### Semihosted tests

XCDL should also provide support to run the same tests on the actual hardware (or on simulators like QEMU), using the semihosting infrastructure.

#### TODO: update XCDL tests definitions

At the time of writing the application developer support for building and running test cases via the component framework is under review and likely to change. Currently each eCos test case should consist of a single C or C++ source file that can be compiled with the package’s set of compiler flags and linked like any application program. Each test case should use the testing API defined by the infrastructure. A magically-named calculated configuration option of the form `CYGPKG_<PACKAGE-NAME>_TESTS` lists the test cases.

### Host-side support

On occasion it would be useful for an XCDL package to be shipped with host-side support. This could take the form of an additional tool needed to build that package. It could be an application intended to communicate with the target-side package code and display monitoring information. It could be a utility needed for running the package test cases, especially in the case of device drivers. The component framework does not yet provide any such support for host-side software, and there are obvious issues related to portability to the different machines that can be used for hosts. This issue may get addressed in some future release. In some cases custom build steps can be subverted to do things on the host side rather than the target side, but this is not recommended.

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

The initial content of this page was based on *Chapter 2. Package Organizaion* of *The eCos Component Writer’s Guide*, by Bart Veer and John Dallaway, published in 2001.
