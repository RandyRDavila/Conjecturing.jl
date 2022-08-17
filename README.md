# Conjecturing.jl


[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)
[![ColPrac: Contributor's Guide on Collaborative Practices for Community Packages](https://img.shields.io/badge/ColPrac-Contributor's%20Guide-blueviolet)](https://github.com/SciML/ColPrac)
<!-- [![PkgEval](https://JuliaCI.github.io/NanosoldierReports/pkgeval_badges/G/GraphInvariants.svg)](https://JuliaCI.github.io/NanosoldierReports/pkgeval_badges/report.html) -->

## Overview
Conjecturing.jl is general automated conjecturing package currently in development that gives users the ability to produce conjectured relationships between invariants on a given type of mathematical object. To make conjectures you will need a ```data.csv``` file of precomputed invariant (and boolean data if you wish) data. The columns of ```data.csv``` should be the names of the invariants together with any optional boolean property names; exactly one column called "name" containing the names of each instance of the objects is also required. 

The rows of ```data.csv``` are the instances of your objects. As an example, this package comes with precomputed example databases of mathematical values. This data is stored in the ```graph_data.csv``` file, the ```matrix_data.csv``` file, and the ```integer_data.csv``` file. These file contain precomputed numerical and boolean values on simple connected graphs, square matrices, and positive integers, respectively. Please see the examples directory for scripts conjecturing on each of these small datasets.  


## Installation
Currently, *Conjecturing.jl* is not a registered Julia package. However, you may install it with the Julia package manager by running:

```Julia
pkg> add https://github.com/RandyRDavila/Conjecturing.jl

```

## Basic use

If you would like to conjecture on a specific column contained in your ```data.csv``` file:

```Julia
conjs = conjecture(
    "data.csv",
    "<name of invariant to conjecture on>",
    "<name of the type of object>",
    types = types_of_obects_values, # A dictionary (see examples directory)
)

```

If you would like to conjecture on a random column contained in your ```data.csv``` file:

```Julia
random_conjs = random_conjecture(
    "data.csv",
    "<name of the type of object>",
    types = types_of_obects_values, # A dictionary (see examples directory)
)
```


