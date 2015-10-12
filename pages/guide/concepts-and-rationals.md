---
layout: page
permalink: /guide/concepts-and-rationals/
title: XCDL concepts and rationals
author: Liviu Ionescu
---

## Overview

To manage the potential complexity of multiple components and lots of configuration options, XCDL comes with a component framework: a collection of tools specifically designed to support configuring multiple components. This component framework is extensible, allowing additional components to be added to the system at any time.

## Why configurability?

The XCDL component framework places a great deal of emphasis on configurability. The fundamental goal is to allow large parts of embedded applications to be constructed from reusable software components, which does not a priori require that those components be highly configurable. However embedded application development often involves some serious constraints.

Many embedded applications have to work with very little memory, to keep down manufacturing costs. The component framework must allow users to configure the components so that any unnecessary functionality gets removed.

Embedded systems tend to be difficult to debug. The re-usable components can provide debugging assistance in various ways. Allowing users to control which debugging features are enabled for any given application build is very desirable.

## Approaches to configurability

The purpose of configurability is to control the behavior of components. When an application uses a component there must be some way of specifying the desired behavior. The component writer has no way of knowing in advance exactly how a particular component will end up being used.

One way to control the behavior is at **run time**. There is of course a major disadvantage in terms of the size of the final application image: the code that gets linked with the application has to provide support for all possible behavior, even if the application does not require it.

Another approach is to control the behavior at **link time**, typically by using inheritance in an object-oriented language and linking only one instance of the implementation.

The XCDL component framework allows the behavior of components to be controlled at an even earlier time: when the component source code gets compiled.

In theory **compile-time** configurability should give the best possible results in terms of code size, because it allows code to be controlled at the individual statement level rather than at the function or object level. The overall result is that the final application image contains only the code and data that is really needed for the application to work, and nothing else.

Compile-time configurability is not intended to replace the other approaches but rather to complement them.

There will be times when run-time selection of behavior is desirable: for example an application may need to be able to change the baud rate of a serial line, and the system must then provide a way of doing this at run-time. There will also be times when link-time selection is desirable.

## Terminology

The XCDL component architecture involves a number of key concepts, presented below.

### Component framework

The phrase **component framework** is used to describe the collection of tools that allow users to configure a system and administer a component repository.

Portability is mandatory, all tools being required to run on primary desktop environments, like Windows, OS X and GNU/Linux.

The reference implementation will include one or more Eclipse plug-ins as graphical configuration tools, and several Python command line tools for non graphical environments.

### Option

The **option** is the basic unit of configurability. Typically each option corresponds to a single choice that a user can make. For example there may be an option to control whether or not assertions are enabled, and the kernel may provide an option corresponding to the number of scheduling priority levels in the system. Options can control very small amounts of code such as whether or not a library function gets inlined. They can also control quite large amounts of code, for example whether or not the printf supports floating point conversions.

Many options are straightforward, and the user only gets to choose whether the option is enabled or disabled. Some options are more complicated, for example the number of scheduling priority levels is a number that should be within a certain range. Options should always start off with a sensible default setting, so that it is not necessary for users to make hundreds of decisions before any work can start on developing the application. Once the application is running the various configuration options can be used to tune the system for the specific needs of the application.

The component framework allows for options that are not directly user-modifiable. Consider the case of processor endianness: some processors are always big-endian or always little-endian, while with other processors there is a choice. Depending on the user’s choice of target hardware, endianness may or may not be user-modifiable.

In general, options are leaves in a hierarchy, and component or package are tree nodes, and can contain other options specific to that objects.

Options can be *active/inactive*. Inactive options are shown as grey in the interface, and the user cannot enable/disable them, or change the value for options with attached data. An option is automatically inactive if its parent component is inactive or disabled.

Active options can be *enabled/disabled* by users, usually via a graphical tool. Simple options are boolean, and the enable/disable status is also the value associated with them. More complex options can have different types, and values according to these types.

### Component

A **component** is a unit of functionality such as a particular kernel scheduler or a device driver for a specific device. A component is also a configuration option in that users may want to enable or disable all the functionality in a component. For example, if a particular device on the target hardware is not going to be used by the application, directly or indirectly, then there is no point in having a device driver for it. Furthermore disabling the device driver should reduce the memory requirements for both code and data.

Components may contain further configuration options. In the case of a device driver, there may be options to control the exact behavior of that driver. These will of course be irrelevant if the driver as a whole is disabled. More generally options and components live in a hierarchy, where any component or package can contain options specific to that component and further sub-components.

Components can be *active/inactive*. Inactive components are shown as grey in the interface, and the user cannot enable/disable them, or change the value if not boolean. A component is automatically inactive if its parent component is inactive or disabled.

Active components can be *enabled/disabled* by users, usually via a graphical tool, similar to options. More complex options can have different types, and values according to these types.

### Package

A package is a special type of component. Specifically, a package is the unit of distribution of components. It is possible to create a distribution file for a package containing all of the source code, header files, documentation, and other relevant files. This distribution file can then be installed using the appropriate tool. Afterwards it is possible to uninstall that package, or to install a later version. The core distribution may come with a number of packages such as the kernel and the infrastructure. Other packages such as network stacks can come from various different sources and can be installed alongside the core distribution.

Packages can be *loaded* or *not loaded*. Generally it makes no sense for the tools to load the details of every single package that has been installed. For example, if the target board explicitly requires to use the STM32F407VG processor, then there is no point in loading packages for other processors and displaying choices to the user which are not relevant. Therefore *loading* a package means loading its configuration data into the appropriate tool, and making it available for user choices; a package not loaded by a configuration simply does not exist for that configuration, and none of its resources can be used. In addition, it is also possible to select the particular version of a package that should be loaded.

Packages can also be organised hierarchically, and loading of a package automatically loads all parent packages, up to the repository root.

### Configuration

A **configuration** is a persistent collection of user choices, applied on top of a collection of choices made by the component designer. The various tools that make up the component framework deal with configurations. Users can create a new configuration, manage a configuration, and use a configuration to generate a build tree prior to building an artefact (application or library). A configuration includes details such as which packages are loaded, plus finer-grained information such as which options in those packages have been enabled or disabled by the user and what values were assigned to typed versions.

### Target

The **target** is the specific piece of hardware on which the application is expected to run. This may be an off-the-shelf evaluation board, a piece of custom hardware intended for a specific application, or it could be something like a simulator or a synthetic platform. One of the steps when creating a new configuration is the need to select the target. The component framework will map this on to a set of packages that are used to populate the configuration, typically HAL and device driver packages, and in addition it may cause certain options to be changed from their default settings to something more appropriate for the specified target.

### Template

A template is a partial configuration, aimed at providing users with an appropriate starting point. XCDL repositories should be shipped with a small number of templates, which correspond closely to common ways of using them.

There is a minimal template which provides very little functionality, just enough to bootstrap the hardware and then jump directly to the application code. The default template adds additional functionality, for example it causes the kernel and various library packages to be used as well. Creating a new configuration typically involves specifying a template as well as a target, resulting in a configuration that can be built and linked with the application code and that will run on the actual hardware. It is then possible to fine-tune configuration options to produce something that better matches the specific requirements of the application.

### Properties

The component framework needs a certain amount of information about each option. For example it needs to know what the legal values are, what the default should be, where to find the on-line documentation if the user needs to consult that in order to make a decision, and so on. These are all **properties** of the option. Every option (including components and packages) consists of a name and a set of properties.

### Consequences

Choices must have consequences. For some configuration the main end product is a library, for other an executable, so the consequences of a user choice must affect the build process. This happens in two main ways. First, options can affect which files get built and end up in the library or executable. Second, details of the current option settings get written into various configuration header files using C preprocessor *\#define* directives, and package source code can *\#include* these configuration headers and adapt accordingly. This allows options to affect a package at a very fine grain, at the level of individual lines in a source file if desired. There may be other consequences as well, for example there are options to control the compiler flags that get used during the build process.

### Constraints

Configuration choices are not independent. The C library can provide thread-safe implementations of functions like *rand()*, but only if the kernel provides support for per-thread data. This is a constraint: the C library option has a requirement on the kernel. A typical configuration involves a considerable number of constraints, of varying complexity: many constraints are straightforward, *option A requires option B*, or *option C precludes option D*. Other constraints can be more complicated, for example *option E may require the presence of a kernel scheduler* but does not care whether it is the bitmap scheduler, the mlqueue scheduler, or something else.

Another type of constraint involves the values that can be used for certain options. For example there is a kernel option related to the number of scheduling levels, and there is a legal values constraint on this option: specifying zero or a negative number for the number of scheduling levels makes no sense.

### Conflicts

As the user manipulates options it is possible to end up with an invalid configuration, where one or more constraints are not satisfied. For example if kernel per-thread data is disabled but the C library’s thread-safety options are left enabled then there are unsatisfied constraints, also known as **conflicts**. Such conflicts will be reported by the configuration tools. The presence of some conflicts may prevent users from building the project, but some may not, and in these cases the consequences are undefined: there may be compile-time failures, there may be link-time failures, the application may completely fail to run, or the application may run most of the time but once in a while there will be a strange failure... Typically users will want to resolve all conflicts before continuing.

To make things easier for the user, the configuration tools contain an inference engine. This can examine a conflict in a particular configuration and try to figure out some way of resolving the conflict. Depending on the particular tool being used, the inference engine may get invoked automatically at certain times or the user may need to invoke it explicitly. Also depending on the tool, the inference engine may apply any solutions it finds automatically or it may request user confirmation.

### Component repository

Generally a **component repository** is a managed collection of packages.

Based on the location, component repositories can be stored on:

-   a remote location, from where packages are installed; usually packages are stored as http resources on a web server
-   a local folder structure, where the packages get installed.

The component framework comes with an administration tool that allows new packages or new versions of a package to be installed, old packages to be removed, and so on. The component repository includes special files, maintained by the administration tool, which contain details of the various registered packages.

Generally application developers do not need to modify anything inside the component repository, except by means of the administration tool. Instead their work involves separate build and install trees. This allows the component repository to be treated as a read-only resource that can be shared by multiple projects and multiple users. Component writers modifying one of the packages do need to manipulate files in the component repository.

## XCDL

The configuration tools require information about the various options provided by each package, their consequences and constraints, and other properties such as the location of online documentation. This information has to be provided in the form of **XCDL** metadata files. XCDL is short for **eXtensible Component Definition Language**, and is specifically designed as a way of describing configuration options.

A typical package contains the following:

1.  some number of source files which will end up in a project; some source files may serve other purposes, for example to provide a linker script
2.  exported header files which define the interface provided by the package
3.  on-line documentation, for example reference pages for each exported function
4.  some number of test cases, shipped in source format, allowing users to check that the package is working as expected on their particular hardware and in their specific configuration
5.  one or more XCDL files describing the package to the configuration system.

Not all packages need to contain all of these. For example some packages such as device drivers may not provide a new interface, instead they just provide another implementation of an existing interface. However all packages must contain at least one XCDL file that describes the package to the configuration tools.

## Credits

The initial content of this page was based on *Chapter 1. Overview* of *The eCos Component Writer’s Guide*, by Bart Veer and John Dallaway, published in 2001.
