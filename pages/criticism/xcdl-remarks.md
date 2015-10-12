---
layout: page
permalink: /criticism/xcdl/
title: XCDL remarks and criticism
author: Liviu Ionescu
---

To be fair when compared to eCos and CMSIS Pack, we'll also collect remarks and criticism of XCDL.

## The bad parts

### Complexity

Along with the many features, XCDL also inherits from eCos a good degree of complexity, sometimes demoralising for beginners. Especially understanding the many states of an option (loaded, active, enabled) might be difficult.

### Verbosity

At first look the XCDL files seem pretty verbose, requiring many lines, including a lot of descriptive properties, like *<display>* and *<description>*. However the advantages are seen when using the graphical interface, where these properties belong.

To be noted the deliberate decision to make the generated file names and definitions explicit, instead of resorting to nonintuitive default settings, derived from the preprocessor definition, like in eCos.