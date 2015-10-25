---
layout: page
permalink: /guide/concepts/
title: XCDL concepts and rationals
author: Liviu Ionescu
---

## Why XCDL?

As the complexity of embedded system grows, it is more and more difficult to manage the complexity of putting together multiple components with lots of dependencies and configuration options.

To address this problem, XCDL defines and implements a component framework, as a collection of tools specifically designed to support **multi-variant cross-building embedded system images** based on reusable components. This component framework is extensible, allowing additional components to be added to the build system at any time.

### Multi-variant

In the XCDL context, _multi-variant_ covers the following:

* multiple processor architectures (like ARM Cortex-M), with multiple sub-architectures (like M3, M4, M0), multiple manufacturer families (like STM32F1, STM32F4), multiple sub-families (like STM32F10x Connectivity Line) and multiple devices (like ST STM32F107VG)
* as an extension to architectures, synthetic architectures, like POSIX, can also be considered targets, mainly used to run test cases;
* multiple hardware platforms (boards, board revisions)
* multiple synthetic run platforms (like OS X, GNU/Linux)
* multiple toolchains (like GCC, LLVM clang)
* multiple build platforms (like OS X, GNU/Linux, Windows)

## Why manage dependencies?

Automatic dependencies management is the first and foremost feature of the XCDL component framework.

Properly defined components, with accurate dependencies, allow to automatically create projects with all required source files and headers, and with all required compile and link options properly set. For example if a configuration refers to the STM32F4-DISCOVERY board, this will refer to the STM32F407VG processor, which will refer to the STM32F4 startup code, which will refer to the CMSIS core code, so all required pieces will fit together without user intervention.

## Why configurability?

The XCDL component framework places a great deal of emphasis on configurability.

### Reusability

The fundamental goal is to allow large parts of embedded applications to be constructed from generic reusable software components, which need to be adjusted to fit together and to meet existing constraints.

### Memory constraints

Many embedded applications have to work with limited memory, to keep down manufacturing costs. The component framework must allow users to configure the components so that any unnecessary functionality gets removed, for RAM (and sometimes Flash) usage to be kept to a minimum.

### Debugging

Embedded systems tend to be difficult to debug. The reusable components can provide debugging assistance in various ways. Allowing users to control which debugging features are enabled for any given application build is very desirable.

## Approaches to configurability

The purpose of configurability is to control the behavior of components and the relationships between components. The component writer includes as many different behaviours as possible, but has no way of knowing in advance exactly how a particular component will end up being used. When an application uses a component there must be some way of specifying the desired behavior.

### Run-time

One way to control the behavior is at **run time**. There is of course a major disadvantage in terms of the size of the final application image: the code that gets linked with the application has to provide support for all possible behavior cases, even if the application does not require it.

### Link-time

Another approach is to control the behavior at **link time**, typically by using inheritance in an object-oriented language and linking only one instance of the implementation.

### Compile-time

The XCDL component framework allows the behavior of components to be controlled at an even earlier time: when the component source code gets compiled.

In theory, **compile-time** configurability should give the best possible results in terms of code size, because it allows code to be controlled at the individual statement level rather than at the function or object level. **The overall result is that the final application image contains only the code and data that is really needed for the application to work, and nothing else**.

Compile-time configurability is not intended to replace the other approaches but rather to complement them.

There will be times when run-time selection of behavior is desirable: for example an application may need to be able to change the baud rate of a serial line, and the system must then provide a way of doing this at run-time. There will also be times when link-time selection is desirable.

## Terminology

The XCDL component architecture involves a number of key concepts, presented below.

### Components

A **component** is a generic unit of functionality, usually containing a number of related files and configuration data. More details in the Components sub-section below.

### Packages

A **package** is the unit of distribution of components. It includes one or more related components.

A typical package contains the following:

*  some number of source files which will end up compiled in the project; some files may serve other purposes, for example to provide a linker script
*  exported header files which define the interface provided by the package
*  on-line documentation, for example reference pages for each exported function
*  some number of test cases, shipped in source format, allowing users to check that the package is working as expected on their particular hardware and in their specific configuration
*  one or more XCDL metadata files describing the package to the configuration tools.

Not all packages need to contain all of these. For example some packages such as device drivers may not provide a new interface, instead they just provide another implementation of an existing interface. However **all packages must contain at least one XCDL metadata file** that describes the package to the configuration tools.

It is possible to create a binary distribution file for a package containing all of the source code, header files, documentation, and other relevant files.

More details in the Packages section below and in the separate [XCDL Packages]({{ site.baseurl }}/guide/packages/) section.

### Component framework

The expression **component framework** is used to describe the collection of tools that allow application developers to configure a build system and manage a collection of components (usually organised in one or more component repositories).

#### Portability

Portability is a mandatory requirement, all tools must be able to run on all primary desktop environments, like Windows, OS X and GNU/Linux.

#### Reference implementation

The reference implementation will include one or more Eclipse plug-ins as graphical configuration tools, and one or more command line tools for non graphical environments.

### Component repositories

Generally a **component repository** is a managed collection of packages.

The component framework must be able to manage multiple component repositories at a time.

Physically a component repository is a hierarchy of folders, with the folders usually directly mapping the hierarchy of packages.

The component framework includes tools that allows new packages or new versions of a package to be installed, old packages to be removed, and so on. The component repository includes special files, maintained by the administration tool, which contain details of the various registered packages.

#### Read-only

To preserve components integrity, the component repository is treated as a read-only resource that can be shared by multiple projects and multiple users. Application developers are not allowed to modify anything inside the component repository and build tools should involve separate build and install trees.

Usually application developers install packages by unpacking binary archives, downloaded from http/ftp servers.

#### Read-write

However, component writers need to modify files directly in the component repository. To simplify the development, the component framework should directly accept to register local folder structures, containing the source code and metadata used to build the packages.

Usually component writers install packages by cloning one or more Git repositories (one main repository with multiple submodules linked to it, one for each package).

## XCDL metadata

The configuration tools require information about the various options provided by each package, their consequences and constraints, and other properties such as the location of online documentation. This information has to be provided in the form of **XCDL** metadata files. XCDL is short for **eXtensible Component Definition Language**, and is specifically designed as a way of describing configuration options.

### XCDL objects & hierarchy

The XCDL definition language includes several objects used to define all the configuration details.

The XCDL objects are organised hierarchically, from option object up to the repository object.

Each XCDL object has an unordered map of properties (similar to JSON definitions), to define the source files, various configuration details, build settings, dependencies, etc.

#### Hierarchy

Except the root node, all XCDL objects have a single parent; in other words the nodes can be represented as a tree.

Except leaf nodes, all XCDL objects also have an ordered array of children.

#### Node name

Each node has a property called `name`. Names are short strings, and must follow the following rules:

* be unique for a given parent
* be accepted as POSIX file/folder name; this means letters, figures, and very few special characters, like `[-_.]`; for multi-word names, `-` (dash) is the preferred separator; `.` is used in version names.

For XML configuration files, the node names are defined with the `name="xyz"` XML attribute (actually the only XML attribute to be used).

    <component name="RCC">
      ...
    </component>

When represented in a GUI, the node name is the string permanently displayed to identify the node.

#### Node type

Each node must have a property called `type`, which is a represented by a string.

The node type defines the acceptable properties and children.

When represented in a GUI, the node type defines the icon associated with the node.

#### Node description

Each node must have a property called `description`. Descriptions are reasonable long strings.

    <component name="RCC">
      <description>Real-Time Clock Control</description>
      ...
    </component>

When represented in a GUI, the node description is generally shwown as tooltip, when the mouse hovers over the node, or in additional views showing all node details.

#### Node children

If a node has children, they are grouped as an array of nodes.

    <component name="HAL">
      ...
      <children>
        <component name="RCC">
          ...
        </component>
      </children>
    </component>

#### XCDL paths

Similar to files in a filesystem, XCDL nodes can be addressed as a sequence of slash separated node names:

    /ilg/STM32/F4/HAL/RCC

Addressing nodes can be done with:

* complete paths, if they start with `/`; they are similar to absolute file system paths;
* incomplete paths, if they do not start with `/`

Incomplete paths are searched:

* in the current node children
* in the current node siblings
* in the current node parents
* ? (to be further defined)



### Options

The **option** is the basic unit of configurability.

#### Single choice

Typically each option corresponds to a single choice that a user can make. For example there may be an option to control whether or not assertions are enabled, and the RTOS may provide an option corresponding to the number of scheduling priority levels in the system. Options can control very small amounts of code such as whether or not a function gets inlined. They can also control quite large amounts of code, for example whether or not the tracing supports is enabled or not.

Many options are straightforward, and the user only gets to choose whether the option is enabled or disabled. Some options are more complicated, and have values, for example the number of scheduling priority levels is a number that should be within a certain range.

#### Sensible defaults

Options should always start off with a sensible default setting, so that it is not necessary for users to make hundreds of decisions before any work can start on developing the application. Once the application is running the various configuration options can be used to tune the build for the specific needs of the application.

#### Read-only

The component framework allows for options that are not directly user-modifiable. Consider the case of processor endianness: some processors are always big-endian or always little-endian, while with other processors there is a choice. Depending on the user’s choice of target hardware, endianness may or may not be user-modifiable.

#### Hierarchy

Options are leafs in the objects hierarchy, with components or packages as parents. Options cannot include other children objects.

#### Active/inactive

Options can be *active/inactive*. Inactive options are shown as grey in the interface, and the user cannot enable/disable them, or change the value for options with attached data. An option is automatically inactive if its parent component is inactive or disabled.

#### Enabled/disabled

Active options can be *enabled/disabled* by users, usually via a graphical tool. Simple options are boolean, and the enable/disable status is also the value associated with them. More complex options can have different types, and values according to these types.

### Components

A **component** is a unit of functionality such as a particular RTOS scheduler or a device driver for a specific device. A component is also a configuration option in that users may want to enable or disable all the functionality of a component. For example, if a particular device on the target hardware is not going to be used by the application, directly or indirectly, then there is no point in having a device driver for it. Furthermore disabling the device driver should reduce the memory requirements for both code and data.

#### Hierarchy

Components may contain further configuration objects. In the case of a device driver, there may be options to control the exact behavior of that driver. These will of course be irrelevant if the driver as a whole is disabled. More generally options and components live in a hierarchy, where any component or package can contain options specific to that component and further sub-components.

#### Active/inactive

Components can be *active/inactive*. Inactive components are shown as grey in the interface, and the user cannot enable/disable them, or change the value if not boolean. A component is automatically inactive if its parent component is inactive or disabled.

#### Enabled/disabled

Active components can be *enabled/disabled* by users, usually via a graphical tool, similar to options. More complex options can have different types, and values according to these types.

### Packages

A package is a special type of component. Specifically, a package is the unit of distribution of components.

If the package is distributed as a binary file, it can be unpacked and installed (added to the components repository) using the appropriate tool. Afterwards it is possible to uninstall that package, or to install a later version.

#### Loaded/unloaded

Packages can be *loaded* or *not loaded*. Generally, for a given configuration, it makes no sense for the tools to load the details of every single package that has been installed. For example, if the target board explicitly requires to use the STM32F407VG processor, then there is no point in loading packages for other processors and displaying choices to the user which are not relevant. Therefore *loading* a package means loading its configuration data into the appropriate tool, and making it available for user choices (for example showing it in the graphical user interface); a package not loaded by a configuration simply does not exist for that configuration, and none of its resources can be used.

Selecting which packages are loaded is the first step of the configuration wizard, as a mandatory step to select the target processor and possibly board.

#### Versioning

For repeatability reasons it is required for some packages to depend on a specific version of a package. For this to work it must be possible to select the particular version of a package that should be loaded. Since multiple different packages may depend each on a different versions of a package, multiple versions of the same package must be available to the component framework at the same time.

#### Hierarchy

Packages can also be organised hierarchically, and loading of a package automatically loads all parent packages, up to the repository root.

#### Core distribution

The core distribution may come with a number of packages such as CMSIS, startup files, the RTOS, debug infrastructure. Other packages such as network stacks can come from various different sources and can be installed alongside the core distribution upon request.

### Configurations

A **configuration** is a persistent collection of user choices, applied on top of a collection of choices made by the component designer. The various tools that make up the component framework deal with configurations. Users can create a new configuration, manage a configuration, and use a configuration to generate a build tree prior to building an artefact (application or library). A configuration includes details such as which packages are loaded, plus finer-grained information such as which options in those packages have been enabled or disabled by the user and what values were assigned to typed versions.

### Targets

The **target** is the specific piece of hardware on which the application is expected to run. This may be an off-the-shelf evaluation board, a piece of custom hardware intended for a specific application, or it could be something like a simulator or a synthetic platform. One of the steps when creating a new configuration is the need to select the target. The component framework will map this on to a set of packages that are used to populate the configuration, typically specific startup files, device driver packages, and in addition it may cause certain options to be changed from their default settings to something more appropriate for the specified target.

### Templates

A **template** is a partial configuration, aimed at providing users with an appropriate starting point. XCDL repositories should be shipped with a small number of templates, which correspond closely to common ways of using them.

There is a minimal template which provides very little functionality, just enough to bootstrap the hardware and then jump directly to the application code. The default template adds additional functionality, for example it causes a RTOS and various library packages to be used as well. Creating a new configuration typically involves specifying a template as well as a target, resulting in a configuration that can be built and linked with the application code and that will run on the actual hardware. It is then possible to fine-tune configuration options to produce something that better matches the specific requirements of the application.

### Properties

The component framework needs a certain amount of information about each XCDL object. For example it needs to know what the legal values are, what the default should be, where to find the on-line documentation if the user needs to consult that in order to make a decision, and so on. These are all **properties** of the object. Every object (including components and packages) consists of a name and a set of properties.

### Consequences

As in real life, choices must have consequences. For example for some configurations the main end product is an executable, for others a library, so the consequences of a user choice must affect the build process. This happens in two main ways. First, options can affect which files get built and end up in the executable or library. Second, details of the current option settings get written into various configuration header files using C preprocessor `#define` directives, and package source code can `#include` these configuration headers and adapt accordingly. This allows options to affect a package at a very fine grain, at the level of individual lines in a source file if desired. There may be other consequences as well, for example there are options to control the compiler flags that get used during the build process.

### Constraints

Configuration choices are not independent. The C library can provide thread-safe implementations of functions like `rand()`, but only if the RTOS provides support for per-thread data. This is a constraint: the C library option has a requirement on the RTOS. A typical configuration involves a considerable number of constraints, of varying complexity: many constraints are straightforward, *option A requires option B*, or *option C precludes option D*. Other constraints can be more complicated, for example *option E may require the presence of a RTOS scheduler* but does not care whether it is the bitmap scheduler, the mlqueue scheduler, or something else.

Another type of constraint involves the values that can be used for certain options. For example there is a RTOS option related to the number of scheduling levels, and there is a legal values constraint on this option: specifying zero or a negative number for the number of scheduling levels makes no sense.

### Conflicts

As the user manipulates options it is possible to end up with an invalid configuration, where one or more constraints are not satisfied. For example if RTOS per-thread data is disabled but the C library’s thread-safety options are left enabled then there are unsatisfied constraints, also known as **conflicts**. Such conflicts will be reported by the configuration tools. The presence of some conflicts may prevent users from building the project, but some may not, and in these cases the consequences are undefined: there may be compile-time failures, there may be link-time failures, the application may completely fail to run, or the application may run most of the time but once in a while there will be a strange failure... Typically users will want to resolve all conflicts before continuing.

#### Inference engine

To make things easier for the user, the configuration tools contain an inference engine. This can examine a conflict in a particular configuration and try to figure out some way of resolving the conflict. Depending on the particular tool being used, the inference engine may get invoked automatically at certain times or the user may need to invoke it explicitly. Also depending on the tool, the inference engine may apply any solutions it finds automatically or it may request user confirmation.

## Credits

The initial content of this page was based on *Chapter 1. Overview* of *The eCos Component Writer’s Guide*, by Bart Veer and John Dallaway, published in 2001.
